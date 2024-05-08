package com.insure.rfq.controller;

import com.insure.rfq.dto.AddClientListUserDto;
import com.insure.rfq.dto.ClientListUserDto;
import com.insure.rfq.service.impl.ClientListUserServiceImpl;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequestMapping("/clientList")
@RestController
@CrossOrigin(origins = "*")
public class ClientListUserController {


	private ClientListUserServiceImpl clientListUserServiceImpl;

	public ClientListUserController(ClientListUserServiceImpl clientListUserServiceImpl) {
		this.clientListUserServiceImpl = clientListUserServiceImpl;
	}

	@PostMapping("/addUser/{id}")
	public ResponseEntity<AddClientListUserDto> createClientListUser(
			@Valid @RequestBody AddClientListUserDto clientListUserDto, @PathVariable Long id) {
		AddClientListUserDto createUser = clientListUserServiceImpl.createUser(clientListUserDto, id);
		return new ResponseEntity<>(createUser, HttpStatus.CREATED);
	}

	@GetMapping("/getAllUsers/{id}")
	public ResponseEntity<List<ClientListUserDto>> getAllUsers(@PathVariable Long id) {
		List<ClientListUserDto> allUsers = clientListUserServiceImpl.getAllUsers(id);
		return new ResponseEntity<>(allUsers, HttpStatus.OK);
	}

	@DeleteMapping("/deleteUserByClientListId/{id}")
	public ResponseEntity<String> deleteUserByClientListId(@PathVariable Long id) {
		String deleteClientUserById = clientListUserServiceImpl.deleteClientUserById(id);
		return new ResponseEntity<>(deleteClientUserById, HttpStatus.OK);
	}

	@PutMapping("/updateClientUserById/{uid}")
	public ResponseEntity<ClientListUserDto> updateClientUserById(@PathVariable Long uid,
			@RequestBody ClientListUserDto clientListUserDto) {
		if (clientListUserDto != null) {
			ClientListUserDto updateUserById = clientListUserServiceImpl.updateUserById(uid, clientListUserDto);
			return new ResponseEntity<>(updateUserById, HttpStatus.OK);
		}
		return null;

	}
}
