package com.insure.rfq.dto;

import lombok.Data;

@Data
public class ClientListClaimsTotalCountDto {

	private Long approved;
	private Long pending;
	private Long rejected;

	private double approvedAmount;
	private double repudiatedAmount;
	private double outstandingAmount;

}