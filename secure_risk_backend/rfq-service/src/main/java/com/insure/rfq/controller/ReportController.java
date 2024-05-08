package com.insure.rfq.controller;

import com.insure.rfq.generator.ClaimAnalysisReport;
import com.itextpdf.text.DocumentException;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;

@RestController
@RequestMapping("/rfq")
@CrossOrigin(origins = { "*" })
public class ReportController {


	private ClaimAnalysisReport claimAnalysisReport;



	public ReportController(ClaimAnalysisReport claimAnalysisReport) {
		this.claimAnalysisReport = claimAnalysisReport;

	}




	@GetMapping("/getclaimAnalysisReportById/{rfqId}")
	public ResponseEntity<byte[]> dowloadDemoGraph(@PathVariable String rfqId)
			throws IOException, DocumentException {
		byte[] chartImage = claimAnalysisReport.generatePdf(rfqId);

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_PDF);
		headers.setContentDispositionFormData("attachment", "claim_analysis_report.pdf");
		return new ResponseEntity<>(chartImage, headers, HttpStatus.OK);
	}

}
