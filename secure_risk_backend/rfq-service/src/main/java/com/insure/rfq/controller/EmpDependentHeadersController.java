package com.insure.rfq.controller;

import com.insure.rfq.dto.EmpDependentHeaderDto;
import com.insure.rfq.entity.EmpDependentHeaders;
import com.insure.rfq.service.EmpDependentHeaderService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/rfq/header")
@CrossOrigin(origins = "*")
public class EmpDependentHeadersController {
	

	private EmpDependentHeaderService headerService;

	public EmpDependentHeadersController(EmpDependentHeaderService headerService) {
		this.headerService = headerService;
	}

	@PostMapping("/addEmpDepHeader")
	public ResponseEntity<EmpDependentHeaderDto> addHeader(@RequestBody EmpDependentHeaderDto header){
		EmpDependentHeaderDto createHeaders = null;
		if(header != null) {
			createHeaders = headerService.createHeaders(header);
			return new ResponseEntity<>(createHeaders, HttpStatus.CREATED);
		}
		return new ResponseEntity<>(createHeaders, HttpStatus.BAD_REQUEST);
	}
	@GetMapping("/viewEmpDepHeader")
	public ResponseEntity<List<EmpDependentHeaders>> viewHeader(){
		List<EmpDependentHeaders> viewAllHeaders = headerService.viewAllHeaders();
		return new ResponseEntity<>(viewAllHeaders, HttpStatus.OK);
	}
	
	// fetching only standard headers
	@GetMapping("/getAllEmpDependentHeaders")
	public ResponseEntity<List<String>> getAllEmpDependentHeaders(){
		List<String> empDepHeaders = headerService.getAllEmpDependentHeaders();
		return new ResponseEntity<>(empDepHeaders, HttpStatus.OK);
	}
	
}
