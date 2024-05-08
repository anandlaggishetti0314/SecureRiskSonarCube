package com.insure.rfq.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Entity
@Table(name =  "Submit_ClaimHospitalizationDetails")
@NoArgsConstructor
@AllArgsConstructor
public class ClientListEmployeeSubmitClaimHospitalizationDetails {
    //Hospitalization Details
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private  Long ClientListEmployeeClaimHospitalizationDetails;

    private String userdetailsId;
    private String state;
    private String city;
    private String hospitalName;
    private String hospitalAddress;
    private String natureofIllness;
    private String preHospitalizationAmount ;
    private String postHospitalizationAmount ;
    private String totalAmountClaimed ;
    private String hospitalizationAmount;
//Medical Expenses Details


    private List<String> medicalExpensesBillNo;

    private List<Double> medicalExpensesBillAmount;
    private List<String> medicalExpensesBillDate;

    private List<String> medicalExpensesRemarks;

    @Column(name = "RECORDSTATUS")
    private String recordStatus;
    @Column(name = "RFQID")
    private String rfqId;
    @ManyToOne
    @JoinColumn(referencedColumnName = "productId")
    private Product productId;
    @ManyToOne
    @JoinColumn(referencedColumnName = "cid")
    private ClientList clientListId;
    private String employeeDataID;  //fetch the data form employee table
    @Column(name = "CREATEDDATE")
    private String createdDate;
    @Column(name = "UPDATEDDATE")
    private String updatedDate;

}
