package com.insure.rfq.service;

import com.insure.rfq.dto.ClientListEmployeeClaimIntimmationDataDisplayDto;
import com.insure.rfq.dto.ClientListEmployeeClaimIntimmationDto;

import java.util.List;

public interface ClientListEmployeeClaimIntimmationService {

    String  saveClientListEmployeeClaimIntimmation(ClientListEmployeeClaimIntimmationDto clientListEmployeeClaimIntimmationDto, Long clientListId, Long productId, Long employeeId);

    List<ClientListEmployeeClaimIntimmationDataDisplayDto> gClientListEmployeeClaimIntimmation();
}
