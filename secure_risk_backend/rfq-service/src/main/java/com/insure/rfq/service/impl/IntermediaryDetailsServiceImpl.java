package com.insure.rfq.service.impl;

import com.insure.rfq.dto.IntermediaryDetailsDto;
import com.insure.rfq.dto.ProductCategoryChildDto;
import com.insure.rfq.dto.ProductChildDto;
import com.insure.rfq.entity.Product;
import com.insure.rfq.entity.ProductCategory;
import com.insure.rfq.repository.PolicyCoverageRepository;
import com.insure.rfq.repository.ProductRepository;
import com.insure.rfq.service.IntermediaryDetailsService;
import com.insure.rfq.service.ProductCategoryService;
import com.insure.rfq.service.ProductService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

@Service
@Slf4j
public class IntermediaryDetailsServiceImpl implements IntermediaryDetailsService {


	private ProductCategoryService service;


	private ProductService prodService;


	private ProductRepository productRepository;


	private PolicyCoverageRepository policyCoverageRepository;

	public IntermediaryDetailsServiceImpl(ProductCategoryService service, ProductService prodService, ProductRepository productRepository, PolicyCoverageRepository policyCoverageRepository) {
		this.service = service;
		this.prodService = prodService;
		this.productRepository = productRepository;
		this.policyCoverageRepository = policyCoverageRepository;
	}

	@Override
	public List<IntermediaryDetailsDto> getAllIntermediaryDetails() {
		List<Product> products = productRepository.findAll();

		List<IntermediaryDetailsDto> intermediaryDetailsList = new ArrayList<>();

		for (Product product : products) {
			if (product != null && product.getStatus() != null && product.getStatus().equalsIgnoreCase("ACTIVE")) {
				IntermediaryDetailsDto intermediaryDetailsDto = new IntermediaryDetailsDto();
				intermediaryDetailsDto.setProduct(product.getProductName());

				ProductCategory productCategory = product.getProductcategory();
				if (productCategory != null) {
					intermediaryDetailsDto.setProductCategory(productCategory.getCategoryName());
				} else {
					intermediaryDetailsDto.setProductCategory("null"); // or any default value you prefer
				}
				intermediaryDetailsDto.setProductId(product.getProductId());
				int coverageCount = policyCoverageRepository.getCoverageCount(product.getProductId());
				log.info("Coverage Count From Get All Products" + coverageCount);
				intermediaryDetailsDto.setCoverageCount(coverageCount);
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
				intermediaryDetailsDto.setCreatedDate(
						product.getCreatedDate() != null ? dateFormat.format(product.getCreatedDate()) : null);
				intermediaryDetailsDto.setUpdateDate(
						product.getUpdatedDate() != null ? dateFormat.format(product.getUpdatedDate()) : null);
				intermediaryDetailsDto.setRecordStatus(product.getStatus());
				intermediaryDetailsList.add(intermediaryDetailsDto);
			}
		}

		return intermediaryDetailsList;
	}

	public List<ProductCategoryChildDto> getAllProductcategories() {
		return service.findCategory();
	}

	public List<ProductChildDto> getProductcategoryById(Long id) {
		return prodService.getProductsByCategory(id);
	}

}
