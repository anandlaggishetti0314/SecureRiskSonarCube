package com.insure.rfq.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ClientListEmployeeSubmitClaimHospitalizationDetailsDto {
    private String userdetailsId;
    private String state;
    private String city;
    private String hospitalName;
    private String hospitalAddress;
    private String natureofIllness;
    private String preHospitalizationAmount;
    private String postHospitalizationAmount;
    private String totalAmountClaimed;
    private String hospitalizationAmount;
//Medical Expenses Details

    private List<String> medicalExpensesBillNo;

    private List<Double> medicalExpensesBillAmount;
    private List<String> medicalExpensesBillDate;

    private List<String> medicalExpensesRemarks;

}
