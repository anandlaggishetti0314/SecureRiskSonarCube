package com.insure.rfq.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ClientListClaimsTrackerDto {

    private String employeeId;
    private String employeeName;
    private String claimedAmount;
    private String claimNumber;

}