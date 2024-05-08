package com.insure.rfq.service;

import com.insure.rfq.dto.*;

import java.io.IOException;
import java.util.List;

public interface CorporateDetailsService {

	String createRFQ(CorporateDetailsDto dto);

	UpdateCorporateDetailsDto updateRFQ(String rfqIdValue, UpdateCorporateDetailsDto dto);

	RFQCompleteDetailsDto getRfqById(String rfqId);

	String submitRfq(String rfqId, CorporateDetailsDto corpoarCorporateDetailsDto);

	List<AllRFQDetailsDto> getAllRFQs();

	void sendEmailWithAttachment(String toEmail, String subject, String body, String attachmentFileName);

	String sendEmailWithAttachments(InsureListDto insureListDto);

	public byte[] getEmployeeData(String id);

	public byte[] getIrdaData(String rfqId) throws IOException;
	
	DashBoardDto getCooperateDetailsInfoBasedOnMonthYear(String month,int year);
	
	List<GetRfqCountWithLocationDto> getApplicationStatusCountByLocation(Long locationId);

}
