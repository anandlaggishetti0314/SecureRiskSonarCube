package com.insure.rfq.service.impl;

import com.insure.rfq.dto.EmpDependentHeaderDto;
import com.insure.rfq.entity.EmpDependentHeaderMapping;
import com.insure.rfq.entity.EmpDependentHeaders;
import com.insure.rfq.repository.EmpDependentHeaderMappingRepository;
import com.insure.rfq.repository.EmpDependentHeaderRepository;
import com.insure.rfq.service.EmpDependentHeaderService;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
@Slf4j
public class EmpDependentHeaderServiceImpl implements EmpDependentHeaderService {


	private EmpDependentHeaderRepository headersRepo;

	private EmpDependentHeaderMappingRepository headerMappingRepo;
	


	public EmpDependentHeaderServiceImpl(EmpDependentHeaderRepository headersRepo, EmpDependentHeaderMappingRepository headerMappingRepo) {
		this.headersRepo = headersRepo;
		this.headerMappingRepo = headerMappingRepo;
	}

	@Override
	public EmpDependentHeaderDto createHeaders(EmpDependentHeaderDto header) {
		
		EmpDependentHeaders findByHeaderNameAndHeaderCategory = headersRepo
				.findByHeaderNameAndHeaderCategory(header.getHeaderName(), header.getHeaderCategory());
		log.info("findByHeaderNameAndHeaderCategory :: " + findByHeaderNameAndHeaderCategory);
		String pattern = "yyyy-MM-dd";
		String active = "ACTIVE";
		if (findByHeaderNameAndHeaderCategory == null) {
			EmpDependentHeaders empHeaders = new EmpDependentHeaders();
			empHeaders.setHeaderName(header.getHeaderName());
			empHeaders.setHeaderCategory(header.getHeaderCategory());
			empHeaders.setStatus(active);
			empHeaders.setCreatedDate(new SimpleDateFormat(pattern).format(new Date()));
			headersRepo.save(empHeaders);

			EmpDependentHeaderMapping headerMapping = new EmpDependentHeaderMapping();
			headerMapping.setAliasName(header.getHeaderAliasname().getAliasName());
			headerMapping.setReportHeaders(empHeaders);
			headerMapping.setCreatedDate(new SimpleDateFormat(pattern).format(new Date()));
			headerMapping.setStatus(active);
			headerMappingRepo.save(headerMapping);

			header.setCreatedDate(new SimpleDateFormat(pattern).format(new Date()));
			header.setStatus(active);
			header.getHeaderAliasname().setCreatedDate(new SimpleDateFormat(pattern).format(new Date()));
			header.getHeaderAliasname().setStatus(active);
			return header;
		} else {
			EmpDependentHeaders findByHeaderName = headersRepo.findByHeaderName(header.getHeaderName());
			
			log.info("findByHeaderName :: "+findByHeaderName);
			EmpDependentHeaderMapping empHeadersMapping = new EmpDependentHeaderMapping();
			empHeadersMapping.setAliasName(header.getHeaderAliasname().getAliasName());
			empHeadersMapping.setCreatedDate(new SimpleDateFormat(pattern).format(new Date()));
			empHeadersMapping.setStatus(active);
			empHeadersMapping.setReportHeaders(findByHeaderName);
			headerMappingRepo.save(empHeadersMapping);

			header.setCreatedDate(new SimpleDateFormat(pattern).format(new Date()));
			header.setStatus(active);
			header.getHeaderAliasname().setCreatedDate(new SimpleDateFormat(pattern).format(new Date()));
			header.getHeaderAliasname().setStatus(active);
			return header;
		}
		
	}

	@Override
	public List<EmpDependentHeaders> viewAllHeaders() {
		return headersRepo.findAll();
	}

	@Override
	public List<String> getAllEmpDependentHeaders() {
		List<String> empDepHeaders = new ArrayList<>();
		List<EmpDependentHeaders> findAll = headersRepo.findAll();
		if(!findAll.isEmpty()) {
			findAll.stream().forEach(i -> empDepHeaders.add(i.getHeaderName()));
		}
		return empDepHeaders;
	}

}
