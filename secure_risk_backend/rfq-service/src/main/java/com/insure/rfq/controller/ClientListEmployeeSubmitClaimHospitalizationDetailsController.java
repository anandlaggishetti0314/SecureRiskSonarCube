package com.insure.rfq.controller;

import com.insure.rfq.dto.ClientListEmployeeSubmitClaimHospitalizationDetailsDto;
import com.insure.rfq.service.ClientListEmployeeSubmitClaimHospitalizationDetailsService;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/rfq/submit_ClaimHospitalizationDetailsController")
@CrossOrigin("*")

public class ClientListEmployeeSubmitClaimHospitalizationDetailsController {



    private ClientListEmployeeSubmitClaimHospitalizationDetailsService serviceimpl;

    public ClientListEmployeeSubmitClaimHospitalizationDetailsController(ClientListEmployeeSubmitClaimHospitalizationDetailsService serviceimpl) {
        this.serviceimpl = serviceimpl;
    }


    @PostMapping("/createSubmit_ClaimHospitalizationDetails")
    @ResponseStatus(value = HttpStatus.CREATED)
    public String createClientListEmployeeSubmitClaimHospitalizationDetails(@RequestBody ClientListEmployeeSubmitClaimHospitalizationDetailsDto dto, Long clientID, Long productId, Long employeeId) {
        return serviceimpl.crateClientListEmployeeSubmitClaimHospitalizationDetails(dto, clientID, productId, employeeId);
    }

    @GetMapping("/getAllSubmit_ClaimHospitalizationDetails")
    public List<ClientListEmployeeSubmitClaimHospitalizationDetailsDto> getAllClientListEmployeeSubmitClaimHospitalizationDetailsDtos(){
        return  serviceimpl.getAllClientListEmployeeSubmitClaimHospitalizationDetailsDtos();
    }

}

