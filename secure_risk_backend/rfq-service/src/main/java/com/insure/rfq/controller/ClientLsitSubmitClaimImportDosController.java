package com.insure.rfq.controller;

import com.insure.rfq.dto.DeclarationandclaimSubmissionImportantNotesDto;
import com.insure.rfq.dto.ImportantNotesDisplayDto;
import com.insure.rfq.service.ClientListSubmissionImportantNotesService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/rfq/clientLsitSubmitClaim_ImportDos")
@CrossOrigin("*")
@Slf4j
public class ClientLsitSubmitClaimImportDosController {

    private ClientListSubmissionImportantNotesService submissionService;

    public ClientLsitSubmitClaimImportDosController(ClientListSubmissionImportantNotesService submissionService) {
        this.submissionService = submissionService;
    }


    @PostMapping("/saveImportantNotes")
    public String saveImportantNotesDisplayDto(@ModelAttribute DeclarationandclaimSubmissionImportantNotesDto dto , @RequestParam Long clientId, @RequestParam Long productId, @RequestParam Long employeeId) {

         return submissionService.sbmitClaimDeclarationandclaimSubmissionImportantNotesCreation(dto,  clientId, productId, employeeId);
   }
    
    @GetMapping("/getAllImportantNotesData")
    public List<ImportantNotesDisplayDto> getAllImportantNotesDisplayDto(){
    	return submissionService.getAllImportantNotesDisplayDto();
    }
}
