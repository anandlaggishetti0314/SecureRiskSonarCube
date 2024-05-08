package com.insure.rfq.service;

import com.insure.rfq.dto.ClaimAnayalisMisReportDto;

public interface ClientListClaimsMisAnalysisService {
	ClaimAnayalisMisReportDto generateReport(Long clientListId, Long productId);

}
