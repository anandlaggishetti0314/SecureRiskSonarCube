package com.insure.rfq.controller;

import com.insure.rfq.entity.RequiredDocument;
import com.insure.rfq.service.ClientListSubmitService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;



@RestController
@RequestMapping("/client")
@CrossOrigin(origins = "*")
public class ClientListSubmitController {
    private ClientListSubmitService requiredDocumentService;

    public ClientListSubmitController(ClientListSubmitService requiredDocumentService) {
        this.requiredDocumentService = requiredDocumentService;
    }

    @PostMapping("/upload")
    public ResponseEntity<String> uploadFile(@RequestParam("documentType") RequiredDocument documentType,
                                             @RequestParam("employeeId") String employeeId,
                                             @ModelAttribute("file") MultipartFile file,
                                             
                                             @RequestParam String UserID) {
        try {
            requiredDocumentService.saveRequiredDocument(documentType, employeeId, file,UserID);
            return new ResponseEntity<>("File uploaded successfully", HttpStatus.OK);
        } catch (IOException e) {
            e.printStackTrace();
            return new ResponseEntity<>("Failed to upload file", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
