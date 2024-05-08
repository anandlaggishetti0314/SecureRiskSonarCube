package com.insure.rfq.service;

import com.insure.rfq.dto.ClientListEmployeeSubmitClaimHospitalizationDetailsDto;

import java.util.List;

public interface ClientListEmployeeSubmitClaimHospitalizationDetailsService {
    String crateClientListEmployeeSubmitClaimHospitalizationDetails
            (ClientListEmployeeSubmitClaimHospitalizationDetailsDto dto ,Long clientID, Long productId,Long employeeId) ;
 List<ClientListEmployeeSubmitClaimHospitalizationDetailsDto> getAllClientListEmployeeSubmitClaimHospitalizationDetailsDtos();
}
