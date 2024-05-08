package com.insure.rfq.controller;


import com.insure.rfq.dto.ClientListEmployeeClaimIntimmationDataDisplayDto;
import com.insure.rfq.dto.ClientListEmployeeClaimIntimmationDto;
import com.insure.rfq.service.ClientListEmployeeClaimIntimmationService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@CrossOrigin(origins = "*")
@RequestMapping("rfq/ClientListEmployee_Claim_Intimmation")
public class ClientListEmployeeClaimIntimmationController {


    private ClientListEmployeeClaimIntimmationService serviceImpl;

    public ClientListEmployeeClaimIntimmationController(ClientListEmployeeClaimIntimmationService serviceImpl) {
        this.serviceImpl = serviceImpl;
    }


    @PostMapping("/saveClientListEmployee_Claim_Intimmation")
    public  String saveData(@RequestBody ClientListEmployeeClaimIntimmationDto dto, @RequestParam Long clientListId, @RequestParam Long productId, @RequestParam Long employeeId){
        log.info("Dto is {} : clientlistid {} :  productId{} : employeeId{} ",dto , clientListId ,productId ,employeeId);
        return  serviceImpl.saveClientListEmployeeClaimIntimmation(dto, clientListId, productId, employeeId);

    }

    @GetMapping("/getAllClientListEmployee_Claim_Intimmation")
    public List<ClientListEmployeeClaimIntimmationDataDisplayDto> getAllClientListEmployeeClaimIntimmations(){
        return  serviceImpl.gClientListEmployeeClaimIntimmation();
    }



}
