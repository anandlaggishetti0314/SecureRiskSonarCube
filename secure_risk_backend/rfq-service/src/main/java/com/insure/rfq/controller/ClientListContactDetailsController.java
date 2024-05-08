package com.insure.rfq.controller;

import com.insure.rfq.dto.ClientListContactDetailsDto;
import com.insure.rfq.dto.ResponseDto;
import com.insure.rfq.service.ClientListContactDetailsService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/clientList/contactDetails")
@CrossOrigin(origins = "*")
public class ClientListContactDetailsController {

    private ClientListContactDetailsService clientListContactDetailsService;

    public ClientListContactDetailsController(ClientListContactDetailsService clientListContactDetailsService) {
        this.clientListContactDetailsService = clientListContactDetailsService;
    }

    @PostMapping("/createContactDetails")
    public ResponseEntity<ResponseDto> createContactDetails(@Valid @RequestParam Long clientListId, @RequestParam Long productId, @RequestBody ClientListContactDetailsDto clientListContactDetailsDto) {
        try {
            ResponseDto contactDetails = clientListContactDetailsService.createContactDetails(clientListId, productId, clientListContactDetailsDto);
            if (contactDetails.getMessage().contains("Invalid ClientList") || contactDetails.getMessage().contains("Invalid Product")
                    || contactDetails.getMessage().contains("Invalid DesignationId") || contactDetails.getMessage().contains("Invalid Role")) {
                return new ResponseEntity<>(contactDetails, HttpStatus.BAD_REQUEST);
            }
            return new ResponseEntity<>(contactDetails, HttpStatus.CREATED);
        } catch (Exception e) {
            ResponseDto errorResponse = new ResponseDto(e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errorResponse);
        }
    }

    @GetMapping("/getAllContactDetails")
    public ResponseEntity<List<ClientListContactDetailsDto>> getAllContactDetails(@RequestParam Long clientListId, @RequestParam Long productId) {
        return ResponseEntity.ok(clientListContactDetailsService.getAllContactDetails(clientListId, productId));
    }

    @GetMapping("/getContactDetailsByContactId")
    public ResponseEntity<ClientListContactDetailsDto> getContactDetailsByContactId(@RequestParam Long contactId) {
        return ResponseEntity.ok(clientListContactDetailsService.getContactDetailsByContactId(contactId));
    }

    @PatchMapping("/updateContactDetailsByContactId")
    public ResponseEntity<ClientListContactDetailsDto> updateContactDetailsByContactId(@RequestParam Long contactId, @RequestBody ClientListContactDetailsDto clientListContactDetailsDto) {
        return ResponseEntity.ok(clientListContactDetailsService.updateContactDetailsByContactId(contactId, clientListContactDetailsDto));
    }

    @DeleteMapping("/deleteContactDetailsByContactId")
    public ResponseEntity<String> deleteContactDetailsByContactId(@RequestParam Long contactId) {
        return ResponseEntity.ok(clientListContactDetailsService.deleteContactDetailsByContactId(contactId));
    }

}
