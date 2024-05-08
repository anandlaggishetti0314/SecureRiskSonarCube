package com.insure.rfq.service.impl;

import com.insure.rfq.dto.ClientListFamilyPremiumCalcuaterDto;
import com.insure.rfq.entity.ClientList;
import com.insure.rfq.entity.ClientListPreFamilyPremiumCalcuater;
import com.insure.rfq.entity.Product;
import com.insure.rfq.exception.InvalidClientList;
import com.insure.rfq.exception.InvalidProduct;
import com.insure.rfq.exception.InvalidUser;
import com.insure.rfq.repository.ClientListPremiumCalcuaterepository;
import com.insure.rfq.repository.ClientListRepository;
import com.insure.rfq.repository.ProductRepository;
import com.insure.rfq.service.ClientListFamilyPremiumCalcuaterService;
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
public class ClientListFamilyPremiumCalcuaterServiceimpl implements ClientListFamilyPremiumCalcuaterService {


    private ClientListPremiumCalcuaterepository calcuaterRepository;

    private ProductRepository productRepository;

    private ClientListRepository clientListRepository;

    public ClientListFamilyPremiumCalcuaterServiceimpl(ClientListPremiumCalcuaterepository calcuaterRepository, ProductRepository productRepository, ClientListRepository clientListRepository) {
        this.calcuaterRepository = calcuaterRepository;
        this.productRepository = productRepository;
        this.clientListRepository = clientListRepository;
    }
    String active1 = "ACTIVE";

    @Override
    public String createClientListFamilyPremiumCalcuater(ClientListFamilyPremiumCalcuaterDto calcuaterDto, Long clientId,
                                                         Long productId) {

        String message = "";
        ClientListPreFamilyPremiumCalcuater entityCalcuater = new ClientListPreFamilyPremiumCalcuater();
        entityCalcuater.setAgeBandStart(calcuaterDto.getAgeBandStart());
        entityCalcuater.setAgeBandEnd(calcuaterDto.getAgeBandEnd());
        entityCalcuater.setBasePremium(calcuaterDto.getBasePremium());
        entityCalcuater.setSumInsured(calcuaterDto.getSumInsured());

        entityCalcuater.setRecordStatus(active1);
        entityCalcuater.setCreatedDate(new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date()));
        if (productId != null) {
            Product product1 = productRepository.findById(productId)
                    .orElseThrow(() -> new InvalidProduct("Product is Not Found"));
            entityCalcuater.setProductId(product1);
        }
        if (clientId != null) {
            ClientList clientList = clientListRepository.findById(clientId)
                    .orElseThrow(() -> new InvalidClientList("ClientList is Not Found"));
            entityCalcuater.setClientListId(clientList);
            entityCalcuater.setRfqId(clientList.getRfqId());
        }


        ClientListPreFamilyPremiumCalcuater premiumCalcuater = calcuaterRepository.save(entityCalcuater);
        if (premiumCalcuater != null)
            message = "ClientList_PreFamilyPremiumCalcuater is Saved Successfully";
        else
            message = "ClientList_PreFamilyPremiumCalcuater is not Saved";
        return message;
    }

    @Override
    public List<ClientListFamilyPremiumCalcuaterDto> getAllTheClientListPremiumCalcuaters(Long clientID, Long productId) {


        return calcuaterRepository.findAll().stream()
				.filter(status -> status.getRecordStatus().equalsIgnoreCase(active1)
						&& status.getClientListId().getCid() == clientID
						&& status.getProductId().getProductId().equals(productId))
				.map(i -> {
					ClientListFamilyPremiumCalcuaterDto dto = new
							  ClientListFamilyPremiumCalcuaterDto();
					dto.setAgeBandEnd(i.getAgeBandEnd());
					dto.setAgeBandStart(i.getAgeBandStart());
					dto.setBasePremium(i.getBasePremium());
					dto.setSumInsured(i.getSumInsured());
					dto.setFamilypremiumCalcuaterid(i.getPremiumCalcuaterid());
					dto.setRfqId(i.getRfqId());
					dto.setClientListId(String.valueOf(i .getClientListId().getCid()));
					dto.setProductId(String.valueOf(i.getProductId().getProductId()));
					return dto;

				}).toList();
    }


    @Override
    public String deleteClientListPremiumCalcuaterDto(Long primaryId) {
        ClientListPreFamilyPremiumCalcuater entitypremiumCalcuater = calcuaterRepository.findById(primaryId)
                .orElseThrow(() -> new InvalidUser("Id is not found"));
        String message = "";
        if (entitypremiumCalcuater != null) {
            entitypremiumCalcuater.setRecordStatus("INACTIVE");
            ClientListPreFamilyPremiumCalcuater entitysaved = calcuaterRepository.save(entitypremiumCalcuater);
            if (entitysaved != null)
                message = "Data is Deleted";
        } else
            message = "Id is not found";

        return message;
    }

