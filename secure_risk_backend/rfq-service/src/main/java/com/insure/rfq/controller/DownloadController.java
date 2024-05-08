package com.insure.rfq.controller;

import com.insure.rfq.dto.ClientListCoverageDetailsDto;
import com.insure.rfq.generator.RFQReportPDfGenerator;
import com.insure.rfq.service.CorporateDetailsService;
import com.insure.rfq.service.DownloadService;
import com.itextpdf.text.DocumentException;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("/rfq/download")
@CrossOrigin(value = { "*" })
public class DownloadController {

	private RFQReportPDfGenerator pDfGenerator;


	private DownloadService downloadService;



	private CorporateDetailsService service;

	public DownloadController(RFQReportPDfGenerator pDfGenerator, DownloadService downloadService,  CorporateDetailsService service) {
		this.pDfGenerator = pDfGenerator;
		this.downloadService = downloadService;

		this.service = service;
	}

	@GetMapping("/pdf/{id}")
	public ResponseEntity<byte[]> downloadPdf(@PathVariable String id) {
		byte[] generatePdf = pDfGenerator.generatePdf(id);
		HttpHeaders headers = new HttpHeaders();
		headers.add(HttpHeaders.CONTENT_DISPOSITION, " attachment;filename:data.pdf");
		return ResponseEntity.ok().headers(headers).contentType(MediaType.APPLICATION_PDF).body(generatePdf);

	}

	@GetMapping("/coveragePdf/{rfqId}")
	public ResponseEntity<byte[]> downloadCoveragePdf(@PathVariable String rfqId) throws IOException, DocumentException {
		byte[] generatePdf = downloadService.generateCoverageDetails(rfqId);
		HttpHeaders headers = new HttpHeaders();
		headers.add(HttpHeaders.CONTENT_DISPOSITION, " attachment;filename:data.pdf");
		return ResponseEntity.ok().headers(headers).contentType(MediaType.APPLICATION_PDF).body(generatePdf);
	}

	@GetMapping("/employeeData")
	public ResponseEntity<Resource> downloadEmpDataPdf(@RequestParam String id) {

		byte[] downloadClaimMisc = service.getEmployeeData(id);
		ByteArrayResource resource = new ByteArrayResource(downloadClaimMisc);

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		headers.add(HttpHeaders.CONTENT_DISPOSITION, " attachment;filename:empdata.xlsx");
		return ResponseEntity.ok().headers(headers).contentLength(downloadClaimMisc.length).body(resource);
	}

	@GetMapping("/irda")
	public ResponseEntity<byte[]> downloadIrdaPdf(@RequestParam String rfqId) throws IOException {
		byte[] irdaData = service.getIrdaData(rfqId);
		HttpHeaders headers = new HttpHeaders();
		headers.add(HttpHeaders.CONTENT_DISPOSITION, " attachment;filename:empdata.pdf");
		return ResponseEntity.ok().headers(headers).contentType(MediaType.APPLICATION_PDF).body(irdaData);
	}

	@PostMapping("/clientListCoverage")
	public ResponseEntity<byte[]> downloadClientListCoveragePdf(@RequestParam Long clientListId, @RequestParam Long productId, @RequestBody List<ClientListCoverageDetailsDto> clientListCoverageDetailsDto) throws IOException, DocumentException {
		byte[] generatePdf = downloadService.generateClientListCoverageDetails(clientListId,productId,clientListCoverageDetailsDto);
		HttpHeaders headers = new HttpHeaders();
		headers.add(HttpHeaders.CONTENT_DISPOSITION, " attachment;filename:data.pdf");
		return ResponseEntity.ok().headers(headers).contentType(MediaType.APPLICATION_PDF).body(generatePdf);
	}
}
