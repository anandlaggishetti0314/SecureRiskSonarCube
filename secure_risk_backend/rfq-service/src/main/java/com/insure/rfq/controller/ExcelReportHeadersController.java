package com.insure.rfq.controller;

import com.insure.rfq.dto.ExcelReportHeadersDto;
import com.insure.rfq.entity.ExcelReportHeaders;
import com.insure.rfq.service.ExcelReportHeadersService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/rfq/header")
@CrossOrigin(origins = { "*" })
public class ExcelReportHeadersController {
	

	private ExcelReportHeadersService headerService;

	public ExcelReportHeadersController(ExcelReportHeadersService headerService) {
		this.headerService = headerService;
	}

	@PostMapping("/addHeader")
	public ResponseEntity<ExcelReportHeadersDto> addHeader(@RequestBody ExcelReportHeadersDto header){
		ExcelReportHeadersDto createHeaders = null;
		if(header != null) {
			createHeaders = headerService.createHeaders(header);
			return new ResponseEntity<>(createHeaders, HttpStatus.CREATED);
		}
		return new ResponseEntity<>(createHeaders, HttpStatus.BAD_REQUEST);
	}
	@GetMapping("/viewHeader")
	public ResponseEntity<ExcelReportHeaders> viewHeader(){
		List<ExcelReportHeaders> viewAllHeaders = headerService.viewAllHeaders();
		return new ResponseEntity(viewAllHeaders, HttpStatus.OK);
	}
}
