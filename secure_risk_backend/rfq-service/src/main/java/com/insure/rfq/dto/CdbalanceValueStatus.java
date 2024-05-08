package com.insure.rfq.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CdbalanceValueStatus {
    private String policyNumber;
    private boolean policyNumberStatus;
    private String policyNumberErrorMessage;


    private String transactionType;
    private String transactionTypeErrorMessage;
    private boolean transactionTypeStatus;

    private String paymentDate;
    private String paymentDateErrorMessage;
    private boolean paymentDateStatus;

    private Double amount;
    private String amountErrorMessage;
    private boolean amountStatus;

    private String creditedRecord;
    private String creditedRecordErrorMessage;
    private boolean creditedRecordStatus;

    private Double balance;
    private String balanceErrorMessage;
    private boolean balanceStatus;
}
