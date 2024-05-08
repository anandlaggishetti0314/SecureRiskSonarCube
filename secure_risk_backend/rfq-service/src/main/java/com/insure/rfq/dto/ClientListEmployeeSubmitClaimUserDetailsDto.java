package com.insure.rfq.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class ClientListEmployeeSubmitClaimUserDetailsDto {


    private String userdetailsId;

    private String patientName;
    private String employeeName;
    private String uhid;
    private String dateOfAdmission;
    private String dateOfDischarge;
    private String employeeId;
    private String email;
    private String mobileNumber;
    private String sumInsured;
    private String benificiaryName;
    private String relationToEmployee;
    private String claimNumber;


    private String rfqId;
    private String employeeDataID;  //fetch the data form employee table


}
