package com.insure.rfq.service.impl;


import com.insure.rfq.dto.ClientListEmployeeECashlessDisplayDto;
import com.insure.rfq.dto.ClientListEmployeeECashlessDto;
import com.insure.rfq.entity.ClientList;
import com.insure.rfq.entity.ClientListEmployeeECashless;
import com.insure.rfq.entity.Product;
import com.insure.rfq.exception.InvalidClientList;
import com.insure.rfq.exception.InvalidProduct;
import com.insure.rfq.repository.ClientListEmployeeECashlessRepository;
import com.insure.rfq.repository.ClientListRepository;
import com.insure.rfq.repository.EmployeeRepository;
import com.insure.rfq.repository.ProductRepository;
import com.insure.rfq.service.ClientListEmployeeECashlessService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;


@Service
@Slf4j
public class ClientListEmployeeECashlessServiceImpl implements ClientListEmployeeECashlessService {

    private String mainpath;
    private ProductRepository productRepository;
    private ClientListRepository clientListRepository;
    private ClientListEmployeeECashlessRepository eCashlessRepository;




    public ClientListEmployeeECashlessServiceImpl( @Value("${file.path.coverageMain}")String mainpath, ProductRepository productRepository, ClientListRepository clientListRepository, ClientListEmployeeECashlessRepository eCashlessRepository) {
        this.mainpath = mainpath;
        this.productRepository = productRepository;
        this.clientListRepository = clientListRepository;
        this.eCashlessRepository = eCashlessRepository;

    }


    @Override
    public String saveClientListECashless(ClientListEmployeeECashlessDto dto, Long clientID, Long productId, Long employeeId) {
        String message = "";
        // Assuming you have necessary imports and logger instance (log)

        ClientListEmployeeECashless entityECashless = new ClientListEmployeeECashless();
        entityECashless.setHospitalization(dto.getHospitalization());
        entityECashless.setSearchNetworkHospital(dto.getSearchNetworkHospital());
        entityECashless.setPlannedDateOfAdmission(dto.getPlannedDateOfAdmission());
        entityECashless.setTreatment(dto.getTreatment());
        entityECashless.setFullNameOfYourTreatingDoctor(dto.getFullNameOfYourTreatingDoctor());
        entityECashless.setLatestInvestigationReportsOfYourDiagnosis(retunFilePath( dto.getLatestInvestigationReportsOfYourDiagnosis()));
        entityECashless.setLastDoctorConsultationNote(retunFilePath( dto.getLastDoctorConsultationNote()));
        entityECashless.setPatientIdentityNumber(dto.getPatientIdentityNumber());
        entityECashless.setPatientIdentityProof(retunFilePath( dto.getPatientIdentityProof() ));
        entityECashless.setOtherMedicalDocuments(retunFilePath(dto.getOtherMedicalDocuments()));
        entityECashless.setMobileNumber(dto.getMobileNumber());
        entityECashless.setRoomType(dto.getRoomType());
        entityECashless.setPlannedDateOfDischarge(dto.getPlannedDateOfDischarge());
        entityECashless.setProsedTreatment(dto.getProsedTreatment());
        entityECashless.setOutPatientNumber(dto.getOutPatientNumber());
        entityECashless.setRecordStatus("ACTIVE");
        entityECashless.setCreatedDate(new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date()));
        if (productId != null) {
            Product product1 = productRepository.findById(productId)
                    .orElseThrow(() -> new InvalidProduct("Product is Not Found"));
            entityECashless.setProductId(product1);
        }
        if (clientID != null) {
            ClientList clientList = clientListRepository.findById(clientID)
                    .orElseThrow(() -> new InvalidClientList("ClientList is Not Found"));
            entityECashless.setClientListId(clientList);
            entityECashless.setRfqId(clientList.getRfqId());
        }
        if(employeeId != null){
            log.info(" Employee id  {}: ", employeeId);
            entityECashless.setEmployeeID(String.valueOf(employeeId));
        }

        ClientListEmployeeECashless save = eCashlessRepository.save(entityECashless);
        if(save != null){
            message = "ClientListEmployee_ECashless Data is Saved Successfully";
        }
        else  message = "ClientListEmployee_ECashless Data is Not saved ";

        return message;

    }
    public String retunFilePath(MultipartFile file) {
        try {
            // Generate a unique file name
            String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();

            // Create the directory if it doesn't exist
            Path directory = Paths.get(mainpath);

            if (!Files.exists(directory)) {
                Files.createDirectories(directory);
            }

            // Save the file to the local machine
            Path filePath = Paths.get(mainpath, fileName);
            Files.copy(file.getInputStream(), filePath);


            // Return the path of the saved file
            return filePath.toString();
        } catch (IOException e) {
            e.printStackTrace();
            // Handle exception
            return null;
        }
    }

    @Override
    public List<ClientListEmployeeECashlessDisplayDto> getAllClientListEmployeeECashlessDtoList() {
        return eCashlessRepository.findAll().stream()
                .map(entity -> {
                    ClientListEmployeeECashlessDisplayDto dto = new ClientListEmployeeECashlessDisplayDto();
                    dto.setHospitalization(entity.getHospitalization());
                    dto.setSearchNetworkHospital(entity.getSearchNetworkHospital());
                    dto.setPlannedDateOfAdmission(entity.getPlannedDateOfAdmission());
                    dto.setTreatment(entity.getTreatment());
                    dto.setFullNameOfYourTreatingDoctor(entity.getFullNameOfYourTreatingDoctor());
                    dto.setLatestInvestigationReportsOfYourDiagnosis(entity.getLatestInvestigationReportsOfYourDiagnosis());
                    dto.setLastDoctorConsultationNote(entity.getLastDoctorConsultationNote());
                    dto.setPatientIdentityNumber(entity.getPatientIdentityNumber());
                    dto.setPatientIdentityProof(entity.getPatientIdentityProof());
                    dto.setOtherMedicalDocuments(entity.getOtherMedicalDocuments());
                    dto.setMobileNumber(entity.getMobileNumber());
                    dto.setRoomType(entity.getRoomType());
                    dto.setPlannedDateOfDischarge(entity.getPlannedDateOfDischarge());
                    dto.setProsedTreatment(entity.getProsedTreatment());
                    dto.setOutPatientNumber(entity.getOutPatientNumber());

                    dto.setProductId(entity.getProductId().getProductId().toString() );
                    dto.setClientListId( String.valueOf(entity.getClientListId().getCid()));

                    dto.setRfqId(entity.getRfqId());
                    dto.setEmployeeID(entity.getEmployeeID()); // Assuming employeeID is a String in your DTO

                    return dto;
                })
                .toList(); // Collect DTOs into a list
    }




}
