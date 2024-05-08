package com.insure.rfq.controller;

import com.insure.rfq.dto.*;
import com.insure.rfq.repository.CorporateDetailsRepository;
import com.insure.rfq.service.CorporateDetailsService;
import com.insure.rfq.service.impl.EmailService;
import jakarta.validation.Valid;
import lombok.NoArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/rfq/corporateDetails")
@CrossOrigin(origins = "*")
@NoArgsConstructor
public class CorporateDetailsController {

    CorporateDetailsService corporateDetailsService;

    private EmailService emailService;

    private CorporateDetailsRepository corporateDetailsRepository;

    public CorporateDetailsController(CorporateDetailsService corporateDetailsService, EmailService emailService, CorporateDetailsRepository corporateDetailsRepository) {
        this.corporateDetailsService = corporateDetailsService;
        this.emailService = emailService;
        this.corporateDetailsRepository = corporateDetailsRepository;
    }

    @PostMapping("/createCorporateDetails")
    public ResponseEntity<String> createCpIp(@Valid @RequestBody CorporateDetailsDto details) {
        String rfqId = corporateDetailsService.createRFQ(details);
        return new ResponseEntity<>(rfqId, HttpStatus.CREATED);
    }

    @GetMapping("/getRfqById")
    public RFQCompleteDetailsDto getRfqById(@RequestParam String rfqId) {
        return corporateDetailsService.getRfqById(rfqId);
    }

    @GetMapping("/allRfq")
    public List<AllRFQDetailsDto> allRfq() {
        return corporateDetailsService.getAllRFQs();
    }

    @PatchMapping("/sendRFQ/{rfqId}")
    public ResponseEntity<String> sendRFQ(@PathVariable("rfqId") String rfqId,
                                          @RequestBody CorporateDetailsDto corporateDetailsDto) {
        String sendRFQmsg = corporateDetailsService.submitRfq(rfqId, corporateDetailsDto);
        return new ResponseEntity<>(sendRFQmsg, HttpStatus.OK);
    }

    @PatchMapping("/updateRFQ")
    @ResponseStatus(HttpStatus.OK)
    public UpdateCorporateDetailsDto createCpIp(@RequestParam String rfqIdValue,
                                                @RequestBody UpdateCorporateDetailsDto details) {
        return corporateDetailsService.updateRFQ(rfqIdValue, details);
    }

    @GetMapping("/send")
    public String sendEmailWithAttachment() {
        String toEmail = "viswanadh.chinnam@ojas-it.com";
        String subject = "PDF Attachment Test";
        String body = "Please find the attached PDF file.";

        // Assuming your PDF file is in the resources directory
        String attachmentFileName = "example.pdf";

        corporateDetailsService.sendEmailWithAttachment(toEmail, subject, body, attachmentFileName);
        return "Email sent successfully!";
    }

    @PostMapping("/send-email")
    public ResponseEntity<String> sendEmail(@RequestBody EmailRequest emailRequest) {
        try {
            emailService.sendEmailWithAttachment(emailRequest);
            return ResponseEntity.ok("Email sent with attachment!");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Failed to send email with attachment.");
        }
    }


    @GetMapping("/getdashboardrfqCount")
    public List<Object[]> getRfqCounts() {
        return corporateDetailsRepository.countApplicationsByStatus();

    }

    @GetMapping("/getdashboardrfqmonthCount")
    public List<Object[]> getRfqmonthCounts() {
        return corporateDetailsRepository.monthcountApplicationsByStatus();

    }

    @GetMapping("/getDashboardRfqMonthYearCount")
    public ResponseEntity<DashBoardDto> getAllDashBoardDetailsBasedOnMonthAndYear(@RequestParam String month,
                                                                                  @RequestParam int year) throws Exception {

        return new ResponseEntity<>(corporateDetailsService.getCooperateDetailsInfoBasedOnMonthYear(month, year),
                HttpStatus.OK);
    }

    @GetMapping("/getdashboardCountBasedOnLocation/{location}")
    @ResponseStatus(value = HttpStatus.OK)
    public List<GetRfqCountWithLocationDto> getdashboardCountBasedOnLocation(@PathVariable("location") Long location) {
        return corporateDetailsService.getApplicationStatusCountByLocation(location);
    }
}
