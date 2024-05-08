package com.insure.rfq.service.impl;


import com.insure.rfq.dto.ClientListEmployeeSubmitClaimUserDetailsDto;
import com.insure.rfq.entity.ClientList;
import com.insure.rfq.entity.ClientListEmployeeSubmitClaimUserDetails;
import com.insure.rfq.entity.Product;
import com.insure.rfq.exception.InvalidClientList;
import com.insure.rfq.exception.InvalidProduct;
import com.insure.rfq.repository.ClientListEmployeeSubmitClaimUserDetailsrepository;
import com.insure.rfq.repository.ClientListRepository;
import com.insure.rfq.repository.EmployeeRepository;
import com.insure.rfq.repository.ProductRepository;
import com.insure.rfq.service.ClientListEmployeeSubmitClaimUserDetailsService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Service
@Slf4j
public class ClientListEmployeeSubmitClaimUserDetailsServiceImpl implements ClientListEmployeeSubmitClaimUserDetailsService {
    private ProductRepository productRepository;

    private ClientListRepository clientListRepository;

    private ClientListEmployeeSubmitClaimUserDetailsrepository userDetailsrepository;




    public ClientListEmployeeSubmitClaimUserDetailsServiceImpl(ProductRepository productRepository, ClientListRepository clientListRepository, ClientListEmployeeSubmitClaimUserDetailsrepository userDetailsrepository) {
        this.productRepository = productRepository;
        this.clientListRepository = clientListRepository;
        this.userDetailsrepository = userDetailsrepository;

    }

    @Override
    public String saveClientListEmployeeSubmitClaimUserDetailsDto(ClientListEmployeeSubmitClaimUserDetailsDto dto, Long clientID, Long productId, Long employeeId) {

        ClientListEmployeeSubmitClaimUserDetails userDetails = new ClientListEmployeeSubmitClaimUserDetails();

        String message ;
        userDetails.setPatientName(dto.getPatientName());
        userDetails.setEmployeeName(dto.getEmployeeName());
        userDetails.setUhid(dto.getUhid());

        userDetails.setDateOfAdmission(dto.getDateOfAdmission());
        userDetails.setDateOfDischarge(dto.getDateOfDischarge());
        userDetails.setEmployeeId(dto.getEmployeeId());
        userDetails.setEmail(dto.getEmail());
        userDetails.setMobileNumber(dto.getMobileNumber());
        userDetails.setSumInsured(dto.getSumInsured());
        userDetails.setBenificiaryName(dto.getBenificiaryName());
        userDetails.setRelationToEmployee(dto.getRelationToEmployee());
        userDetails.setClaimNumber(dto.getClaimNumber());
        userDetails.setRecordStatus("ACTIVE");
        String  uiid = UUID.randomUUID().toString();
        userDetails.setUserdetailsId(uiid);
        userDetails.setCreatedDate(new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date()));
        if (productId != null) {
            Product product1 = productRepository.findById(productId)
                    .orElseThrow(() -> new InvalidProduct("Product is Not Found"));
            userDetails.setProductId(product1);
        }
        if (clientID != null) {
            ClientList clientList = clientListRepository.findById(clientID)
                    .orElseThrow(() -> new InvalidClientList("ClientList is Not Found"));
            userDetails.setClientListId(clientList);
            userDetails.setRfqId(clientList.getRfqId());
        }
        if (employeeId != null) {
            log.info(" Employee id  {}: ", employeeId);
            userDetails.setEmployeeDataID(String.valueOf(employeeId));
        }
        ClientListEmployeeSubmitClaimUserDetails saveentity = userDetailsrepository.save(userDetails);
        if(saveentity != null){
            message =saveentity.getUserdetailsId();

        }
        else  message = "ClientListEmployee_ECashless Data is Not saved ";

        return message;

    }

    public static ClientListEmployeeSubmitClaimUserDetailsDto mapEntityToDto(ClientListEmployeeSubmitClaimUserDetails entity) {
        ClientListEmployeeSubmitClaimUserDetailsDto dto = new ClientListEmployeeSubmitClaimUserDetailsDto();

        dto.setUserdetailsId(entity.getUserdetailsId());
        dto.setPatientName(entity.getPatientName());
        dto.setEmployeeName(entity.getEmployeeName());
        dto.setUhid(entity.getUhid());
        dto.setDateOfAdmission(entity.getDateOfAdmission());
        dto.setDateOfDischarge(entity.getDateOfDischarge());
        dto.setEmployeeId(entity.getEmployeeId());
        dto.setEmail(entity.getEmail());
        dto.setMobileNumber(entity.getMobileNumber());
        dto.setSumInsured(entity.getSumInsured());
        dto.setBenificiaryName(entity.getBenificiaryName());
        dto.setRelationToEmployee(entity.getRelationToEmployee());
        dto.setClaimNumber(entity.getClaimNumber());

        dto.setRfqId(entity.getRfqId());
        dto.setEmployeeDataID(entity.getEmployeeDataID());

        return dto;
    }

    public List<ClientListEmployeeSubmitClaimUserDetailsDto> getAllClientListEmployeeSubmitClaimUserDetailsDtos() {
        return userDetailsrepository.findAll().stream().map(entity -> {
            return mapEntityToDto(entity);
        }).toList();
    }

}


