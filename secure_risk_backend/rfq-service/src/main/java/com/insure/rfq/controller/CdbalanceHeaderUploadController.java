package com.insure.rfq.controller;

import com.insure.rfq.dto.CdbalanceDisplayDto;
import com.insure.rfq.dto.CdbalanceHeaderMappingDto;
import com.insure.rfq.dto.CdbalanceValueStatus;
import com.insure.rfq.service.CdbalanceHeaderUploadService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartException;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("/rfq/Cd_balanceHeaderUploadController")
@Slf4j
@CrossOrigin(originPatterns = "*")
public class CdbalanceHeaderUploadController {


	private CdbalanceHeaderUploadService cdbalanceHeaderUploadService;

	public CdbalanceHeaderUploadController(CdbalanceHeaderUploadService cdbalanceHeaderUploadService) {
		this.cdbalanceHeaderUploadService = cdbalanceHeaderUploadService;
	}

	@PostMapping("/uploadheaders")
	public ResponseEntity<?> uploadEnrollement(@RequestBody CdbalanceHeaderMappingDto cdbalanceHeaderMappingDto) {
		try {
			CdbalanceHeaderMappingDto result = cdbalanceHeaderUploadService
					.uploadEnrollement(cdbalanceHeaderMappingDto);
			if (result != null) {
				return ResponseEntity.ok(result);
			} else {
				return ResponseEntity.status(HttpStatus.BAD_REQUEST)
						.body("Request body is empty or headers list is null");
			}
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred: " + e.getMessage());
		}
	}

	@PostMapping("/Cd_balanceheaderSave")
	public ResponseEntity<?> saveData(@RequestBody List<CdbalanceValueStatus> cdbalanceValueStatus,
	                                  @RequestParam Long clientId,
	                                  @RequestParam Long productId) {
	    try {
	        // Your existing saveData logic here
	        return ResponseEntity.ok(cdbalanceHeaderUploadService.saveData(cdbalanceValueStatus, clientId, productId));
	    } catch (MultipartException e) {
	        // Handle MultipartException
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST)
	                             .body("Failed to parse multipart request: " + e.getMessage());
	    } catch (Exception e) {
	        // Handle other exceptions
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	                             .body("An unexpected error occurred: " + e.getMessage());
	    }
	}


	 @PostMapping("/Cd_balancevaluevalidation")
	public ResponseEntity<?> uploadFile(@RequestPart MultipartFile multipartFile) throws IOException {

		return  ResponseEntity.ok(cdbalanceHeaderUploadService.validateValuesBased(multipartFile));
	}

	@PostMapping ("/Cd_balanceheaderValidation")
	    public ResponseEntity<?> validations(@RequestPart MultipartFile file)  throws IOException {

	        return  ResponseEntity.ok(cdbalanceHeaderUploadService.validateHeaders(file));
	    }
	@GetMapping("/cd_balanceheadergetDataByClientIdAndProductId")
	public ResponseEntity<?> getData(@RequestParam Long clientId, @RequestParam Long productId) throws IOException {
		return ResponseEntity.ok(cdbalanceHeaderUploadService.getDataformFile(clientId, productId));

	}
	
	@PatchMapping("/updateCdBalanceData")
    public  String  updateCdBalanceData(@RequestBody CdbalanceDisplayDto dto , @RequestParam Long cdbalanceId){
        return  cdbalanceHeaderUploadService.updateCdBalanceData(dto ,cdbalanceId);
    }
	  @DeleteMapping("/deleteCd_balanceheadergetDataById")@ResponseStatus(value =
	  HttpStatus.NOT_FOUND) public String
	  deleteCdbalanceheadergetDataById(@RequestParam Long cdbalanceId){
	  log.info("The cd_balanceId is : {} ", cdbalanceId); return
	  cdbalanceHeaderUploadService.deleteTheCdBalancData(cdbalanceId);
	  
	  }
	 
	
	@GetMapping("/exportExcel")
	@ResponseStatus(value = HttpStatus.NOT_FOUND)
	public ResponseEntity<byte[]> exportExcel(@RequestParam Long clientId, @RequestParam Long productId) {
		log.info(clientId + " -----------" + productId);
		byte[] excelData = cdbalanceHeaderUploadService.generateExcelFromData(clientId, productId);

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		headers.setContentDispositionFormData("attachment", "Premium_Calculator.xlsx");

		return ResponseEntity.ok().contentType(MediaType.APPLICATION_OCTET_STREAM).headers(headers).body(excelData);
	}



}