@Override
public ClientListFamilyPremiumCalcuaterDto getClientListPremiumCalcuaterDto(Long primaryId) {
        List<ClientListPreFamilyPremiumCalcuater> active = calcuaterRepository.findAll().stream()
                .filter(i -> i.getRecordStatus().equalsIgnoreCase(active1) &&
                        i.getPremiumCalcuaterid().equals(primaryId)).collect(Collectors.toList());
        // If the list is not empty, proceed to map the entities to DTOs
        if (!active.isEmpty()) {
            return active.stream().map(i -> {
                ClientListFamilyPremiumCalcuaterDto dto = new ClientListFamilyPremiumCalcuaterDto();
                dto.setFamilypremiumCalcuaterid(i.getPremiumCalcuaterid());
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

    //public String u
    @Override
    public byte[] generateExcelFromData(Long clientListId, Long productId) {
        log.info("Service     : " + clientListId + " -----------" + productId);
        List<ClientListPreFamilyPremiumCalcuater> familyPremiumCalcuaters = calcuaterRepository.findAll().
                stream().filter(filter -> filter.getRecordStatus().equalsIgnoreCase(active1))
                .filter(client -> clientListId != null && client.
                        getClientListId().getCid() == clientListId)
                .filter(c -> productId != null && c.getProductId().getProductId().equals(productId)).toList();
        List<ClientList> list = familyPremiumCalcuaters.stream().map(ClientListPreFamilyPremiumCalcuater::getClientListId).toList();
        List<Long> list1 = list.stream().map(i -> i.getCid()).toList();
        List<Long> list2 = familyPremiumCalcuaters.stream().map(c -> c.getProductId().getProductId()).toList();

        log.info("A ---->{}: ", list1 + "---- product id " + list2);
        try (Workbook workbook = new XSSFWorkbook(); ByteArrayOutputStream out = new ByteArrayOutputStream()) {
            Sheet sheet = workbook.createSheet("Premium_Calculator");

            String[] headers = {"AgeBandStart", "AgeBandEnd", "SumInsured", "BasePremium"};
            Row headerRow = sheet.createRow(0);
            for (int i = 0; i < headers.length; i++) {
                headerRow.createCell(i).setCellValue(headers[i]);
            }

            int rowNum = 1;
            for (ClientListPreFamilyPremiumCalcuater cpfc : familyPremiumCalcuaters) {
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


    public ClientListFamilyPremiumCalcuaterDto updateClientListFamilyPremiumCalcuaterDto(ClientListFamilyPremiumCalcuaterDto dto) {
        // Find the record with the provided ID
        List<ClientListPreFamilyPremiumCalcuater> active = calcuaterRepository.findAll().stream()
                .filter(i -> i.getRecordStatus().equalsIgnoreCase(active1) &&
                        i.getPremiumCalcuaterid().equals(dto.getFamilypremiumCalcuaterid()))
                .toList();

        // If the list is not empty, proceed to update the record
        if (!active.isEmpty()) {
            ClientListPreFamilyPremiumCalcuater recordOfFamily = active.get(0); // Assuming there's only one record
            // Update the fields of the record with the values from the DTO
            recordOfFamily.setAgeBandEnd(dto.getAgeBandEnd());
            recordOfFamily.setAgeBandStart(dto.getAgeBandStart());
            recordOfFamily.setSumInsured(dto.getSumInsured());
            recordOfFamily.setBasePremium(dto.getBasePremium());
            recordOfFamily.setRfqId(dto.getRfqId());
            recordOfFamily.setUpdatedDate(new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date()));
          
            calcuaterRepository.save(recordOfFamily);

         
            return dto;
        } else {
          
            return null;
        }
    }





}
