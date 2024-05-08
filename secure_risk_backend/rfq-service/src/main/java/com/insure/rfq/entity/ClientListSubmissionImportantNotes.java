package com.insure.rfq.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "CLIENT_LIST_DECLARATION_SUBMISSION_IMPORTANT_DOCS")
public class ClientListSubmissionImportantNotes {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long declarationsubmissionimportedDocumentsId;

    private String userdetailsId;
    private String declarationsubmisssionId;


    private String proofidType; // select the type of the Account;
    private String idproof;           // select the proof NAME WE HAVE TO GIVE
    private String idproofUpload;//  we have to upload the proof

    @Column(name = "RFQID")
    private String rfqId;

    @ManyToOne
    @JoinColumn(referencedColumnName = "productId")
    private Product productId;

    @ManyToOne
    @JoinColumn(referencedColumnName = "cid")
    private ClientList clientListId;

    @Column(name = "CREATEDDATE")
    private String createdDate;
    @Column(name = "RECORD_STATUS")
    private String recordStatus;

    private  String employeeDataID;

    @Column(name = "UPDATEDDATE")
    private String updatedDate;

}
