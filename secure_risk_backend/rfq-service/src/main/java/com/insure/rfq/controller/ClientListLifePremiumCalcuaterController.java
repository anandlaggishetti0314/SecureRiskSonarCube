package com.insure.rfq.controller;

import java.util.List;

import com.insure.rfq.dto.ClientListLifePremiumCalcuaterDto;
import com.insure.rfq.service.ClientListLifePremiumCalcuaterService;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;



import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/rfq/Pre_Life_Premium_Calcuater")
@CrossOrigin(origins = "*")
@NoArgsConstructor
public class ClientListLifePremiumCalcuaterController {


    private ClientListLifePremiumCalcuaterService service;

    public ClientListLifePremiumCalcuaterController(ClientListLifePremiumCalcuaterService service) {
        this.service = service;
    }

    @GetMapping("/hai")
    public String hai() {
        return "HAi to all";
    }


    @PostMapping("/saveClientList_Pre_LifePremium_Calcuater")
    @ResponseStatus(value = HttpStatus.CREATED)
    public String saveClientListLifePremiumCalcuater(
            @RequestBody ClientListLifePremiumCalcuaterDto premiumCalcuaterDto, @RequestParam Long clientId,
            @RequestParam Long productId) {
        log.info(premiumCalcuaterDto + "  " + clientId + " ===" + productId);

        return service.createClientListLifePremiumCalcuater(premiumCalcuaterDto, clientId,
                productId);
    }

    @GetMapping("/getAll_Life_PremiumCalcuaters")
    @ResponseStatus(value = HttpStatus.OK)
    public List<ClientListLifePremiumCalcuaterDto> getAllLifePremiumCalcuaterDtos(@RequestParam Long clientId,
                                                                                      @RequestParam Long productId) {

        return service.getAllTheClientListLifePremiumCalcuaters(clientId, productId);
    }

    @DeleteMapping("/deleteClientList_Pre_Life_Premium_Calcuater")
    @ResponseStatus(value = HttpStatus.OK)
    public String deleteClientListPreLifePremiumCalcuater(@RequestParam Long primaryId) {
        return service.deleteClientListLifePremiumCalcuaterDto(primaryId);

    }

   @PatchMapping("/updateClientList_Life_PremiumCalcuaterDto")
    @ResponseStatus(value = HttpStatus.OK)
    public ClientListLifePremiumCalcuaterDto updateClientListFamilyPremiumCalcuaterDto(@RequestBody ClientListLifePremiumCalcuaterDto dto) {
        return service.updateClientListLifePremiumCalcuaterDto( dto);
    }
    @GetMapping("/getClientList_Pre_Life_Premium_Calcuater")
    @ResponseStatus(value = HttpStatus.OK)
    public ClientListLifePremiumCalcuaterDto getClientListPreFamilyPremiumCalcuater(@RequestParam Long primaryId) {
        return service.getClientListLifePremiumCalcuaterDto(primaryId);
    }

    @GetMapping("/exportExcel")
    @ResponseStatus(value = HttpStatus.NOT_FOUND)
    public ResponseEntity<byte[]> exportExcel(@RequestParam Long clientId,
                                              @RequestParam Long productId) {
        log.info(clientId + " -----------" + productId);
        byte[] excelData = service.generateExcelFromData(clientId, productId);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.setContentDispositionFormData("attachment", "Premium_Life_Calculator.xlsx");

        return ResponseEntity
                .ok()
                .contentType(MediaType.APPLICATION_OCTET_STREAM)
                .headers(headers)
                .body(excelData);
    }


}
