package com.insure.rfq.service.impl;

import com.insure.rfq.dto.DeclarationandclaimSubmissionImportantNotesDto;
import com.insure.rfq.dto.ImportantNotesDisplayDto;
import com.insure.rfq.entity.ClientList;
import com.insure.rfq.entity.ClientListEmployeeSubmitClaimUserDetails;
import com.insure.rfq.entity.ClientListSubmissionImportantNotes;
import com.insure.rfq.entity.Product;
import com.insure.rfq.exception.InvalidClientList;
import com.insure.rfq.exception.InvalidProduct;
import com.insure.rfq.repository.ClientListRepository;
import com.insure.rfq.repository.ClientListSubmissionImportantNotesRepository;
import com.insure.rfq.repository.ProductRepository;
import com.insure.rfq.service.ClientListSubmissionImportantNotesService;
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
public class ClientListSubmitClaimImportantNotesServiceImpl implements ClientListSubmissionImportantNotesService {


	private String mainpath;

	private ProductRepository productRepository;

	private ClientListRepository clientListRepository;


	private ClientListSubmissionImportantNotesRepository imortantnotesrepository;

	public ClientListSubmitClaimImportantNotesServiceImpl(@Value("${file.path.coverageMain}")String mainpath, ProductRepository productRepository, ClientListRepository clientListRepository, ClientListSubmissionImportantNotesRepository imortantnotesrepository) {
		this.mainpath = mainpath;
		this.productRepository = productRepository;
		this.clientListRepository = clientListRepository;
		this.imortantnotesrepository = imortantnotesrepository;
	}

	@Override
public String sbmitClaimDeclarationandclaimSubmissionImportantNotesCreation(
			DeclarationandclaimSubmissionImportantNotesDto dto, Long clientId, Long productId, Long employeeId) {
    String message;
    ClientListSubmissionImportantNotes entity = new ClientListSubmissionImportantNotes();
    /* proof_id_Type; id_proof; id_proofUpload */
    entity.setIdproof(dto.getIdproof());
    entity.setProofidType(dto.getProofidType());
    entity.setIdproofUpload(retunFilePath(dto.getIdproofUpload()));
    entity.setRecordStatus("ACTIVE");

    entity.setUserdetailsId(dto.getUserdetailsId());
    String uiid = UUID.randomUUID().toString();
    entity.setDeclarationsubmisssionId(uiid);
    entity.setCreatedDate(new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date()));
    if (productId!= null) {
        Product product1 = productRepository.findById(productId)
               .orElseThrow(() -> new InvalidProduct("Product is Not Found"));
        entity.setProductId(product1);
    }
    if (clientId!= null) {
        ClientList clientList = clientListRepository.findById(clientId)
               .orElseThrow(() -> new InvalidClientList("ClientList is Not Found"));
        entity.setClientListId(clientList);
        entity.setRfqId(clientList.getRfqId());
    }
    if (employeeId!= null) {
        entity.setEmployeeDataID(String.valueOf(employeeId));
    }
    ClientListSubmissionImportantNotes savedEntity = imortantnotesrepository.save(entity);
    message = savedEntity.getUserdetailsId();

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

			log.info(filePath + "      -----------path ......");
			// Return the path of the saved file
			return filePath.toString();
		} catch (IOException e) {
			e.printStackTrace();
			// Handle exception
			return null;
		}
	}

	public ClientListEmployeeSubmitClaimUserDetails mapDtoToEntity(ImportantNotesDisplayDto dto) {
		ClientListEmployeeSubmitClaimUserDetails entity = new ClientListEmployeeSubmitClaimUserDetails();
		// Map the fields from DTO to entity
		entity.setPatientName(dto.getProofidType());
		entity.setEmployeeName(dto.getIdproof());
		// Map other fields as needed
		return entity;
	}

	public ImportantNotesDisplayDto mapEntityToDto(ClientListSubmissionImportantNotes entity) {
		ImportantNotesDisplayDto dto = new ImportantNotesDisplayDto();
		dto.setId(entity.getDeclarationsubmissionimportedDocumentsId());
		dto.setUserdetailsId(entity.getUserdetailsId());
		// Map the fields from entity to DTO
		dto.setProofidType(entity.getProofidType());
		dto.setIdproof(entity.getIdproof());
		dto.setIdproofUpload(entity.getIdproofUpload());
		// Map other fields as needed
		return dto;
	}

	@Override
	public List<ImportantNotesDisplayDto> getAllImportantNotesDisplayDto() {

		return imortantnotesrepository.findAll().stream().map(this::mapEntityToDto).toList();
	}
}
