package com.insure.rfq.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CdbalanceHeaderStatusDto {

    private boolean policyNumber;
    private boolean transactionType;
    private boolean paymentDate;
    private boolean amount;
    private boolean creditedRecord;
    private boolean balance;
}
