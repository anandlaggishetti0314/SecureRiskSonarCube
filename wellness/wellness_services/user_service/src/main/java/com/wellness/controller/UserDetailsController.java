package com.wellness.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.wellness.entities.Roles;
import com.wellness.entities.UserDetails;
import com.wellness.payloads.LoginDTO;
import com.wellness.payloads.ResetPasswordDTO;
import com.wellness.payloads.UpdateUserDetailsDTO;
import com.wellness.payloads.UserDetailsDTO;
import com.wellness.repo.PresentAddressRepo;
import com.wellness.service.UserDetailsService;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/wellness/user")
@CrossOrigin(origins = "*")
public class UserDetailsController {

	@Autowired
	private UserDetailsService userService;

	@PostMapping("/register")
	public ResponseEntity<Map<String, String>> createUser(@Valid @RequestBody UserDetails userDetails) {
		String messgae = null;
		messgae = "message";
		String userRegistration = userService.userRegistration(userDetails);
		Map<String, String> response = new HashMap<>();
		response.put(messgae, userRegistration);
		return new ResponseEntity<>(response, HttpStatus.OK);
	}

	@PostMapping("/verify/{otp}")
	public ResponseEntity<Map<String, String>> verifyOtp(@PathVariable String otp) {
		String verifyOtp = userService.verifyOtp(otp);
		Map<String, String> response = new HashMap<>();
		response.put("message", verifyOtp);
		return new ResponseEntity<>(response, HttpStatus.CREATED);
	}

	@PostMapping("/login")
	public ResponseEntity<Map<String, Object>> login(@Valid @RequestBody LoginDTO loginpayload) {
		String userLogin = userService.userLogin(loginpayload.getEmail(), loginpayload.getPassword());
		Map<String, Object> map = new HashMap<>();
		map.put("message", userLogin);
		return ResponseEntity.ok().body(map);

	}

	@GetMapping("/viewuser/{userId}")
	public ResponseEntity<UserDetailsDTO> viewUser(@PathVariable long userId) {
		UserDetailsDTO viewUserDetails = userService.viewUserDetails(userId);
		return ResponseEntity.ok().body(viewUserDetails);
	}

	@PutMapping("/updateuserdetails")
	public ResponseEntity<Map<String, Object>> updateUserDetails(@RequestBody UpdateUserDetailsDTO details) {

		String updateUserDetails = userService.updateUserDetails(details);
		Map<String, Object> map = new HashMap<>();
		map.put("message", updateUserDetails);
		return new ResponseEntity<>(map, HttpStatus.OK);

	}

	@PostMapping("/changepassword")
	public ResponseEntity<Map<String, Object>> resetPassword(@RequestBody ResetPasswordDTO resetPasswordDTO) {
		String resetPassword = userService.changePassword(resetPasswordDTO);
		Map<String, Object> map = new HashMap<>();
		map.put("message", resetPassword);
		return ResponseEntity.ok().body(map);
	}

	@PostMapping("/forgotpassword/{email}")
	public ResponseEntity<Map<String, Object>> forgotPassword(@PathVariable String email) {
		String resetPassword = userService.forgotPassword(email);
		Map<String, Object> map = new HashMap<>();
		map.put("message", resetPassword);
		return ResponseEntity.ok().body(map);
	}

	@PostMapping("{userId}/changeprofilepicture")
	public ResponseEntity<Map<String, Object>> changeProfilePicture(@RequestParam("image") MultipartFile file,
			@PathVariable long userId) {
		String reponse = userService.updateProfilePicture(file, userId);
		Map<String, Object> map = new HashMap<>();
		map.put("message", reponse);
		return ResponseEntity.ok().body(map);

	}

	@GetMapping("/getprofilepicture/{userId}")
	public ResponseEntity<byte[]> getProfilePicture(@PathVariable long userId) {
		byte[] viewProfilePicture = userService.viewProfilePicture(userId);
		return ResponseEntity.status(HttpStatus.OK).contentType(MediaType.valueOf("image/png"))
				.body(viewProfilePicture);
	}

	public ResponseEntity<Map<String, String>> addRoles(@RequestBody Roles roles) {
		return null;
	}

}
