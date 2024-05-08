package com.insure.rfq.service.impl;

import com.insure.rfq.dto.ClientListEmployeeSubmitClaimHospitalizationDetailsDto;
import com.insure.rfq.entity.ClientList;
import com.insure.rfq.entity.ClientListEmployeeSubmitClaimHospitalizationDetails;
import com.insure.rfq.entity.Product;
import com.insure.rfq.exception.InvalidClientList;
import com.insure.rfq.exception.InvalidProduct;
import com.insure.rfq.repository.ClientListEmployeeSubmitClaimHospitalizationDetailsRepository;
import com.insure.rfq.repository.ClientListRepository;
import com.insure.rfq.repository.ProductRepository;
import com.insure.rfq.service.ClientListEmployeeSubmitClaimHospitalizationDetailsService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
@Slf4j
public class ClientListEmployeeSubmitClaimHospitalizationDetailsServiceImpl implements ClientListEmployeeSubmitClaimHospitalizationDetailsService {

    private ProductRepository productRepository;

    private ClientListRepository clientListRepository;

    private ClientListEmployeeSubmitClaimHospitalizationDetailsRepository repository;

    public ClientListEmployeeSubmitClaimHospitalizationDetailsServiceImpl(ProductRepository productRepository, ClientListRepository clientListRepository, ClientListEmployeeSubmitClaimHospitalizationDetailsRepository repository) {
        this.productRepository = productRepository;
        this.clientListRepository = clientListRepository;
        this.repository = repository;
    }

    @Override
    public String crateClientListEmployeeSubmitClaimHospitalizationDetails(ClientListEmployeeSubmitClaimHospitalizationDetailsDto dto, Long clientID, Long productId, Long employeeId) {
        ClientListEmployeeSubmitClaimHospitalizationDetails entity = new ClientListEmployeeSubmitClaimHospitalizationDetails();
      String message;
        entity.setUserdetailsId(dto.getUserdetailsId());
        entity.setState(dto.getState());
        entity.setCity(dto.getCity());
        entity.setHospitalName(dto.getHospitalName());
        entity.setHospitalAddress(dto.getHospitalAddress());
        entity.setNatureofIllness(dto.getNatureofIllness());
        entity.setPreHospitalizationAmount(dto.getPreHospitalizationAmount());
        entity.setPostHospitalizationAmount(dto.getPostHospitalizationAmount());
        entity.setTotalAmountClaimed(dto.getTotalAmountClaimed());
        entity.setHospitalizationAmount(dto.getHospitalizationAmount());
        entity.setMedicalExpensesBillNo(dto.getMedicalExpensesBillNo());
        entity.setMedicalExpensesBillAmount(dto.getMedicalExpensesBillAmount());
        entity.setMedicalExpensesBillDate(dto.getMedicalExpensesBillDate());
        entity.setMedicalExpensesRemarks(dto.getMedicalExpensesRemarks());
        entity.setRecordStatus("ACTIVE");
        entity.setCreatedDate(new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date()));
        if (productId != null) {
            Product product1 = productRepository.findById(productId)
                    .orElseThrow(() -> new InvalidProduct("Product is Not Found"));
            entity.setProductId(product1);

        }
        if (clientID != null) {
            ClientList clientList = clientListRepository.findById(clientID)
                    .orElseThrow(() -> new InvalidClientList("ClientList is Not Found"));
            entity.setClientListId(clientList);
            entity.setRfqId(clientList.getRfqId());
        }
        if (employeeId != null) {
            log.info(" Employee id  {}: ", employeeId);
            entity.setEmployeeDataID(String.valueOf(employeeId));
        }
        ClientListEmployeeSubmitClaimHospitalizationDetails saveentity = repository.save(entity);
        if(saveentity != null){
            message = saveentity.getUserdetailsId();

        }
        else  message = "ClientListEmployee_Submit_ClaimHospitalizationDetails Data is Not saved ";

        return message;
   }


    @Override
    public List<ClientListEmployeeSubmitClaimHospitalizationDetailsDto> getAllClientListEmployeeSubmitClaimHospitalizationDetailsDtos() {
        return  repository.findAll().stream().map( entity -> {
            return  mapEntityToDto(entity);
        }).toList();

    }


        public static ClientListEmployeeSubmitClaimHospitalizationDetailsDto mapEntityToDto(ClientListEmployeeSubmitClaimHospitalizationDetails entity) {
            ClientListEmployeeSubmitClaimHospitalizationDetailsDto dto = new ClientListEmployeeSubmitClaimHospitalizationDetailsDto();

            dto.setUserdetailsId(entity.getUserdetailsId());
            dto.setState(entity.getState());
            dto.setCity(entity.getCity());
            dto.setHospitalName(entity.getHospitalName());
            dto.setHospitalAddress(entity.getHospitalAddress());
            dto.setNatureofIllness(entity.getNatureofIllness());
            dto.setPreHospitalizationAmount(entity.getPreHospitalizationAmount());
            dto.setPostHospitalizationAmount(entity.getPostHospitalizationAmount());
            dto.setTotalAmountClaimed(entity.getTotalAmountClaimed());
            dto.setHospitalizationAmount(entity.getHospitalizationAmount());
            dto.setMedicalExpensesBillNo(entity.getMedicalExpensesBillNo());
            dto.setMedicalExpensesBillAmount(entity.getMedicalExpensesBillAmount());
            dto.setMedicalExpensesBillDate(entity.getMedicalExpensesBillDate());
            dto.setMedicalExpensesRemarks(entity.getMedicalExpensesRemarks());

            return dto;
        }


}
