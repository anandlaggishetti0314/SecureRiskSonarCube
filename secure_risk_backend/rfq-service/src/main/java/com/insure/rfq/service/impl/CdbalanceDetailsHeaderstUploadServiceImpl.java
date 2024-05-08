package com.insure.rfq.service.impl;

import com.insure.rfq.dto.*;
import com.insure.rfq.entity.CdbalanceEntitytable;
import com.insure.rfq.entity.CdbalanceHeadersMappingEntity;
import com.insure.rfq.entity.ClientList;
import com.insure.rfq.entity.Product;
import com.insure.rfq.exception.InvalidClientList;
import com.insure.rfq.exception.InvalidProduct;
import com.insure.rfq.exception.InvalidUser;
import com.insure.rfq.repository.CdbalanceDetailsHeadersRepository;
import com.insure.rfq.repository.CdbalanceEntityRepository;
import com.insure.rfq.repository.ClientListRepository;
import com.insure.rfq.repository.ProductRepository;
import com.insure.rfq.service.CdbalanceHeaderUploadService;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.NotOLE2FileException;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
@Slf4j
public class CdbalanceDetailsHeaderstUploadServiceImpl implements CdbalanceHeaderUploadService {

	
	private CdbalanceDetailsHeadersRepository cdbalanceDetailsHeadersDtoRepository;
	
	private ProductRepository productRepository;
	
	private ClientListRepository clientListRepository;

	
	private CdbalanceEntityRepository entityRepository;
	final String s = "Policy Number";
	final String s1 = "Transaction Type";
	final String s2 = "Payment Date";
	final String s3 = "Amount";
	final String s4 = "CR/DB/CD";
	final String s5 = "Balance";

	String active1="ACTIVE";



	public CdbalanceDetailsHeaderstUploadServiceImpl(CdbalanceDetailsHeadersRepository cdbalanceDetailsHeadersDtoRepository, ProductRepository productRepository, ClientListRepository clientListRepository, CdbalanceEntityRepository entityRepository) {
		this.cdbalanceDetailsHeadersDtoRepository = cdbalanceDetailsHeadersDtoRepository;
		this.productRepository = productRepository;
		this.clientListRepository = clientListRepository;
		this.entityRepository = entityRepository;
	}

	@Override
	public CdbalanceHeaderMappingDto uploadEnrollement(CdbalanceHeaderMappingDto cdbalanceHeaderMappingDto) {
		if (cdbalanceHeaderMappingDto != null && cdbalanceHeaderMappingDto.getHeaders() != null) {
			List<CdbalanceDetailsHeadersDto> headersDtoList = cdbalanceHeaderMappingDto.getHeaders();
			List<CdbalanceDetailsHeadersDto> savedDtos = new ArrayList<>();

			for (CdbalanceDetailsHeadersDto headerDto : headersDtoList) {
				CdbalanceHeadersMappingEntity mappingEntity = new CdbalanceHeadersMappingEntity();
				mappingEntity.setHeaderAliasName(headerDto.getHeaderAliasName());
				mappingEntity.setHeaderName(headerDto.getHeaderName());
				mappingEntity.setSheetName(headerDto.getSheetName());
				mappingEntity.setSheetId(cdbalanceHeaderMappingDto.getSheetId());
				CdbalanceHeadersMappingEntity savedEntity = cdbalanceDetailsHeadersDtoRepository.save(mappingEntity);

				CdbalanceDetailsHeadersDto savedDto = new CdbalanceDetailsHeadersDto();
				savedDto.setHeaderAliasName(savedEntity.getHeaderAliasName());
				savedDto.setHeaderName(savedEntity.getHeaderName());
				savedDto.setSheetName(savedEntity.getSheetName());

				savedDtos.add(savedDto);
			}

			return new CdbalanceHeaderMappingDto(cdbalanceHeaderMappingDto.getSheetId(), savedDtos);
		}

		return null;
	}

