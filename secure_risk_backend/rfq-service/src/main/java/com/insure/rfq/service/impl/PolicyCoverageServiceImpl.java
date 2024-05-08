package com.insure.rfq.service.impl;

import com.insure.rfq.dto.PolicyCoverageDto;
import com.insure.rfq.entity.PolicyCoverageEntity;
import com.insure.rfq.entity.Product;
import com.insure.rfq.repository.PolicyCoverageRepository;
import com.insure.rfq.repository.ProductRepository;
import com.insure.rfq.service.PolicyCoverageService;
import jakarta.transaction.Transactional;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@Slf4j
public class PolicyCoverageServiceImpl implements PolicyCoverageService {


	private PolicyCoverageRepository policyCoverageRepository;


	private ProductRepository productRepository;


	private ModelMapper mapper;

	public PolicyCoverageServiceImpl(PolicyCoverageRepository policyCoverageRepository, ProductRepository productRepository, ModelMapper mapper) {
		this.policyCoverageRepository = policyCoverageRepository;
		this.productRepository = productRepository;
		this.mapper = mapper;
	}

	@Override
	@Transactional
	public PolicyCoverageDto createCoverageByProductId(Long productId, PolicyCoverageDto policyCoverageDto) {
		Optional<Product> optionalProduct = productRepository.findById(productId);
		if (optionalProduct.isPresent()) {
			Product product = optionalProduct.get();

			PolicyCoverageEntity coverageEntity = mapper.map(policyCoverageDto, PolicyCoverageEntity.class);
			coverageEntity.setProduct(product);
			coverageEntity.setStatus("ACTIVE");
			policyCoverageRepository.save(coverageEntity);

			return mapper.map(coverageEntity, PolicyCoverageDto.class);
		}
		return null;
	}

	@Override
	public List<PolicyCoverageDto> getCoveragesByProductId(Long productId) {
		return policyCoverageRepository.getCoveragesByProductId(productId).stream()
				.filter(coverage -> coverage.getStatus().equalsIgnoreCase("ACTIVE")).map(coverage -> {
					PolicyCoverageDto coverageDto = new PolicyCoverageDto();
					coverageDto.setCoverageId(coverage.getId());
					coverageDto.setCoverage(coverage.getCoverage());
					return coverageDto;
				}).toList();
	}

	@Override
	public PolicyCoverageDto updateCoveragesByProductId(Long policyCoverageId, PolicyCoverageDto policyCoverageDto) {
		Optional<PolicyCoverageEntity> policyCoverage = policyCoverageRepository.findById(policyCoverageId);
		log.info("Coverage From Update Coverage", policyCoverage);
		policyCoverage.get().setCoverage(policyCoverageDto.getCoverage());
		policyCoverageRepository.save(policyCoverage.get());
		return mapper.map(policyCoverage, PolicyCoverageDto.class);

	}

	@Override
	public String deleteCoveragesByProductId(Long policyCoverageId) {
		Optional<PolicyCoverageEntity> coverage = policyCoverageRepository.findById(policyCoverageId);
		log.info("Coverage From Delete Coverage", coverage);
		coverage.get().setStatus("INACTIVE");
		policyCoverageRepository.save(coverage.get());
		return "Deleted Successfully";
	}

}
