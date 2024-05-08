package com.insure.rfq.controller;

import com.insure.rfq.dto.IntermediaryDetailsDto;
import com.insure.rfq.dto.PolicyCoverageDto;
import com.insure.rfq.repository.IntermediaryDetailsRepository;
import com.insure.rfq.service.IntermediaryDetailsService;
import com.insure.rfq.service.PolicyCoverageService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/rfq/intermediatrydetails")
@CrossOrigin(origins = { "*" })
public class IntermediaryController {

	private IntermediaryDetailsService intermediaryDetailsService;


	private PolicyCoverageService policyCoverageService;

	private IntermediaryDetailsRepository detailsRepository;

	public IntermediaryController(IntermediaryDetailsService intermediaryDetailsService, PolicyCoverageService policyCoverageService, IntermediaryDetailsRepository detailsRepository) {
		this.intermediaryDetailsService = intermediaryDetailsService;
		this.policyCoverageService = policyCoverageService;
		this.detailsRepository = detailsRepository;
	}

	@GetMapping("/getAllIntermediaryDetails")
	public ResponseEntity<?> allIntermediaryDetails() {
		List<IntermediaryDetailsDto> allIntermediaryDetails = intermediaryDetailsService.getAllIntermediaryDetails();
		if (allIntermediaryDetails != null) {
			return new ResponseEntity<>(allIntermediaryDetails, HttpStatus.OK);
		}
		return new ResponseEntity<>("Invalid Policy Terms Data", HttpStatus.BAD_REQUEST);
	}

	@PostMapping("/createCoverageByProductId/{productId}")
	@ResponseStatus(value = HttpStatus.CREATED)
	public PolicyCoverageDto createCoverageByProductId(@PathVariable Long productId,
			@RequestBody PolicyCoverageDto policyCoverageDto) {
		if (policyCoverageDto != null) {
			return policyCoverageService.createCoverageByProductId(productId, policyCoverageDto);
		}
		return null;
	}

	@GetMapping("/getCoveragesByProductId/{productId}")
	@ResponseStatus(value = HttpStatus.OK)
	public List<PolicyCoverageDto> getCoveragesByProductId(@PathVariable Long productId) {
		return policyCoverageService.getCoveragesByProductId(productId);

	}

	@GetMapping("/count")
	public Long getRfqCountByCount() {
		return detailsRepository.countApplicationsByStatus();

	}

	@PatchMapping("/updateCoverage/{coverageId}")
	@ResponseStatus(value = HttpStatus.OK)
	public PolicyCoverageDto upadateCoveragesByProductId(@PathVariable Long coverageId,
			@RequestBody PolicyCoverageDto coverageDto) {
		return policyCoverageService.updateCoveragesByProductId(coverageId, coverageDto);

	}

	@DeleteMapping("/deleteCoverage/{coverageId}")
	@ResponseStatus(value = HttpStatus.OK)
	public String deleteCoverageByProductId(@PathVariable Long coverageId) {
		return policyCoverageService.deleteCoveragesByProductId(coverageId);
	}

}
