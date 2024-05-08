package com.insure.rfq.controller;

import com.insure.rfq.dto.ClientListFamilyPremiumCalcuaterDto;
import com.insure.rfq.service.ClientListFamilyPremiumCalcuaterService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/rfq/PreFamilyPremium_Calcuater")
@CrossOrigin(origins = "*")
public class ClientListFamilyPremiumCalcuaterController {


    private ClientListFamilyPremiumCalcuaterService premiumCalcuaterServiceimpl;

    public ClientListFamilyPremiumCalcuaterController(ClientListFamilyPremiumCalcuaterService premiumCalcuaterServiceimpl) {
        this.premiumCalcuaterServiceimpl = premiumCalcuaterServiceimpl;
    }

    @PostMapping("/saveClientList_PreFamilyPremium_Calcuater")
    @ResponseStatus(value = HttpStatus.CREATED)
    public String saveClientListPreFamilyPremiumCalcuater(
            @RequestBody ClientListFamilyPremiumCalcuaterDto premiumCalcuaterDto, @RequestParam Long clientId,
            @RequestParam Long productId) {
        log.info(premiumCalcuaterDto + "  " + clientId + " ===" + productId);

        return premiumCalcuaterServiceimpl.createClientListFamilyPremiumCalcuater(premiumCalcuaterDto, clientId,
                productId);
    }

    @GetMapping("/getAllPremiumCalcuaters")
    @ResponseStatus(value = HttpStatus.OK)
    public List<ClientListFamilyPremiumCalcuaterDto> getAllPremiumCalcuaterDtos(@RequestParam Long clientId,
                                                                                @RequestParam Long productId) {
        return premiumCalcuaterServiceimpl.getAllTheClientListPremiumCalcuaters(clientId, productId);
    }

    @DeleteMapping("/deleteClientList_PreFamilyPremium_Calcuater")
    @ResponseStatus(value = HttpStatus.OK)
    public String deleteClientListPreFamilyPremiumCalcuater(@RequestParam Long primaryId) {
        return premiumCalcuaterServiceimpl.deleteClientListPremiumCalcuaterDto(primaryId);

    }

    @PatchMapping("/updateClientListFamilyPremiumCalcuater")
    @ResponseStatus(value = HttpStatus.OK)
    public  ClientListFamilyPremiumCalcuaterDto updateClientListFamilyPremiumCalcuaterDto(@RequestBody ClientListFamilyPremiumCalcuaterDto dto) {
        return premiumCalcuaterServiceimpl.updateClientListFamilyPremiumCalcuaterDto( dto);
    }
    @GetMapping("/getClientList_PreFamilyPremium_Calcuater")
    @ResponseStatus(value = HttpStatus.OK)
    public ClientListFamilyPremiumCalcuaterDto getClientListPreFamilyPremiumCalcuater(@RequestParam Long primaryId) {
        return premiumCalcuaterServiceimpl.getClientListPremiumCalcuaterDto(primaryId);

    }

    @GetMapping("/exportExcel")
    @ResponseStatus(value = HttpStatus.NOT_FOUND)
    public ResponseEntity<byte[]> exportExcel(@RequestParam Long clientId,
                                              @RequestParam Long productId) {
        log.info(clientId + " -----------" + productId);
        byte[] excelData = premiumCalcuaterServiceimpl.generateExcelFromData(clientId, productId);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.setContentDispositionFormData("attachment", "Premium_Calculator.xlsx");

        return ResponseEntity
                .ok()
                .contentType(MediaType.APPLICATION_OCTET_STREAM)
                .headers(headers)
                .body(excelData);
    }


}
