package com.insure.rfq.service;

import com.insure.rfq.dto.*;
import com.insure.rfq.entity.CoverageDetailsEntity;
import com.insure.rfq.entity.EmployeeDepedentDetailsEntity;
import com.insure.rfq.payload.DataToEmail;
import com.itextpdf.text.DocumentException;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

public interface CoverageDetailsService {

	String createCoverageDetails(CoverageDetailsDto details);

	CoverageDetailsEntity updateCoverageDetails(String rfqId, CoverageDetailsDto coverageDetailsDto);

	public byte[] getEmployeeData();

	public byte[] getIrdaData() throws IOException;

	String saveEmployeesFromExcel(CoverageUploadDto coverageUploadDto);

	List<EmployeeDepedentDetailsEntity> getAllEmployeeDepedentDataByRfqId(String rfqId);

	String uploadFileCoverage(CoverageUploadDto coverageUploadDto);

	EmpDepdentValidationDto validateUploadedFileNames(MultipartFile file);

	byte[] downloadMandateLetter(String rfqId) throws IOException;

	String sendEmailAlongPreparedAttachment(DataToEmail dataToEmail) throws IOException, DocumentException;

	CoverageDetailsEntity getCoverageByRfqId(String rfqId);

	DownloadTemplateAttachementDto sendEmailAlongWithDownloadTEmplate(
			DownloadTemplateAttachementDto downloadTemplateAttachementDto);

	byte[] downloadClaimMISC(String rfqId) throws IOException;

	List<CoverageRemarksUploadDto> getAllRemarks(
			List<CoverageDetailsChildValidateValuesDto> coverageDetailsChildValidateValuesDtos);

}
