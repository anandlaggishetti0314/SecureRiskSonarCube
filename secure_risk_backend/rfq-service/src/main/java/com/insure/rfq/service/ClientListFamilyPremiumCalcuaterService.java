package com.insure.rfq.service;

import java.util.List;

import com.insure.rfq.dto.ClientListFamilyPremiumCalcuaterDto;

public interface ClientListFamilyPremiumCalcuaterService {

	 String createClientListFamilyPremiumCalcuater(ClientListFamilyPremiumCalcuaterDto  preFamilyPremiumCalcuater , Long clientID , Long produtId);
	 List<ClientListFamilyPremiumCalcuaterDto> getAllTheClientListPremiumCalcuaters(Long clientID, Long productId);
	ClientListFamilyPremiumCalcuaterDto getClientListPremiumCalcuaterDto(Long primaryId);
	 String deleteClientListPremiumCalcuaterDto(Long primaryId) ;
	public ClientListFamilyPremiumCalcuaterDto updateClientListFamilyPremiumCalcuaterDto(ClientListFamilyPremiumCalcuaterDto dto);
	byte[] generateExcelFromData(Long clientListId, Long productId);
}
