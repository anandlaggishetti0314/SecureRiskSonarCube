package com.insure.rfq.service.impl;

import com.insure.rfq.entity.ClientListSubmitClaims;
import com.insure.rfq.entity.RequiredDocument;
import com.insure.rfq.repository.ClientListSubmitClaimsRepository;
import com.insure.rfq.service.ClientListSubmitService;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@Service
public class ClientListSubmitImpl implements ClientListSubmitService {


    private final ClientListSubmitClaimsRepository clientListSubmitClaimsRepository;

    public ClientListSubmitImpl(ClientListSubmitClaimsRepository clientListSubmitClaimsRepository) {

        this.clientListSubmitClaimsRepository = clientListSubmitClaimsRepository;
    }

    @Override

    public ClientListSubmitClaims saveRequiredDocument(RequiredDocument documentType, String employeeId,
                                                       MultipartFile file, String userId) throws IOException {

        ClientListSubmitClaims requiredDocumentEntity = new ClientListSubmitClaims();

        requiredDocumentEntity.setDocumentType(documentType);
        requiredDocumentEntity.setEmployeeId(employeeId);
        requiredDocumentEntity.setFileName(file.getOriginalFilename());

        requiredDocumentEntity.setUserDetailsId(userId);

        requiredDocumentEntity.setCreateDate(new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date()));
        requiredDocumentEntity.setRecordStatus("ACTIVE");

        requiredDocumentEntity.setFileData(file.getBytes());

        return clientListSubmitClaimsRepository.save(requiredDocumentEntity);

    }
}
