package com.insure.rfq.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@Data
@NoArgsConstructor
public class ClientListEmployeeClaimIntimmationDto {


    private String patientName;
    private String relationToEmployee;
    private String employeeName;
    private String emailId;
    private String hospital;
    private String doctorName;
    private String uhid;
    private String employeeId;
    private String mobileNumber;
    private String reasonForAdmission;
    private String dateOfHospitalisation;
    private String otherDetails;

    private  String  sumInsured;
    private String reasonforClaim;



}
