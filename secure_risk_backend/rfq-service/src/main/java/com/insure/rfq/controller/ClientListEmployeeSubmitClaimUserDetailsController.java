package com.insure.rfq.controller;

import com.insure.rfq.dto.ClientListEmployeeSubmitClaimUserDetailsDto;
import com.insure.rfq.service.ClientListEmployeeSubmitClaimUserDetailsService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("rfq/clientListEmployee_Submit_Claim_User_Details")
public class ClientListEmployeeSubmitClaimUserDetailsController {


private ClientListEmployeeSubmitClaimUserDetailsService service;

    public ClientListEmployeeSubmitClaimUserDetailsController(ClientListEmployeeSubmitClaimUserDetailsService service) {
        this.service = service;
    }


    @PostMapping("/saveclientListEmployee_Submit_Claim_User_DetailsDto")
public String saveClientListEmployeeSubmitClaimUserDetailsDto(@RequestBody ClientListEmployeeSubmitClaimUserDetailsDto dto , @RequestParam Long clientId, @RequestParam Long productId, @RequestParam Long employeeId) {
 
    return service.saveClientListEmployeeSubmitClaimUserDetailsDto(dto,clientId,productId, employeeId);
}

@GetMapping("/getllClientListEmployeeSubmitClaimUserDetailsDtos")
public List<ClientListEmployeeSubmitClaimUserDetailsDto> getllClientListEmployeeSubmitClaimUserDetailsDtos(){
        return service.getAllClientListEmployeeSubmitClaimUserDetailsDtos();
}


}
