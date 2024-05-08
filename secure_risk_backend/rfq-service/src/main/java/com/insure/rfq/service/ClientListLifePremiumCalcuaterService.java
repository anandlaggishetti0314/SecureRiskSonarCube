package com.insure.rfq.service;

import com.insure.rfq.dto.ClientListLifePremiumCalcuaterDto;

import java.util.List;

public interface ClientListLifePremiumCalcuaterService {

	 String createClientListLifePremiumCalcuater(ClientListLifePremiumCalcuaterDto preLifePremiumCalcuater , Long clientID , Long produtId);
	 List<ClientListLifePremiumCalcuaterDto> getAllTheClientListLifePremiumCalcuaters(Long clientID, Long productId);
	ClientListLifePremiumCalcuaterDto getClientListLifePremiumCalcuaterDto(Long primaryId);
	 String deleteClientListLifePremiumCalcuaterDto(Long primaryId);
	 ClientListLifePremiumCalcuaterDto updateClientListLifePremiumCalcuaterDto(ClientListLifePremiumCalcuaterDto dto);
	byte[] generateExcelFromData(Long clientListId, Long productId);
}
