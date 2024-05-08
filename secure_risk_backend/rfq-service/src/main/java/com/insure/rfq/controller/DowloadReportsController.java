package com.insure.rfq.controller;


import com.insure.rfq.service.DownloadReportsService;
import jakarta.servlet.http.HttpServletResponse;
import lombok.NoArgsConstructor;
import org.springframework.web.bind.annotation.*;

@CrossOrigin
@RestController
@RequestMapping("/dowloadZip")
@NoArgsConstructor
public class DowloadReportsController {


	private DownloadReportsService pdfService;

	public DowloadReportsController(DownloadReportsService pdfService) {
		this.pdfService = pdfService;
	}

	@GetMapping("/reports")
	public void downloadPdfAsZip(HttpServletResponse response, @RequestParam String rfqId) {
		pdfService.downloadPdfAsZip(response,rfqId);
	}
}
