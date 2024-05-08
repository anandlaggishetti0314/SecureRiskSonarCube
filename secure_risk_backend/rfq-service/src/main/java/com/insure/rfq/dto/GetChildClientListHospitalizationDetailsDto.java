package com.insure.rfq.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor@NoArgsConstructor
public class GetChildClientListHospitalizationDetailsDto {
    private String medicalExpensesBillNo;
    private String medicalExpensesBillDate;
    private Double medicalExpensesBillAmount;
    private String medicalExpensesRemarks;
}
