package com.insure.rfq.controller;

import com.insure.rfq.dto.DisplayAllECardDto;
import com.insure.rfq.dto.ECardDto;
import com.insure.rfq.dto.UpdateECardDto;
import com.insure.rfq.entity.ECardEntity;
import com.insure.rfq.repository.ECardRepository;
import com.insure.rfq.service.ECardService;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.*;
import java.util.List;
import java.util.Optional;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("clientList/ECard")
public class ECardController {

    private ECardService eCardService;

    private ECardRepository eCardRepository;

    public ECardController(ECardService eCardService, ECardRepository eCardRepository) {
        this.eCardService = eCardService;
        this.eCardRepository = eCardRepository;
    }

    @PostMapping("/createECard")
    public ResponseEntity<?> createClientDetails(@ModelAttribute ECardDto eCardDto, @RequestParam("clientListId") Long clientListId, @RequestParam("productId") Long productId) {
        ECardDto eCard = eCardService.create(eCardDto, clientListId, productId);
        return new ResponseEntity<>(eCard, HttpStatus.CREATED);
    }

    @GetMapping("/getAllECard")
    @ResponseStatus(HttpStatus.OK)

    public ResponseEntity<?> getAllEndorsements(
            @RequestParam("clientListId") Long clientListId,
            @RequestParam("productId") Long productId) {

        try {
            List<DisplayAllECardDto> allEndorsement = eCardService.getAllECard(clientListId, productId);
            return ResponseEntity.ok(allEndorsement);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body( e.getMessage());
        }
    }
    @GetMapping("/getAllECardbyId")
    @ResponseStatus(HttpStatus.OK)

    public ResponseEntity<?> getEcards(
            @RequestParam("clientListId") Long clientListId,
            @RequestParam("productId") Long productId,@RequestParam ("employeeId") String employeeId) {

        try {
            List<DisplayAllECardDto> allEndorsement = eCardService.getAllECardbyId(clientListId, productId, employeeId);
            return ResponseEntity.ok(allEndorsement);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body( e.getMessage());
        }
    }

    @GetMapping("/getByIdECard")
    @ResponseStatus(HttpStatus.OK)
    public DisplayAllECardDto getById(@RequestParam Long eCardId){
        return eCardService.getById(eCardId);

    }

    @DeleteMapping("/deleteECard/{eCardId}")
    @ResponseStatus(HttpStatus.OK)
    public String deleteECard(@PathVariable Long eCardId) {
        return eCardService.deleteECardById(eCardId);
    }



    @PutMapping("/updateECard/{eCardId}")
    @ResponseStatus(HttpStatus.OK)
    public String updateClientDetails(@ModelAttribute UpdateECardDto dto, @PathVariable Long eCardId) {

        return eCardService.updateECardById(dto,eCardId);

    }


