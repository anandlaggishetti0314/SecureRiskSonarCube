package com.insure.rfq.controller;

import com.insure.rfq.dto.ClientListAppAccessStatusDto;
import com.insure.rfq.dto.ClientLoginDto;
import com.insure.rfq.dto.GetAllAppAccessDto;
import com.insure.rfq.dto.UpdateAppAccessDto;
import com.insure.rfq.service.ClientListAppAccessService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("/clientList/appAccess")
@CrossOrigin(origins = "*")
public class ClientListAppAccessController {

	private ClientListAppAccessService clientListAppAccessService;

	public ClientListAppAccessController(ClientListAppAccessService clientListAppAccessService) {
		this.clientListAppAccessService = clientListAppAccessService;
	}

	@PostMapping("/uploadAccessData")
	public ResponseEntity<String> uploadAccessData(@ModelAttribute MultipartFile multipartFile,
			@RequestParam Long clientListId, @RequestParam Long productId) throws IOException {
		return new ResponseEntity<>(
				clientListAppAccessService.uploadAppAccessExcel(multipartFile, clientListId, productId),
				HttpStatus.CREATED);
	}

	@PostMapping("/sendLoginCredentialsByEmails")
	public ResponseEntity<String> sendEmail(@RequestBody List<String> employeeEmails) {
		if (clientListAppAccessService.sendLoginCredentials(employeeEmails)) {
			return ResponseEntity.ok("Emails sent successfully");
		} else {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to send emails");
		}
	}

	@GetMapping("/getAllAppAccess")
	public ResponseEntity<List<GetAllAppAccessDto>> getAllAppAccess(@RequestParam Long clientListId,
			@RequestParam Long productId) {
		return ResponseEntity.ok(clientListAppAccessService.getAllAppAccessDto(clientListId, productId));
	}

	@GetMapping("/getAppAccessByAppAccessId")
	public ResponseEntity<GetAllAppAccessDto> getAppAccessByAppAccessId(@RequestParam Long appAccessId) {
		return ResponseEntity.ok(clientListAppAccessService.getAllAppAccessDtoById(appAccessId));
	}

	@PatchMapping("/updateAppAccessByAppAccessId")
	public ResponseEntity<UpdateAppAccessDto> updateAppAccessByAppAccessId(@RequestParam Long appAccessId,
			@RequestBody UpdateAppAccessDto updateAppAccessDto) {
		return ResponseEntity.ok(clientListAppAccessService.updateAppAccessDtoById(appAccessId, updateAppAccessDto));
	}

	@PostMapping("/clientLogin")
	public ResponseEntity<ClientLoginDto> clientLogin(@RequestParam String username, @RequestParam String password) {
		return ResponseEntity.ok(clientListAppAccessService.authenticate(username, password));
	}
	
	@PutMapping("/ChangeAppAccessStatus")
    public ResponseEntity<String> changeAppAccessStatus(@RequestBody List<ClientListAppAccessStatusDto> clientListAppAccessStatusDto) {
        return ResponseEntity.ok(clientListAppAccessService.changeAppAccessStatus(clientListAppAccessStatusDto));
    }

    @DeleteMapping("/deleteAppAccessById")
    public ResponseEntity<String> deleteAppAccessById(@RequestParam Long appAccessId) {
        return ResponseEntity.ok(clientListAppAccessService.deleteAppAccessById(appAccessId));
    }
}
