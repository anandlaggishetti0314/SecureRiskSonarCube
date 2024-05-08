package com.insure.rfq.controller;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.insure.rfq.dto.GetClientListPolicyDto;
import com.insure.rfq.dto.PolicyDto;
import com.insure.rfq.service.PolicyService;

import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/rfq/policy")
@CrossOrigin("*")
@Slf4j
public class PolicyController {


	private PolicyService policyServiceImpl;

	private final ObjectMapper objectMapper;

	public PolicyController(PolicyService policyServiceImpl, ObjectMapper objectMapper) {
		this.policyServiceImpl = policyServiceImpl;
		this.objectMapper = objectMapper;
	}


	@PostMapping("/addPolicy")
	@ResponseStatus(value = HttpStatus.CREATED)
	public String saveEntity(@ModelAttribute PolicyDto policyDto, @RequestParam Long clientId,
			@RequestParam Long productId) {

		return policyServiceImpl.createPolicyData(policyDto, clientId, productId);

	}

	@GetMapping("/getAllPolicys")
	@ResponseStatus(value = HttpStatus.OK)
	public List<GetClientListPolicyDto> getAllPloicDto() {
		return policyServiceImpl.getAllPolicyEntities();
	}
	@GetMapping("/getAPolicy")
	@ResponseStatus(value = HttpStatus.OK)
	public  GetClientListPolicyDto getClientListPolicy( @RequestParam Long clientId,
													   @RequestParam Long productId) {
		return  policyServiceImpl.getByProductAndClientId(clientId,productId);
	}
	@GetMapping("/downloadpptpath")
	public ResponseEntity<byte[]> downloadpptpath(@RequestParam Long clientId,
														@RequestParam Long productId) {
		log.info("Client id: {} and Product id: {}", clientId, productId);
		try {
			byte[] downloadMandateLetter = policyServiceImpl.downloadpptpath(clientId, productId);

			if (downloadMandateLetter != null && downloadMandateLetter.length > 0) {
				HttpHeaders headers = new HttpHeaders();
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				headers.setContentDispositionFormData("attachment", "pptpath.pdf");
				return new ResponseEntity<>(downloadMandateLetter, headers, HttpStatus.OK);
			} else {
				return new ResponseEntity<>(HttpStatus.NO_CONTENT);
			}
		} catch (FileNotFoundException e) {
			log.error("File not found", e);
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		} catch (IOException e) {
			log.error("IO Exception occurred", e);
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	@GetMapping("/downloadpolicyCopyPath")
	public ResponseEntity<byte[]> downloadPolicyCopyPtha(@RequestParam Long clientId,
														@RequestParam Long productId) {

		try {
			byte[] downloadMandateLetter = policyServiceImpl.downloadpolicyCopyPath(clientId, productId);

			if (downloadMandateLetter != null && downloadMandateLetter.length > 0) {
				HttpHeaders headers = new HttpHeaders();
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				headers.setContentDispositionFormData("attachment", "policyCopypath");
				return new ResponseEntity<>(downloadMandateLetter, headers, HttpStatus.OK);
			} else {
				return new ResponseEntity<>(HttpStatus.NO_CONTENT);
			}
		} catch (FileNotFoundException e) {
			log.error("File not found", e);
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		} catch (IOException e) {
			log.error("IO Exception occurred", e);
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}
