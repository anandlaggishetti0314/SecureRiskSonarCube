package com.insure.rfq.service.impl;

import com.insure.rfq.dto.ClientListEmployeeClaimIntimmationDataDisplayDto;
import com.insure.rfq.dto.ClientListEmployeeClaimIntimmationDto;
import com.insure.rfq.entity.ClientList;
import com.insure.rfq.entity.ClientListEmployeeClaimIntimmation;
import com.insure.rfq.entity.Product;
import com.insure.rfq.exception.InvalidClientList;
import com.insure.rfq.exception.InvalidProduct;
import com.insure.rfq.repository.ClientListEmployeeClaimIntimmationrepository;
import com.insure.rfq.repository.ClientListRepository;
import com.insure.rfq.repository.ProductRepository;
import com.insure.rfq.service.ClientListEmployeeClaimIntimmationService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Slf4j
@Service
public class ClientListEmployeeClaimIntimmationServieImpl implements ClientListEmployeeClaimIntimmationService {


    private ProductRepository productRepository;

    private ClientListRepository clientListRepository;

    private ClientListEmployeeClaimIntimmationrepository claimIntimmationrepository;

    public ClientListEmployeeClaimIntimmationServieImpl(ProductRepository productRepository, ClientListRepository clientListRepository, ClientListEmployeeClaimIntimmationrepository claimIntimmationrepository) {
        this.productRepository = productRepository;
        this.clientListRepository = clientListRepository;
        this.claimIntimmationrepository = claimIntimmationrepository;
    }

    @Override
    public String saveClientListEmployeeClaimIntimmation(ClientListEmployeeClaimIntimmationDto dto, Long clientId, Long productId, Long employeeId) {
        log.info("ClientListEmployee_Claim_Intimmation {} \n clientId{}  \n ProductId  :{} ", dto, clientId, productId);
        String message = "";
        ClientListEmployeeClaimIntimmation entityclaimIntimmation = new ClientListEmployeeClaimIntimmation();

        entityclaimIntimmation.setPatientName(dto.getPatientName());
        entityclaimIntimmation.setRelationToEmployee(dto.getRelationToEmployee());
        entityclaimIntimmation.setEmployeeName(dto.getEmployeeName());
        entityclaimIntimmation.setEmailId(dto.getEmailId());
        entityclaimIntimmation.setHospital(dto.getHospital());
        entityclaimIntimmation.setDoctorName(dto.getDoctorName());
        entityclaimIntimmation.setUhid(dto.getUhid());
        entityclaimIntimmation.setEmployeeId(dto.getEmployeeId());
        entityclaimIntimmation.setMobileNumber(dto.getMobileNumber());
        entityclaimIntimmation.setReasonForAdmission(dto.getReasonForAdmission());
        entityclaimIntimmation.setDateOfHospitalisation(dto.getDateOfHospitalisation());
        entityclaimIntimmation.setOtherDetails(dto.getOtherDetails());
        entityclaimIntimmation.setRecordStatus("ACTIVE");
        entityclaimIntimmation.setCreatedDate(new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date()));
        entityclaimIntimmation.setSumInsured(dto.getSumInsured());
        entityclaimIntimmation.setReasonforClaim(dto.getReasonforClaim());
        if (productId != null) {
            Product product1 = productRepository.findById(productId)
                    .orElseThrow(() -> new InvalidProduct("Product is Not Found"));
            entityclaimIntimmation.setProductId(product1);
        }
        if (clientId != null) {
            ClientList clientList = clientListRepository.findById(clientId)
                    .orElseThrow(() -> new InvalidClientList("ClientList is Not Found"));
            entityclaimIntimmation.setClientListId(clientList);
            entityclaimIntimmation.setRfqId(clientList.getRfqId());
        }
        if (employeeId != null) {
            log.info(" Employee id  {}: ", employeeId);
            entityclaimIntimmation.setEmployeeDataID(String.valueOf((employeeId)));
        }

        ClientListEmployeeClaimIntimmation save = claimIntimmationrepository.save(entityclaimIntimmation);
        if (save != null) {
            message = "ClientListEmployee_Claim_Intimmation Data is Saved Successfully";
        } else message = "ClientListEmployee_Claim_Intimmation Data is Not saved ";

        return message;

    }

    @Override
    public List<ClientListEmployeeClaimIntimmationDataDisplayDto> gClientListEmployeeClaimIntimmation() {
        return claimIntimmationrepository.findAll().stream().map(entity -> {
            ClientListEmployeeClaimIntimmationDataDisplayDto dto = new ClientListEmployeeClaimIntimmationDataDisplayDto();
            dto.setClientListEmployeeClaimIntimmation(entity.getClientListEmployeeClaimIntimmationId());
            dto.setPatientName(entity.getPatientName());
            dto.setRelationToEmployee(entity.getRelationToEmployee());
            dto.setEmployeeName(entity.getEmployeeName());
            dto.setEmailId(entity.getEmailId());
            dto.setHospital(entity.getHospital());
            dto.setDoctorName(entity.getDoctorName());
            dto.setUhid(entity.getUhid());
            dto.setEmployeeId(entity.getEmployeeId());
            dto.setMobileNumber(entity.getMobileNumber());
            dto.setReasonForAdmission(entity.getReasonForAdmission());
            dto.setDateOfHospitalisation(entity.getDateOfHospitalisation());
            dto.setOtherDetails(entity.getOtherDetails());
            // Handle null values for Product and ClientList entities
            dto.setProductId(entity.getProductId().getProductId().toString());
            dto.setClientListId(String.valueOf(entity.getClientListId().getCid()));
            dto.setSumInsured(entity.getSumInsured());
            dto.setReasonforClaim(entity.getReasonforClaim());
            dto.setRfqId(entity.getRfqId());
            dto.setEmployeeDataID(entity.getEmployeeDataID()); // Assuming employeeID is a String in your DTO


            return dto;
        }).toList();
    }
}
