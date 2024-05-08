package com.insure.rfq.service.impl;

import com.insure.rfq.dto.ExcelReportHeadersDto;
import com.insure.rfq.entity.ExcelReportHeaders;
import com.insure.rfq.entity.ExcelReportHeadersMapping;
import com.insure.rfq.repository.ExcelReportHeadersMappingRepository;
import com.insure.rfq.repository.ExcelReportHeadersRepository;
import com.insure.rfq.service.ExcelReportHeadersService;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
@Slf4j
public class ExcelReportHeadersServiceImpl implements ExcelReportHeadersService {


	private ExcelReportHeadersRepository headersRepo;

	private ExcelReportHeadersMappingRepository headerMappingRepo;



	public ExcelReportHeadersServiceImpl(ExcelReportHeadersRepository headersRepo, ExcelReportHeadersMappingRepository headerMappingRepo) {
		this.headersRepo = headersRepo;
		this.headerMappingRepo = headerMappingRepo;

	}

	@Override
	public ExcelReportHeadersDto createHeaders(ExcelReportHeadersDto header) {


		ExcelReportHeaders findByHeaderNameAndHeaderCategory = headersRepo
				.findByHeaderNameAndHeaderCategory(header.getHeaderName(), header.getHeaderCategory());
		log.info("findByHeaderNameAndHeaderCategory :: " + findByHeaderNameAndHeaderCategory);
		String active = "ACTIVE";
		if (findByHeaderNameAndHeaderCategory == null) {
			ExcelReportHeaders excelHeaders = new ExcelReportHeaders();
			excelHeaders.setHeaderName(header.getHeaderName());
			excelHeaders.setHeaderCategory(header.getHeaderCategory());
			excelHeaders.setStatus(active);
			excelHeaders.setCreatedDate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
			headersRepo.save(excelHeaders);

			ExcelReportHeadersMapping headerMapping = new ExcelReportHeadersMapping();
			headerMapping.setAliasName(header.getHeaderAliasname().getAliasName());
			headerMapping.setReportHeaders(excelHeaders);
			headerMapping.setCreatedDate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
			headerMapping.setStatus(active);
			headerMappingRepo.save(headerMapping);

			header.setCreatedDate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
			header.setStatus(active);
			header.getHeaderAliasname().setCreatedDate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
			header.getHeaderAliasname().setStatus(active);
			return header;
		} else {
			ExcelReportHeaders findByHeaderName = headersRepo.findByHeaderName(header.getHeaderName());

			ExcelReportHeadersMapping excelReportHeadersMapping = new ExcelReportHeadersMapping();
			excelReportHeadersMapping.setAliasName(header.getHeaderAliasname().getAliasName());
			excelReportHeadersMapping.setCreatedDate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
			excelReportHeadersMapping.setStatus(active);
			excelReportHeadersMapping.setReportHeaders(findByHeaderName);
			ExcelReportHeadersMapping validateHeaderMapping = headerMappingRepo.save(excelReportHeadersMapping);


			header.setCreatedDate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
			header.setStatus(active);
			header.getHeaderAliasname().setCreatedDate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
			header.getHeaderAliasname().setStatus(active);
			return header;
		}
	}

	@Override
	public List<ExcelReportHeaders> viewAllHeaders() {
		return headersRepo.findAll();
	}

}
