package com.wellness.serviceimpl;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Optional;

import org.modelmapper.ModelMapper;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.wellness.entities.PresentAddress;
import com.wellness.entities.Roles;
import com.wellness.entities.UserDetails;
import com.wellness.exceptions.InvalidEmailException;
import com.wellness.exceptions.InvalidImageFileException;
import com.wellness.exceptions.InvalidPasswordException;
import com.wellness.exceptions.PasswordMisMatchException;
import com.wellness.exceptions.ProfilePictureNotFoundException;
import com.wellness.exceptions.UserNotFoundException;
import com.wellness.payloads.ResetPasswordDTO;
import com.wellness.payloads.UpdateUserDetailsDTO;
import com.wellness.payloads.UserDetailsDTO;
import com.wellness.repo.PresentAddressRepo;
import com.wellness.repo.RolesRepo;
import com.wellness.repo.UserDetailsRepo;
import com.wellness.service.UserDetailsService;
import com.wellness.utils.EmailSender;
import com.wellness.utils.ImageFile;
import com.wellness.utils.ImageNameGenerator;
import com.wellness.utils.PasswordGenerator;
import com.wellness.enums.FolderPath;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {

	@Autowired
	private UserDetailsRepo userRepo;

	@Autowired
	private PresentAddressRepo presentAddressRepo;

	@Autowired
	private RolesRepo rolesRepo;

	@Autowired
	private ModelMapper modelMapper;

	@Autowired
	private ImageFile imageFile;

	@Autowired
	private ImageNameGenerator generator;

	@Override
	public String userRegistration(UserDetails userDetails) {

		Optional<UserDetails> user = userRepo.findByEmail(userDetails.getEmail());
		String message = "user already exist";
		if (user.isEmpty()) {
			String otp = EmailSender.sendOtp(userDetails.getEmail());
			message = "failed to send OTP";
			if (otp != null) {
				userDetails.setOtp(otp);
				UserDetails saveUser = userRepo.save(userDetails);
				PresentAddress address = new PresentAddress();
				address.setCity(userDetails.getCity());
				address.setUserId(userDetails.getUserId());
				PresentAddress saveAddress = presentAddressRepo.save(address);
				if (saveUser != null && saveAddress != null) {
					message = "OTP sent to respected email address";
				}
			}
		} else {
			throw new UserNotFoundException("user already exist with : " + userDetails.getEmail() + "address");
		}

		return message;
	}

	@Override
	public String verifyOtp(String otp) {
		Optional<UserDetails> user = userRepo.findByOtp(otp);
		String message = "register failed";
		if (!user.isEmpty()) {
			message = "enter valid otp";
			if (otp.equals(user.get().getOtp())) {
				UserDetails userDetails = user.get();
				String randomPassword = PasswordGenerator.getRandomPassword();
				userDetails.setPassword(randomPassword);
				userDetails.setOtp("");
				userDetails.setRoleId(2l);
				UserDetails saveUser = userRepo.save(userDetails);
				if (saveUser != null) {
					EmailSender.sendRandomPassword(saveUser.getEmail(), randomPassword);
					message = "register successful";
				}
			}
		}

		return message;
	}

	@Override
	public String forgotPassword(String email) {
		Optional<UserDetails> user = userRepo.findByEmail(email);
		String message = "failed";
		if (!user.isEmpty()) {
			UserDetails userDetails = user.get();
			String randomPassword = PasswordGenerator.getRandomPassword();
			userDetails.setPassword(randomPassword);
			UserDetails saveUser = userRepo.save(userDetails);
			if (saveUser != null) {
				EmailSender.sendRandomPassword(saveUser.getEmail(), randomPassword);
				message = "password sent to respected email address";
			}
		} else {
			throw new InvalidEmailException("invalid email address");
		}
		return message;
	}

	@Override
	public String changePassword(ResetPasswordDTO resetPasswordDTO) {
		Optional<UserDetails> user = userRepo.findByEmail(resetPasswordDTO.getEmail());
		String message = "failed to reset password";
		if (!user.isEmpty()) {
			UserDetails userDetails = user.get();
			if (resetPasswordDTO.getNewPassword().equals(resetPasswordDTO.getConfirmpassword())) {
				userDetails.setPassword(resetPasswordDTO.getConfirmpassword());
				UserDetails updateUser = userRepo.save(userDetails);
				if (updateUser != null) {
					message = "password reset successful";
				}
			} else {
				throw new PasswordMisMatchException("password mismatched");
			}
		} else {
			throw new InvalidEmailException("invalid email address");
		}
		return message;
	}

	@Override
	public String userLogin(String email, String password) {
		return userRepo.findByEmail(email).map(userDetails -> {
			if (userDetails.getPassword().equals(password)) {
				return "login success";
			} else {
				throw new InvalidPasswordException("invalid password");
			}
		}).orElseThrow(() -> new InvalidEmailException("invalid email address"));
	}

	@Override
	public UserDetailsDTO viewUserDetails(long userId) {
		UserDetails user = null;

		user = userRepo.findById(userId)
				.orElseThrow(() -> new UserNotFoundException("user not found with an id : " + userId));
		PresentAddress address = presentAddressRepo.findByUserId(userId).get();
		Roles userRole = rolesRepo.findById((int) user.getRoleId()).get();
		UserDetailsDTO userDetails = modelMapper.map(user, UserDetailsDTO.class);
		userDetails.setPresentAddress(address);
		userDetails.setRoles(userRole);

		return userDetails;
	}

	@Override
	public String updateUserDetails(UpdateUserDetailsDTO updateUserDetails) {

		Optional<UserDetails> user = userRepo.findByEmail(updateUserDetails.getEmail());
		String message = "failed to update";
		if (!user.isEmpty()) {
			UserDetails userDetails = user.get();
			userDetails.setRoleId(1);
			BeanUtils.copyProperties(updateUserDetails, userDetails);
			userRepo.save(userDetails);
			Optional<PresentAddress> userAddress = presentAddressRepo.findByUserId(userDetails.getUserId());
			if (!userAddress.isEmpty()) {
				PresentAddress presentAddress = userAddress.get();
				BeanUtils.copyProperties(updateUserDetails, presentAddress);
				presentAddressRepo.save(presentAddress);
				message = "update successfull";
			}
		}

		return message;
	}

	@Override
	public UserDetails getUserDetails(long userId) {
		return null;
	}

	@Override
	public String updateProfilePicture(MultipartFile file, long userId) throws InvalidImageFileException {
		Optional<UserDetails> user = userRepo.findById(userId);
		if (user.isPresent()) {
			UserDetails userDetails = user.get();
			String timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmssSSS"));
			String randomFileName = timestamp + generator.getFileExtensionName(file.getOriginalFilename());
			String folderPath = FolderPath.INSTANCE.path;
			String filePath = folderPath + randomFileName;
			// Check if the uploaded file is an image
			if (imageFile.isImageFile(file)) {
				// Create the folder if it doesn't exist
				File folder = new File(folderPath);
				if (!folder.exists()) {
					folder.mkdirs();
				}
				try {
					file.transferTo(new File(filePath));
				} catch (IOException e) {
					e.printStackTrace();
				}
				userDetails.setImage(filePath);
				UserDetails updatePhoto = userRepo.save(userDetails);
				if (updatePhoto != null) {
					return "successfull";
				}
			} else {
				throw new InvalidImageFileException("only image files are allowed.");
			}
		}
		return "failed to change photo";
	}

	@Override
	public byte[] viewProfilePicture(long userId) {
		Optional<UserDetails> fileData = userRepo.findById(userId);
		if (fileData.isPresent()) {
			String filePath = fileData.get().getImage();
			if (filePath != null) {
				try {
					return Files.readAllBytes(Paths.get(filePath));
				} catch (IOException e) {
					e.printStackTrace();
				}
			} else {
				throw new ProfilePictureNotFoundException("profile picture not found");
			}
		}
		throw new UserNotFoundException("user not found");
	}

}
