package com.insure.rfq.service;

import com.insure.rfq.dto.ClientListEmployeeECashlessDisplayDto;
import com.insure.rfq.dto.ClientListEmployeeECashlessDto;

import java.util.List;

public interface ClientListEmployeeECashlessService {

    public List<ClientListEmployeeECashlessDisplayDto> getAllClientListEmployeeECashlessDtoList();
     public String saveClientListECashless(ClientListEmployeeECashlessDto clientListEmployeeECashlessDto , Long clientId , Long productId, Long employeeId);
}
