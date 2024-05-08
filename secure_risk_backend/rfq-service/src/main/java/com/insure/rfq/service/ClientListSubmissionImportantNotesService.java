package com.insure.rfq.service;

import com.insure.rfq.dto.DeclarationandclaimSubmissionImportantNotesDto;
import com.insure.rfq.dto.ImportantNotesDisplayDto;

import java.util.List;

public interface ClientListSubmissionImportantNotesService {

     String sbmitClaimDeclarationandclaimSubmissionImportantNotesCreation(DeclarationandclaimSubmissionImportantNotesDto dto,

                                                                          Long clientId, Long productId, Long employeeId);
   List  <ImportantNotesDisplayDto> getAllImportantNotesDisplayDto();
}
