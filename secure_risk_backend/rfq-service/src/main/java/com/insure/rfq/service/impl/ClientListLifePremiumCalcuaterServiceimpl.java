package com.insure.rfq.service.impl;

import com.insure.rfq.dto.ClientListLifePremiumCalcuaterDto;
import com.insure.rfq.entity.ClientList;
import com.insure.rfq.entity.ClientListPerLifePremiumCalculator;
import com.insure.rfq.entity.Product;
import com.insure.rfq.exception.InvalidClientList;
import com.insure.rfq.exception.InvalidProduct;
import com.insure.rfq.exception.InvalidUser;
import com.insure.rfq.repository.ClientListLifePremiumCalcuaterepository;
import com.insure.rfq.repository.ClientListRepository;
import com.insure.rfq.repository.CorporateDetailsRepository;
import com.insure.rfq.repository.ProductRepository;
import com.insure.rfq.service.ClientListLifePremiumCalcuaterService;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Slf4j
public class ClientListLifePremiumCalcuaterServiceimpl implements ClientListLifePremiumCalcuaterService {


	private ClientListLifePremiumCalcuaterepository liffecalcuaterRepository;

	private ProductRepository productRepository;

	private ClientListRepository clientListRepository;

	 String  s= "ACTIVE";



	public ClientListLifePremiumCalcuaterServiceimpl(ClientListLifePremiumCalcuaterepository liffecalcuaterRepository, ProductRepository productRepository, ClientListRepository clientListRepository) {
		this.liffecalcuaterRepository = liffecalcuaterRepository;
		this.productRepository = productRepository;
		this.clientListRepository = clientListRepository;

	}

	@Override
	public String deleteClientListLifePremiumCalcuaterDto(Long primaryId) {
		ClientListPerLifePremiumCalculator entitypremiumCalcuater = liffecalcuaterRepository.findById(primaryId)
				.orElseThrow(() -> new InvalidUser("Id is not found"));
		String message = "";
		if (entitypremiumCalcuater != null) {
			entitypremiumCalcuater.setRecordStatus("INACTIVE");
			ClientListPerLifePremiumCalculator entitysaved = liffecalcuaterRepository.save(entitypremiumCalcuater);
			if (entitysaved != null)
				message = "Data is Deleted";
		} else
			message = "Id is not found";

		return message;
	}

	// Get by ID
	@Override
	public ClientListLifePremiumCalcuaterDto getClientListLifePremiumCalcuaterDto(Long primaryId) {
		List<ClientListPerLifePremiumCalculator> active = liffecalcuaterRepository.findAll().stream()
				.filter(i -> i.getRecordStatus().equalsIgnoreCase(s)
						&& i.getLifepremiumCalcuaterid().equals(primaryId))
				.toList();

	
		if (!active.isEmpty()) {
			return active.stream().map(i -> {
				ClientListLifePremiumCalcuaterDto dto = new ClientListLifePremiumCalcuaterDto();
				dto.setLifepremiumCalcuaterid(i.getLifepremiumCalcuaterid());
				dto.setAgeBandEnd(i.getAgeBandEnd());
				dto.setAgeBandStart(i.getAgeBandStart());
				dto.setSumInsured(i.getSumInsured());
				dto.setBasePremium(i.getBasePremium());
				dto.setRfqId(i.getRfqId());
				dto.setClientListId(String.valueOf(i.getClientListId().getCid()));
				dto.setProductId(String.valueOf(i.getProductId().getProductId()));
				return dto;
			}).findFirst().orElse(null); // Assuming there should be only one matching record
		} else {
			return null; // Or handle the case where no matching record is found
		}
	}

	// Create 

	@Override
	public String createClientListLifePremiumCalcuater(ClientListLifePremiumCalcuaterDto preLifePremiumCalcuater,
			Long clientID, Long produtId) {

		String message = "";
		ClientListPerLifePremiumCalculator entityCalcuater = new ClientListPerLifePremiumCalculator();
		entityCalcuater.setAgeBandStart(preLifePremiumCalcuater.getAgeBandStart());
		entityCalcuater.setAgeBandEnd(preLifePremiumCalcuater.getAgeBandEnd());
		entityCalcuater.setBasePremium(preLifePremiumCalcuater.getBasePremium());
		entityCalcuater.setSumInsured(preLifePremiumCalcuater.getSumInsured());
		entityCalcuater.setRecordStatus(s);
		entityCalcuater.setCreatedDate(new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date()));
		if (produtId != null) {
			Product product1 = productRepository.findById(produtId)
					.orElseThrow(() -> new InvalidProduct("Product is Not Found"));
			entityCalcuater.setProductId(product1);

		}
		if (clientID != null) {
			ClientList clientList = clientListRepository.findById(clientID)
					.orElseThrow(() -> new InvalidClientList("ClientList is Not Found"));
			entityCalcuater.setClientListId(clientList);
			entityCalcuater.setRfqId(clientList.getRfqId());
		}


