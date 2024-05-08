package com.insure.rfq.controller;

import com.insure.rfq.dto.ExpiryDetailsDto;
import com.insure.rfq.entity.ExpiryPolicyDetails;
import com.insure.rfq.service.ExpiryDetailsService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/rfq/expiryDetails")
@CrossOrigin(origins = "*")
public class ExpiryDetailsController {


	private ExpiryDetailsService service;

	public ExpiryDetailsController(ExpiryDetailsService service) {
		this.service = service;
	}

	@PostMapping("/createExpiryDetails")
	public ResponseEntity<String> createExpiryDetails(@RequestBody ExpiryDetailsDto expiryDetailsDto) {
		if (expiryDetailsDto != null) {
			String rfqId = service.createExpiryDetails(expiryDetailsDto);
			return new ResponseEntity<>(rfqId, HttpStatus.CREATED);
		}
		return new ResponseEntity<>("No Details Found", HttpStatus.BAD_REQUEST);
	}

	@PutMapping("/updateExpiryDetails/{id}")
	public ResponseEntity<ExpiryPolicyDetails> updateExpiryDetails(@RequestBody ExpiryDetailsDto detailsDto,
			@PathVariable String id) {
		return ResponseEntity.ok(service.updateExpiryDetails(detailsDto, id));
	}

	@GetMapping("/getExpiryDetailsById")
	public ResponseEntity<ExpiryPolicyDetails> getExpiryDetailsById(@RequestParam String rfqId) {
		return new ResponseEntity<>(service.getExpiryDetailsRfqById(rfqId), HttpStatus.OK);
	}
}
