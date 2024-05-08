package com.insure.rfq.service;


import com.insure.rfq.dto.ClientListEmployeeSubmitClaimUserDetailsDto;

import java.util.List;

public interface ClientListEmployeeSubmitClaimUserDetailsService {

     String saveClientListEmployeeSubmitClaimUserDetailsDto(ClientListEmployeeSubmitClaimUserDetailsDto dto, Long clientID, Long productId, Long employeeId) ;
List<ClientListEmployeeSubmitClaimUserDetailsDto>  getAllClientListEmployeeSubmitClaimUserDetailsDtos();

    }