	@Override
	public CdbalanceHeaderStatusDto validateHeaders(MultipartFile multipartFile) {
		CdbalanceHeaderStatusDto cdBalanceHeaderStatusDto = new CdbalanceHeaderStatusDto();

		try (Workbook workbook = WorkbookFactory.create(multipartFile.getInputStream())) {
			Sheet sheet = workbook.getSheetAt(0); // Assuming the first sheet
			List<CdbalanceHeadersMappingEntity> validHeaders = cdbalanceDetailsHeadersDtoRepository.findAll();

			// Process each row to find the header row
			for (Row currentRow : sheet) {
				if (!isRowEmpty(currentRow)) { // Check if the row is not empty
					Row headerRow = currentRow; // Start with the current row
					boolean headerRowFound = false;
					// Iterate through cells in the current row to find headers
					for (int index = 0; index < headerRow.getPhysicalNumberOfCells(); index++) {
						Cell cell = headerRow.getCell(index);
						String columnName = getCellValueAsString(cell);
						if (cell != null && !isCellMergedOrEmpty(cell, sheet)) {
							// Check if the cell value matches any header from the database
							if (validHeaders.stream().anyMatch(header -> columnName.equals(header.getHeaderName())
									|| columnName.equals(header.getHeaderAliasName()))) {
								headerRowFound = true;
								break; // Exit the loop once header row is found
							}
						}
					}
					if (headerRowFound) {
						// Process header row to set flags
						for (int index = 0; index < headerRow.getPhysicalNumberOfCells(); index++) {
							Cell cell = headerRow.getCell(index);
							String columnName = getCellValueAsString(cell);
							if (cell != null && !isCellMergedOrEmpty(cell, sheet)) {
								validHeaders.forEach(header -> {
									if (columnName.equals(header.getHeaderName())
											|| columnName.equals(header.getHeaderAliasName())) {
										// Set flags based on header names



										switch (header.getHeaderName()) {
										case s:
											cdBalanceHeaderStatusDto.setPolicyNumber(true);
											break;
										case s1:
											cdBalanceHeaderStatusDto.setTransactionType(true);
											break;
										case s2:
											cdBalanceHeaderStatusDto.setPaymentDate(true);
											break;
										case s3:
											cdBalanceHeaderStatusDto.setAmount(true);
											break;
										case s4:
											cdBalanceHeaderStatusDto.setCreditedRecord(true);
											break;
										case s5:
											cdBalanceHeaderStatusDto.setBalance(true);
											break;
										}
									}
								});
							}
						}
						break; // Exit the outer loop once header row is found and processed
					}
				}
			}
		} catch (IOException e) {
			log.error("Error occurred while processing the file: {}", e.getMessage());
		}

		return cdBalanceHeaderStatusDto;
	}

	private String getCellValueAsString(Cell cell) {
		if (cell == null) {
			return ""; // Return empty string for null cells
		}
		switch (cell.getCellType()) {
		case STRING:
			return cell.getStringCellValue();
		case NUMERIC:
			if (DateUtil.isCellDateFormatted(cell)) {
				// Format date value and return as string
				return cell.getDateCellValue().toString();
			} else {
				// Format numeric value based on your requirements and return as string
				return String.valueOf(cell.getNumericCellValue());
			}
		case BOOLEAN:
			return String.valueOf(cell.getBooleanCellValue());
		case FORMULA:
			// Evaluate formula cell and return the calculated value as string
			return String.valueOf(cell.getNumericCellValue()); // For simplicity, assuming formula results in a numeric
																// value
		default:
			return ""; // Return empty string for unsupported cell types
		}
	}

	private boolean isCellMergedOrEmpty(Cell cell, Sheet sheet) {
		if (cell == null || cell.getCellType() == CellType.BLANK) {
			return true; // Cell is empty
		}


		// Check if the cell belongs to a merged region
		for (CellRangeAddress mergedRegion : sheet.getMergedRegions()) {
			if (mergedRegion.isInRange(cell.getRowIndex(), cell.getColumnIndex())) {
				return true; // Cell is part of a merged region
			}
		}

		return false; // Cell is neither empty nor part of a merged region
	}

	private Workbook getWorkbook(MultipartFile file) throws IOException {
		String fileName = file.getOriginalFilename();

		if (fileName != null && (fileName.endsWith(".xlsx") || fileName.endsWith(".XLSX") || fileName.endsWith(".xlsb")
				|| fileName.endsWith(".XLSB"))) {
			// Handle XLSX
			return new XSSFWorkbook(file.getInputStream());
		} else if (fileName != null && (fileName.endsWith(".xls") || fileName.endsWith(".XLS"))) {

			// Handle XLS
			return new HSSFWorkbook(file.getInputStream());
		} else {
			// Throw an exception or handle the unsupported file format
			throw new IllegalArgumentException("Unsupported file format: " + fileName);
		}
	}


