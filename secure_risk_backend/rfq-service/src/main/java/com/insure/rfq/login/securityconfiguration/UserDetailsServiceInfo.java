package com.insure.rfq.login.securityconfiguration;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import com.insure.rfq.entity.ClientListAppAccess;
import com.insure.rfq.login.entity.UserRegisteration;
import com.insure.rfq.login.repository.UserRepositiry;
import com.insure.rfq.repository.ClientListAppAccessRepository;

@Component
public class UserDetailsServiceInfo implements UserDetailsService {

	@Autowired
	private UserRepositiry userRepositiry;

	@Autowired
	private ClientListAppAccessRepository clientListAppAccessRepository;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// Check if the user exists in the UserRegisteration table
		Optional<UserRegisteration> userRegisterationOptional = userRepositiry.findByEmail(username);
		if (userRegisterationOptional.isPresent()) {
			return userRegisterationOptional.map(UserDetailsInfo::new)
					.orElseThrow(() -> new UsernameNotFoundException("User not found with email: " + username));
		}

		// If not found, check if the user exists in the ClientListAppAccess table
		Optional<ClientListAppAccess> clientListAppAccessOptional = clientListAppAccessRepository.findByEmail(username);
		if (clientListAppAccessOptional.isPresent()) {
			return clientListAppAccessOptional.map(ClientListAppAccessDetailsInfo::new)
					.orElseThrow(() -> new UsernameNotFoundException("User not found with email: " + username));
		}

		// If user is not found in either table, throw exception
		throw new UsernameNotFoundException("User not found with email: " + username);
	}
}
