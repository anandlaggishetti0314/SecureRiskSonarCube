package com.insure.rfq.controller;

import com.insure.rfq.dto.ProductCategoryChildDto;
import com.insure.rfq.service.ProductCategoryService;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/rfq/category")
@CrossOrigin(origins = "*")
public class ProductCategoryController {

	private ProductCategoryService service;

	public ProductCategoryController(ProductCategoryService service) {
		this.service = service;
	}

	@GetMapping("/prodCategory")
	public List<ProductCategoryChildDto> prodCategory() {
		return service.findCategory();
	}
}
