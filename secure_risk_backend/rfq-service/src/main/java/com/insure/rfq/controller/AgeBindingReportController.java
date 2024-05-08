package com.insure.rfq.controller;

import com.insure.rfq.dto.CoverageDetailsDto;
import com.insure.rfq.entity.CoverageDetailsEntity;
import com.insure.rfq.generator.AgeBindingReportPdfGenerator;
import com.insure.rfq.repository.CoverageDetailsRepository;
import com.itextpdf.text.DocumentException;
import jakarta.servlet.http.HttpServletResponse;
import org.modelmapper.ModelMapper;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.Optional;

@RestController
@RequestMapping("/rfq")
@CrossOrigin(origins = "*")
public class AgeBindingReportController {

	private AgeBindingReportPdfGenerator pdfGenerator;

	private ModelMapper mapper;


	private CoverageDetailsRepository coverageDetailsRepository;

	public AgeBindingReportController(AgeBindingReportPdfGenerator pdfGenerator, ModelMapper mapper, CoverageDetailsRepository coverageDetailsRepository) {
		this.pdfGenerator = pdfGenerator;
		this.mapper = mapper;
		this.coverageDetailsRepository = coverageDetailsRepository;
	}

	@GetMapping("/getAgebandingReport/{id}")
	public ResponseEntity<?> generatePdf(HttpServletResponse response, @PathVariable String id)
			throws IOException, DocumentException {
		Optional<CoverageDetailsEntity> coverageDetailsOptional = coverageDetailsRepository.findByRfqId(id);

		if (coverageDetailsOptional.isPresent()) {
			CoverageDetailsEntity coverageDetails = coverageDetailsOptional.get();

			String empDepDataFilePath = coverageDetails.getEmpDepDataFilePath();

			if (empDepDataFilePath != null && !empDepDataFilePath.isEmpty()) {
				byte[] pdf = pdfGenerator.generatePdf(mapper.map(coverageDetails, CoverageDetailsDto.class));
				HttpHeaders headers = new HttpHeaders();
				headers.setContentType(MediaType.APPLICATION_PDF);
				headers.setContentDispositionFormData("attachment", "age_binding_report.pdf");
				return new ResponseEntity<>(pdf, headers, HttpStatus.OK);
			} else {
				return new ResponseEntity<>("data not available", HttpStatus.NO_CONTENT);
			}
		} else {
			return new ResponseEntity<>("data not found", HttpStatus.NOT_FOUND);
		}
	}

}
