package com.insure.rfq.service.impl;

import com.insure.rfq.dto.AccountManagerSumInsuredDisplayDto;
import com.insure.rfq.dto.AccountManagerSumInsuredDto;
import com.insure.rfq.entity.AccountManagerSumInsured;
import com.insure.rfq.entity.ClientList;
import com.insure.rfq.entity.Product;
import com.insure.rfq.exception.InvalidClientList;
import com.insure.rfq.exception.InvalidProduct;
import com.insure.rfq.exception.InvalidUser;
import com.insure.rfq.repository.AccountManagerSumInsuredRepository;
import com.insure.rfq.repository.ClientListRepository;
import com.insure.rfq.repository.ProductRepository;
import com.insure.rfq.service.AccountManagerSumInsuredService;
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
public class AccountManagerSumInsuredServiceImpl implements AccountManagerSumInsuredService {


	private final AccountManagerSumInsuredRepository sumInsuredrepository;


	private String mainpath;


	private final ProductRepository productRepository;


	private final ClientListRepository clientListRepository;

	public AccountManagerSumInsuredServiceImpl(AccountManagerSumInsuredRepository sumInsuredrepository, @Value("${file.path.coverageMain}") String mainpath, ProductRepository productRepository, ClientListRepository clientListRepository) {
		this.sumInsuredrepository = sumInsuredrepository;
		this.mainpath = mainpath;
		this.productRepository = productRepository;
		this.clientListRepository = clientListRepository;
	}

	@Override
	public String createAccountManagerSumInsured(AccountManagerSumInsuredDto sumInsuredDto, Long clientListId, Long poductId) {
		String message;
		AccountManagerSumInsured sumInsuredEntity = new AccountManagerSumInsured();
		sumInsuredEntity.setSumInsuredName(sumInsuredDto.getSumInsuredName());
		String filepath = retunFilePath(sumInsuredDto.getSumInsuredFileName());
		sumInsuredEntity.setSumInsuredFileName(filepath);

		if (clientListId!= null) {
			ClientList clientList = clientListRepository.findById(clientListId)
					.orElseThrow(() -> new InvalidClientList("ClientList Not Found"));
			sumInsuredEntity.setRfqId(clientList.getRfqId());
			sumInsuredEntity.setClientListId(clientList);
		}

		if (poductId!= null) {
			try {
				Product product = productRepository.findById(poductId)
						.orElseThrow(() -> new InvalidProduct("Product is not Found"));
				sumInsuredEntity.setProductId(product);
			} catch (InvalidProduct e) {
				throw new InvalidProduct("Product is not Found");
			}
		}

		sumInsuredEntity.setCreatedDate(new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date()));
		sumInsuredEntity.setRecordStatus("ACTIVE");

		sumInsuredrepository.save(sumInsuredEntity);
		message = "AccountManagerSumInsured Data is Saved Successfully";

		return message;
	}

	@Override
	public AccountManagerSumInsuredDisplayDto upadateAccountManagerSumInsured(AccountManagerSumInsuredDto dto,
																			  Long id) {
		AccountManagerSumInsured entitytable = sumInsuredrepository.findById(id)
				.orElseThrow(() -> new InvalidUser("Id is not found"));
		entitytable.setSumInsuredName(dto.getSumInsuredName());
		entitytable.setSumInsuredFileName(retunFilePath(dto.getSumInsuredFileName()));

		entitytable.setUpdatedDate(new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date()));
		AccountManagerSumInsured save = sumInsuredrepository.save(entitytable);

		return mapEntityToDto(save);
	}

	public static AccountManagerSumInsuredDisplayDto mapEntityToDto(AccountManagerSumInsured entity) {
		AccountManagerSumInsuredDisplayDto dto = new AccountManagerSumInsuredDisplayDto();

		dto.setSumInsuredId(entity.getSumInsuredId());
		dto.setSumInsuredName(entity.getSumInsuredName());

		  String fileName = entity.getSumInsuredFileName(); // Get the file name from the entity

		    // Extract the file name from the path
		    String[] fileNameParts = fileName.split("_");
		    if (fileNameParts.length > 0) {
		        dto.setSumInsuredFileName(fileNameParts[fileNameParts.length - 1]); // Set the last part as the file name
		    } else {
		        dto.setSumInsuredFileName(fileName); // Set the full file name if no underscores found
		    }
		return dto;
	}

	@Override
	public List<AccountManagerSumInsuredDisplayDto> getAllSumInsuredDetails(Long clientlistId, Long productId) {

		return sumInsuredrepository.findAll().stream().filter(i -> i.getRecordStatus().equalsIgnoreCase("ACTIVE"))
				.filter(i -> (clientlistId == 0 || i.getClientListId().getCid() == (clientlistId)))
				.filter(i -> (productId == 0 || i.getProductId().getProductId().equals(productId))).map(AccountManagerSumInsuredServiceImpl::mapEntityToDto).toList();
	}

	@Override
public String deleteSumInsuredDetailsById(Long id) {
    AccountManagerSumInsured sumInsuredEntity = sumInsuredrepository.findById(id)
           .orElseThrow(() -> new InvalidUser("Not Found"));

    sumInsuredEntity.setRecordStatus("IN ACTIVE");

    sumInsuredrepository.save(sumInsuredEntity);

    return "delete successful";
}

	@Override
	public byte[] downloadSumInsuredDocumentBySumInsuredId(Long sumInsuredId) throws IOException {
		return new byte[0];
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

}
