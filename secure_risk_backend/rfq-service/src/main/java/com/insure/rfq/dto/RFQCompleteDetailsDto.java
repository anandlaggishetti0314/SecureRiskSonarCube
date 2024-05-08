package com.insure.rfq.dto;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

@Data
public class RFQCompleteDetailsDto {
//	@JsonProperty(value = "rfq")
	@JsonProperty(value = "corporateDetails")
	private CorporateDetailsDto corporateDetails;
	@JsonProperty(value = "coverageDetails")
	private CoverageDetailsDto coverageDetails;
	@JsonProperty(value = "policyTerms")
	private List<PolicyTermsDto> policyTerms;
}
