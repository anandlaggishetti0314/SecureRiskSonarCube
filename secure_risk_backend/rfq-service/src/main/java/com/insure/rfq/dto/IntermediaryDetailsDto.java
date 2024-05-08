package com.insure.rfq.dto;

import lombok.Data;

@Data
public class IntermediaryDetailsDto {

	private Long productId;
	private String product;
	private String productCategory;
	private int coverageCount;

	private String createdDate;
	private String updateDate;
	private String recordStatus;
}