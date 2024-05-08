package com.insure.rfq.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CdbalanceDisplayDto {
    private String policyNumber;
    private String transactionType;
    private String paymentDate;
    private Double amount;
    private String creditedRecord;
    private Double balance;
    private Long cdbalanceId;
}
