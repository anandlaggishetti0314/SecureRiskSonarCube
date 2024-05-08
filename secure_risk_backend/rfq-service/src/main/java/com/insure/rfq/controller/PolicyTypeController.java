package com.insure.rfq.controller;

import com.insure.rfq.dto.PolicyTypeDto;
import com.insure.rfq.service.impl.PolicyTypeServiceImpl;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequestMapping("/policyType")
@RestController
@CrossOrigin(origins = "*")
public class PolicyTypeController {


	private PolicyTypeServiceImpl policyTypeServiceImpl;

	public PolicyTypeController(PolicyTypeServiceImpl policyTypeServiceImpl) {
		this.policyTypeServiceImpl = policyTypeServiceImpl;
	}

	@PostMapping("/addPolicyType/{id}")
	public ResponseEntity<PolicyTypeDto> createPolicyType(@RequestBody PolicyTypeDto policyTypeDto,
			@PathVariable Long id) {
		PolicyTypeDto createPolicy = policyTypeServiceImpl.createPolicy(policyTypeDto, id);
		return new ResponseEntity<>(createPolicy, HttpStatus.CREATED);
	}

	@GetMapping("/getPolicyTypeById/{id}")
	public ResponseEntity<List<String>> getPolicyTypeById(@PathVariable Long id) {
		List<String> policyTypeById = policyTypeServiceImpl.getPolicyTypeById(id);
		return new ResponseEntity<>(policyTypeById, HttpStatus.OK);
	}
}
