package com.insure.rfq.login.controller;

import com.insure.rfq.login.dto.AuthenticationDto;
import com.insure.rfq.login.dto.RefreshAuthDto;
import com.insure.rfq.login.dto.UserInfo;
import com.insure.rfq.login.service.JwtService;
import com.insure.rfq.login.service.UserJwtAuthenticationService;
import com.insure.rfq.login.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/user")
@Slf4j
public class UserLoginController {



	private JwtService jwtService;
	private UserJwtAuthenticationService userJwtAuthenticationService;

	private UserJwtAuthenticationService authenticationService;

	private BCryptPasswordEncoder bCryptPasswordEncoder;

	private static final Logger Log = LoggerFactory.getLogger(UserLoginController.class);


	private UserService userService;

	public UserLoginController(JwtService jwtService, UserJwtAuthenticationService userJwtAuthenticationService, UserJwtAuthenticationService authenticationService, BCryptPasswordEncoder bCryptPasswordEncoder, UserService userService) {
		this.jwtService = jwtService;
		this.userJwtAuthenticationService = userJwtAuthenticationService;
		this.authenticationService = authenticationService;
		this.bCryptPasswordEncoder = bCryptPasswordEncoder;
		this.userService = userService;
	}



	@PostMapping("/authenticate")
	@ResponseStatus(value = HttpStatus.OK)
	public UserInfo getValidToken(@RequestBody AuthenticationDto authentication) {

		return userJwtAuthenticationService.getAuthenticated(authentication);

	}

	@PostMapping("/refreshToken")
	@ResponseStatus(value = HttpStatus.OK)
	public UserInfo getRefreshedToken(@RequestBody RefreshAuthDto authDto) {
		log.info(" process of retrive refresh token started ");
		return userJwtAuthenticationService.getAuthenticatedRefreshToken(authDto);
	}
}