		ClientListPerLifePremiumCalculator premiumCalcuater = liffecalcuaterRepository.save(entityCalcuater);
		if (premiumCalcuater != null)
			message = "ClientList_Pre_Life_Premium_Calcuater is Saved Successfully";
		else
			message = "ClientList_Pre_Life_Premium_Calcuater is not Saved";
		return message;
	}

	// Get All Premiums
	@Override
	public List<ClientListLifePremiumCalcuaterDto> getAllTheClientListLifePremiumCalcuaters(Long clientID,
			Long productId) {

		return liffecalcuaterRepository.findAll().stream()
				.filter(status -> status.getRecordStatus().equalsIgnoreCase(s)
						&& status.getClientListId().getCid() == clientID
						&& status.getProductId().getProductId().equals(productId))
				.map(i -> {
					ClientListLifePremiumCalcuaterDto dto = new ClientListLifePremiumCalcuaterDto();
					dto.setAgeBandEnd(i.getAgeBandEnd());
					dto.setAgeBandStart(i.getAgeBandStart());
					dto.setBasePremium(i.getBasePremium());
					dto.setSumInsured(i.getSumInsured());
					dto.setLifepremiumCalcuaterid(i.getLifepremiumCalcuaterid());
					dto.setRfqId(i.getRfqId());
					dto.setClientListId(String.valueOf(i .getClientListId().getCid()));
					dto.setProductId(String.valueOf(i.getProductId().getProductId()));
					return dto;

				}).toList();
	}

	public byte[] generateExcelFromData(Long clientListId, Long productId) {
		log.info("Service     : " + clientListId + " -----------" + productId);
		List<ClientListPerLifePremiumCalculator> activeLifePremium = liffecalcuaterRepository.findAll().stream()
				.filter(filter -> filter.getRecordStatus().equalsIgnoreCase(s))
				.filter(client -> clientListId != null && client.getClientListId().getCid() == clientListId)
				.filter(c -> productId != null && c.getProductId().getProductId().equals(productId)).toList();
		List<ClientList> list = activeLifePremium.stream().map(ClientListPerLifePremiumCalculator::getClientListId)
				.toList();
		List<Long> list1 = list.stream().map(i -> i.getCid()).toList();
		List<Long> list2 = activeLifePremium.stream().map(c -> c.getProductId().getProductId()).toList();


		log.info("A ---->{}: ", list1 + "---- product id " + list2);
		try (Workbook workbook = new XSSFWorkbook(); ByteArrayOutputStream out = new ByteArrayOutputStream()) {
			Sheet sheet = workbook.createSheet("Premium_Calculator");

			String[] headers = { "AgeBandStart", "AgeBandEnd", "SumInsured", "BasePremium" };
			Row headerRow = sheet.createRow(0);
			for (int i = 0; i < headers.length; i++) {
				headerRow.createCell(i).setCellValue(headers[i]);
			}

			int rowNum = 1;
			for (ClientListPerLifePremiumCalculator cpfc : activeLifePremium) {
				Row row = sheet.createRow(rowNum++);
				row.createCell(0).setCellValue(cpfc.getAgeBandStart());
				row.createCell(1).setCellValue(cpfc.getAgeBandEnd());
				row.createCell(2).setCellValue(cpfc.getSumInsured());
				row.createCell(3).setCellValue(cpfc.getBasePremium());
			}

			workbook.write(out);
			return out.toByteArray();
		} catch (IOException e) {
			e.printStackTrace();
			return new byte[0];
		}
	}

	public ClientListLifePremiumCalcuaterDto updateClientListLifePremiumCalcuaterDto(
			ClientListLifePremiumCalcuaterDto dto) {
		// Find the record with the provided ID
		List<ClientListPerLifePremiumCalculator> active = liffecalcuaterRepository.findAll().stream()
				.filter(i -> i.getRecordStatus().equalsIgnoreCase(s)
						&& i.getLifepremiumCalcuaterid().equals(dto.getLifepremiumCalcuaterid()))
				.toList();

		// If the list is not empty, proceed to update the record
		if (!active.isEmpty()) {
			ClientListPerLifePremiumCalculator recordUpdate = active.get(0); // Assuming there's only one record
			// Update the fields of the record with the values from the DTO
			recordUpdate.setAgeBandEnd(dto.getAgeBandEnd());
			recordUpdate.setAgeBandStart(dto.getAgeBandStart());
			recordUpdate.setSumInsured(dto.getSumInsured());
			recordUpdate.setBasePremium(dto.getBasePremium());
			recordUpdate.setRfqId(dto.getRfqId());
			recordUpdate.setUpdatedDate(new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date()));
			// Assuming setting other fields as well

			// Save the updated record
			liffecalcuaterRepository.save(recordUpdate);

			// Return the updated DTO
			return dto;
		} else {
			// If the record is not found, return null or handle the case accordingly
			return null;
		}
	}

}
