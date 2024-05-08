package com.wellness.service;

import org.springframework.web.multipart.MultipartFile;

import com.wellness.entities.UserDetails;
import com.wellness.exceptions.InvalidImageFileException;
import com.wellness.payloads.ResetPasswordDTO;
import com.wellness.payloads.UpdateUserDetailsDTO;
import com.wellness.payloads.UserDetailsDTO;

public interface UserDetailsService {
	public String userRegistration(UserDetails userDetails);

	public String verifyOtp(String otp);

	public String userLogin(String email, String password);

	public String forgotPassword(String email);

	public String changePassword(ResetPasswordDTO resetPasswordDTO);

	public UserDetailsDTO viewUserDetails(long userId);

	public String updateUserDetails(UpdateUserDetailsDTO update);

	public UserDetails getUserDetails(long userId);

//	public String updateProfilePicture(MultipartFile file,String email);

//	public byte[] viewProfilePicture(String email);

	byte[] viewProfilePicture(long userId);

	String updateProfilePicture(MultipartFile file, long userId) throws InvalidImageFileException;

}