    @GetMapping("/downloadFileByECardId")
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity<byte[]> downloadFile(@RequestParam Long eCardId) {
        try {
            // Retrieve the endorsement entity
            Optional<ECardEntity> endorsementOptional = eCardRepository.findById(eCardId);

            // Validate the endorsement
            if (endorsementOptional.isEmpty()) {
                return ResponseEntity.notFound().build();
            }

            ECardEntity endorsement = endorsementOptional.get();

            // Read file content
            byte[] fileContent = eCardService.downloadClientDetialsDocumentByClientDetialsId(eCardId);

            // Get the file extension from the fileName using service method
            String fileExtension = eCardService.getFileExtension(endorsement.getFileName());

            // Set content type based on file extension
            MediaType mediaType = MediaType.APPLICATION_OCTET_STREAM;
            if (fileExtension!= null) {
                mediaType = MediaType.valueOf("application/" + fileExtension.toLowerCase());
            }

            // Set response headers
            HttpHeaders headers = new HttpHeaders();
            headers.setContentDispositionFormData("attachment", endorsement.getFileName() + "." + fileExtension);
            headers.setContentType(mediaType);
            headers.setContentLength(fileContent.length);

            // Convert ByteArrayResource to byte[]
            ByteArrayResource resource = new ByteArrayResource(fileContent);
            byte[] resourceBytes = resource.getInputStream().readAllBytes();

            return ResponseEntity.ok().headers(headers).body(resourceBytes);
        } catch (IOException e) {
            // Handle exception appropriately (e.g., log, return error response)
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    @GetMapping("/downloadAll")
    public ResponseEntity<byte[]> downloadAllEndorsements(@RequestParam Long clientListId,@RequestParam Long productId) {
        try {
            List<ECardEntity> endorsements = eCardService.getAllECardDownload(clientListId,productId);

            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            try (ZipOutputStream zos = new ZipOutputStream(baos)) {
                for (ECardEntity endorsement : endorsements) {
                    // Check the status of the endorsement
                    if ("active".equalsIgnoreCase(endorsement.getRecordStatus())) {
                        String fileName1 = endorsement.getFileName();

                        File file = new File(fileName1);
                        if (file.exists()) {
                            // Logging for debugging


                            // Create a ZipEntry using the file name
                            ZipEntry entry = new ZipEntry(file.getName());
                            zos.putNextEntry(entry);

                            // Set the correct content type based on file extension
                            HttpHeaders headers = new HttpHeaders();
                            String contentType = getContentType(fileName1);

                            // Add the content type to the response header
                            headers.add(HttpHeaders.CONTENT_TYPE, contentType);

                            // Write the file data to the zip stream
                            try (InputStream is = new FileInputStream(file)) {
                                byte[] buffer = new byte[1024];
                                int bytesRead;
                                while ((bytesRead = is.read(buffer)) > 0) {
                                    zos.write(buffer, 0, bytesRead);
                                }
                            }
                            zos.closeEntry();
                        } else {
                            // Log or handle the case where the file does not exist

                        }
                    }
                }
            }

            byte[] zipBytes = baos.toByteArray();

            HttpHeaders headers = new HttpHeaders();
            headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=ECard.zip");

            // Set the overall content type for the zip file
            headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);

            return ResponseEntity.ok()
                    .headers(headers)
                    .contentLength(zipBytes.length)
                    .contentType(MediaType.APPLICATION_OCTET_STREAM)
                    .body(zipBytes);

        } catch (IOException e) {
            e.printStackTrace(); // Log the exception for further investigation
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }


    @GetMapping("/downloadFileByEmployeeId")
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity<?> downloadFileEmployeeId(@RequestParam String employeeId) {
        try {
            // Retrieve the endorsement entity
            Optional<ECardEntity> endorsementOptional = eCardRepository.findByEmployeeId(employeeId);
            if (endorsementOptional.isPresent()) {
                ECardEntity endorsement = endorsementOptional.get();

                // Validate the endorsement
                if (endorsement == null) {
                    return ResponseEntity.notFound().build();
                }

                // Read file content
                byte[] fileContent = eCardService.downloadClientDetialsDocumentByEmployeeId(employeeId);

                // Create a ByteArrayResource from file content
                ByteArrayResource resource = new ByteArrayResource(fileContent);

                // Get the file extension from the fileName using service method
                String fileExtension = eCardService.getFileExtension(endorsement.getFileName());

                // Set content type based on file extension
                MediaType mediaType = MediaType.APPLICATION_OCTET_STREAM;

                if (fileExtension!= null) {
                    mediaType = MediaType.valueOf("application/" + fileExtension.toLowerCase());
                }

                // Set response headers
                HttpHeaders headers = new HttpHeaders();
                headers.setContentDispositionFormData("attachment", endorsement.getFileName() + "." + fileExtension);
                headers.setContentType(mediaType);
                headers.setContentLength(fileContent.length);

                return ResponseEntity.ok().headers(headers).body(resource);
            } else {
                return ResponseEntity.notFound().build();
            }
        } catch (IOException e) {
            // Handle exception appropriately (e.g., log, return error response)
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }





    private String getContentType(String filename) {
        if (filename.endsWith(".pdf")) {
            return "application/pdf";
        } else if (filename.endsWith(".xlsx")) {
            return "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
        } else {
            return "application/octet-stream"; // Default to binary data if type is unknown
        }
    }

}
