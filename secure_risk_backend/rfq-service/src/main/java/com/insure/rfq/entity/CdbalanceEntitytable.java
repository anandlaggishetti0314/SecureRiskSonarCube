package com.insure.rfq.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "Cd_balanceEntitytable")
public class CdbalanceEntitytable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long cdbalanceId;

    private String policyNumber;
    private String transactionType;
    private String paymentDate;
    private Double amount;
    private String CR_DB_CD;
    private Double balance;


    @ManyToOne
    @JoinColumn(referencedColumnName = "productId")
    private Product productId;

    @ManyToOne
    @JoinColumn(referencedColumnName = "cid")
    private ClientList clientListId;

    private  String rfqId;
    private String createdDate;

    private String updatedDate;

    private String recordStatus;
}