	private boolean isRowEmpty(Row row) {
		if (row == null) {
			return true; // Return true if the row itself is null
		} else {
			for (Cell cell : row) {
				if (cell != null && cell.getCellType() != CellType.BLANK) {
					return false; // If any cell is not empty, return false
				}
			}
			return true; // All cells are empty, return true
		}
	}

	@Override
	public List<CdbalanceDisplayDto> getDataformFile(Long clientID, Long productId) {
		return entityRepository.findAll().stream().filter(entity -> entity.getRecordStatus().equalsIgnoreCase(active1))
				.filter(client -> clientID != null && client.getClientListId().getCid() == (clientID))
				.filter(c -> productId != null && c.getProductId().getProductId().equals(productId)).map(entity -> {
					CdbalanceDisplayDto dto = new CdbalanceDisplayDto();
					dto.setPolicyNumber(entity.getPolicyNumber());
					dto.setTransactionType(entity.getTransactionType());
					dto.setPaymentDate(entity.getPaymentDate());
					dto.setAmount(entity.getAmount());
					dto.setCreditedRecord(entity.getCR_DB_CD());
					dto.setBalance(entity.getBalance());
					dto.setCdbalanceId(entity.getCdbalanceId());

					return dto;
				}).toList();
	}

	@Override
	public String saveData(List<CdbalanceValueStatus> valueStatuses, Long clientID, Long productId) {
		String message;
		valueStatuses.forEach(dto -> {
			CdbalanceEntitytable entity = new CdbalanceEntitytable();
			if (productId != null) {
				Product product = productRepository.findById(productId)
						.orElseThrow(() -> new InvalidProduct("Product is Not Found"));
				entity.setProductId(product);
			}
			if (clientID != null) {
				ClientList clientList = clientListRepository.findById(clientID)
						.orElseThrow(() -> new InvalidClientList("ClientList is Not Found"));
				entity.setClientListId(clientList);
				entity.setRfqId(clientList.getRfqId());
			}
			entity.setRecordStatus(active1);
			entity.setCreatedDate(new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date()));
			entity.setPolicyNumber(dto.getPolicyNumber());
			entity.setTransactionType(dto.getTransactionType());
			entity.setPaymentDate(dto.getPaymentDate());
			entity.setAmount(dto.getAmount());
			entity.setBalance(dto.getBalance());
			entityRepository.save(entity);
		});
		message = "File is saved successfully";
		return message;

	}

	public List<CdbalanceValueStatus> validateValuesBased(MultipartFile multipartFile) throws IOException {
		List<CdbalanceValueStatus> list = new ArrayList<>();
		try (Workbook workbook = getWorkbook(multipartFile)) {

			Sheet sheet = null;
			int noofSheet = workbook.getNumberOfSheets();
			for (int i = 0; i < noofSheet; i++) {
				sheet = workbook.getSheetAt(i);
				validateBasedOnSheet(sheet, list);
			}
		} catch (NotOLE2FileException e) {
			// Log warning or error
			log.warn("The file is not in the expected OLE2 format: {}", e.getMessage());
			// Provide user-friendly error message
			throw new IllegalArgumentException("The supplied file is not a valid Excel file.");
		} catch (IOException e) {
			// Log or handle other IO errors
			log.error("An IO error occurred while processing the file: {}", e.getMessage());
			// Provide user-friendly error message
			throw new IOException("An error occurred while processing the file.");
		}
		return list;

	}

	private boolean isMergedCell(Sheet sheet, Cell cell) {
		for (CellRangeAddress region : sheet.getMergedRegions()) {
			if (region.isInRange(cell.getRowIndex(), cell.getColumnIndex())) {
				return true;
			}
		}
		return false;
	}

	private String evaluateFormulaCell(Cell cell) {
		// Evaluate formula cell and return the calculated value as string
		FormulaEvaluator evaluator = cell.getSheet().getWorkbook().getCreationHelper().createFormulaEvaluator();
		CellValue cellValue = evaluator.evaluate(cell);
		return getCellValueAsString(cellValue); // Recursive call to handle evaluated value
	}

	private String getCellValueAsString(CellValue cellValue) {
		if (cellValue == null) {
			return ""; // Return empty string for null cell values
		}

		switch (cellValue.getCellType()) {
		case STRING:
			return cellValue.getStringValue().trim();
		case NUMERIC:
			return String.valueOf(cellValue.getNumberValue());
		case BOOLEAN:
			return String.valueOf(cellValue.getBooleanValue());
		default:
			return ""; // Return empty string for unsupported cell value types
		}

	}

	public List<CdbalanceValueStatus> validateBasedOnSheet(Sheet sheet,
			List<CdbalanceValueStatus> cdBalanceHeaderStatusDtoList) {
		List<CdbalanceHeadersMappingEntity> validHeaders = cdbalanceDetailsHeadersDtoRepository.findAll();

		for (Row currentRow : sheet) {
			if (!isRowEmpty(currentRow)) { // Check if the row is not empty
				Row headerRow = currentRow; // Start with the current row
				boolean headerRowFound = false;
				// Iterate through cells in the current row to find headers
				for (int index = 0; index < headerRow.getPhysicalNumberOfCells(); index++) {
					Cell cell = headerRow.getCell(index);
					String columnName = getCellValueAsString(cell);
					if (cell != null && !isCellMergedOrEmpty(cell, sheet)) {
						// Check if the cell value matches any header from the database
						if (validHeaders.stream().anyMatch(header -> columnName.equals(header.getHeaderName())
								|| columnName.equals(header.getHeaderAliasName()))) {
							headerRowFound = true;
							break; // Exit the loop once header row is found
						}
					}
				}
				if (headerRowFound) {
					// Once the header row is found, iterate through each row and process the values
					for (Row dataRow : sheet) {
						if (dataRow.getRowNum() > headerRow.getRowNum()) { // Skip the header row
							CdbalanceValueStatus valueStatus = new CdbalanceValueStatus();
							for (int index = 0; index < headerRow.getPhysicalNumberOfCells(); index++) {
								Cell cell = dataRow.getCell(index); // Get the cell from the data row
								String columnName = getCellValueAsString(headerRow.getCell(index)); // Get the header
																									// name
								if (cell != null && !isCellMergedOrEmpty(cell, sheet)) {
									validHeaders.forEach(header -> {
										if (columnName.equals(header.getHeaderName())
												|| columnName.equals(header.getHeaderAliasName())) {
											// Set flags based on header names

											switch (header.getHeaderName()) {
											case s:

												String policyNumberCellValue = getCellValueAsString(cell);
												if (policyNumberCellValue != null) {
													valueStatus.setPolicyNumber(policyNumberCellValue);
													valueStatus.setPolicyNumberStatus(true);
													valueStatus.setPolicyNumberErrorMessage(""); // No error message as
																									// it's valid
												} else {
													valueStatus.setPolicyNumber(policyNumberCellValue);
													valueStatus.setPolicyNumberStatus(false);
													valueStatus.setPolicyNumberErrorMessage(
															"The Policy Number is not valid");
												}

												break;
											case s1:

												String transactionTypeCellValue = getCellValueAsString(cell);
												if (transactionTypeCellValue != null) {
													valueStatus.setTransactionType(transactionTypeCellValue);
													valueStatus.setTransactionTypeStatus(true);
													valueStatus.setTransactionTypeErrorMessage(""); // No error message
																									// as it's valid
												} else {
													valueStatus.setTransactionType(transactionTypeCellValue);
													valueStatus.setTransactionTypeStatus(false);
													valueStatus.setTransactionTypeErrorMessage(
															"The Transaction Type is not valid");
												}

												break;
											case s2:

												String paymentDateCellValue = getCellValueAsString(cell);
												if (paymentDateCellValue != null) {
													valueStatus.setPaymentDate(paymentDateCellValue);
													valueStatus.setPaymentDateStatus(true);
													valueStatus.setPaymentDateErrorMessage(""); // No error message as
																								// it's valid
												} else {
													valueStatus.setPaymentDate(paymentDateCellValue);
													valueStatus.setPaymentDateStatus(false);
													valueStatus.setPaymentDateErrorMessage(
															"The Payment Date is not valid");
												}

												break;
											case s3:

												String amountCellValue = getCellValueAsString(cell);
												try {
													Double amount = Double.parseDouble(amountCellValue);
													if (amount != null) {
														valueStatus.setAmount(amount);
														valueStatus.setAmountStatus(true);
														valueStatus.setAmountErrorMessage(""); // No error message as
																								// it's valid
													} else {
														valueStatus.setAmount(null);
														valueStatus.setAmountStatus(false);
														valueStatus.setAmountErrorMessage("The Amount is not valid");
													}
												} catch (NumberFormatException e) {
													valueStatus.setAmount(null);
													valueStatus.setAmountStatus(false);
													valueStatus.setAmountErrorMessage("Invalid amount format");
												}

												break;
											case s4:

												String crDbCdCellValue = getCellValueAsString(cell);
												if (crDbCdCellValue != null) {
													valueStatus.setCreditedRecord(crDbCdCellValue);
													valueStatus.setCreditedRecordStatus(true);
													valueStatus.setCreditedRecordErrorMessage(""); // No error message as it's
																								// valid
												} else {
													valueStatus.setCreditedRecord(crDbCdCellValue);
													valueStatus.setCreditedRecordStatus(false);
													valueStatus.setCreditedRecordErrorMessage("The CR/DB/CD is not valid");
												}

												break;
											case "Balance":

												String balanceCellValue = getCellValueAsString(cell);
												try {
													Double balance = Double.parseDouble(balanceCellValue);
													if (balance != null) {
														valueStatus.setBalance(balance);
														valueStatus.setBalanceStatus(true);
														valueStatus.setBalanceErrorMessage("");
													} else {
														valueStatus.setBalance(null);
														valueStatus.setBalanceStatus(false);
														valueStatus.setBalanceErrorMessage("The Balance is not valid");
													}
												} catch (NumberFormatException e) {
													valueStatus.setBalance(null);
													valueStatus.setBalanceStatus(false);
													valueStatus.setBalanceErrorMessage("Invalid balance format");
												}

												break;
											}
										}
									});
								}
							}
							cdBalanceHeaderStatusDtoList.add(valueStatus);
						}
					}
				}
			}
		}
		return cdBalanceHeaderStatusDtoList;
	}

	@Override
	public String deleteTheCdBalancData(Long cdbalanceId) {
		String message = "";
		CdbalanceEntitytable entitytable = entityRepository.findById(cdbalanceId)
				.orElseThrow(() -> new InvalidUser("Id is not found"));
		if (entitytable != null) {
			entitytable.setRecordStatus("INACTIVE");
			entitytable = entityRepository.save(entitytable);
			message = "Data is Deleted";
		} else {
			message = "Id is not found";
		}
		return message;
	}

	public String updateCdBalanceData(CdbalanceDisplayDto dto, Long cdbalanceId) {
		String message = "";
		CdbalanceEntitytable entitytable = entityRepository.findById(cdbalanceId)
				.orElseThrow(() -> new InvalidUser("Id is not found"));
		entitytable.setPolicyNumber(dto.getPolicyNumber());
		entitytable.setTransactionType(dto.getTransactionType());
		entitytable.setPaymentDate(dto.getPaymentDate());
		entitytable.setAmount(dto.getAmount());
		entitytable.setCR_DB_CD(dto.getCreditedRecord());
		entitytable.setBalance(dto.getBalance());
		entitytable.setUpdatedDate(new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date()));
		CdbalanceEntitytable save = entityRepository.save(entitytable);
		if (save != null) {
			message = "Data is updateCdBalanceData";
		} else {
			message = "Data is Not updateCdBalanceData";
		}

		return message;
	}

	public byte[] generateExcelFromData(Long clientListId, Long productId) {
		try (Workbook workbook = new XSSFWorkbook(); ByteArrayOutputStream out = new ByteArrayOutputStream()) {
			Sheet sheet = workbook.createSheet("CD_balance");

			String[] headers = { s, s1, s2, s3,s4, s5 };
			Row headerRow = sheet.createRow(0);
			for (int i = 0; i < headers.length; i++) {
				headerRow.createCell(i).setCellValue(headers[i]);
			}
			List<CdbalanceEntitytable> active = entityRepository.findAll().stream()
					.filter(entity -> entity.getRecordStatus().equalsIgnoreCase(active1))
					.filter(client -> clientListId != null && client.getClientListId().getCid() == clientListId)
					.filter(c -> productId != null && c.getProductId().getProductId().equals(productId)).toList();
			log.info("The list" + active);
			int rowNum = 1;
			for (CdbalanceEntitytable entity : active) {
				Row row = sheet.createRow(rowNum++);
				row.createCell(0).setCellValue(entity.getPolicyNumber());
				row.createCell(1).setCellValue(entity.getTransactionType());
				row.createCell(2).setCellValue(entity.getPaymentDate());
				row.createCell(3).setCellValue(entity.getAmount());
				row.createCell(4).setCellValue(entity.getCR_DB_CD());
				row.createCell(5).setCellValue(entity.getBalance());
			}

			workbook.write(out);
			return out.toByteArray();
		} catch (IOException e) {
			e.printStackTrace();
			return new byte[0];
		}
	}

}
