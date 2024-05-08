package com.insure.rfq.service.impl;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.insure.rfq.dto.*;
import com.insure.rfq.entity.*;
import com.insure.rfq.exception.InvalidClientList;
import com.insure.rfq.exception.InvalidProduct;
import com.insure.rfq.exception.InvalidUser;
import com.insure.rfq.repository.*;
import com.insure.rfq.service.ProductService;
import jakarta.transaction.Transactional;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
@Slf4j
public class ProductServiceImpl implements ProductService {

	private ProductRepository prodRepository;

	private ProductCategoryRepository prodCategoryRepository;
	private ClientListRepository clientListRepository;
	private ModelMapper modelMapper;

	private InsureListRepository insureListRepository;

	private TpaRepository tpaRepository;

	private final ObjectMapper objectMapper = new ObjectMapper();

	public ProductServiceImpl(ProductRepository prodRepository, ProductCategoryRepository prodCategoryRepository, ClientListRepository clientListRepository, ModelMapper modelMapper, InsureListRepository insureListRepository, TpaRepository tpaRepository) {
		this.prodRepository = prodRepository;
		this.prodCategoryRepository = prodCategoryRepository;
		this.clientListRepository = clientListRepository;
		this.modelMapper = modelMapper;
		this.insureListRepository = insureListRepository;
		this.tpaRepository = tpaRepository;
	}
	String active = "ACTIVE";

	@Override
	public ProductChildDto findProducts(Long productId) {
		ProductChildDto productChildDto = new ProductChildDto();
		Optional<Product> findProductNamesByCategory = prodRepository.findByProductId(productId);
		if (findProductNamesByCategory.isPresent()) {
			Product product = findProductNamesByCategory.get();
			productChildDto.setProductId(product.getProductId());
			productChildDto.setProductName(product.getProductName());
		}
		return productChildDto;
	}

	@Override
	public List<ProductChildDto> getProductsByCategory(Long productcategoryId) {
		List<Map<String, Object>> findProductNamesByCategory = prodRepository
				.findProductNamesByCategory(productcategoryId);
		List<ProductChildDto> products = new ArrayList<>();
		for (Map<String, Object> result : findProductNamesByCategory) {
			ProductChildDto dto = objectMapper.convertValue(result, ProductChildDto.class);
			products.add(dto);
		}
		return products;
	}

	@Override
	public ProductCreateDto addProduct(ProductCreateDto productDto) {
		log.info("ProductCategory From AddProduct ", productDto.getProductcategoryId());
		Optional<ProductCategory> prodcategory = prodCategoryRepository
				.findById(Long.parseLong(productDto.getProductcategoryId()));
		Product product = null;
		if (productDto != null && prodcategory.isPresent()) {
			product = new Product();
			product.setCreatedDate(new Date());
			product.setProductcategory(prodcategory.get());
			product.setProductName(productDto.getProductName());

			product.setStatus(active);
			prodRepository.save(product);
		} else {
			log.info("No Category");
		}
		return productDto;
	}

	@Override
	public AddProductClientDto createProduct(AddProductClientDto productDto, Long clientListId) {
		log.info("{}", productDto.toString());
		if (productDto != null) {
			ClientList clientList = clientListRepository.findById(clientListId)
					.orElseThrow(() -> new InvalidClientList("ClientList Id is not Present"));
			log.info("ClientList From Create ClientList Product", clientList);

			Product productEntity = prodRepository.findById(Long.parseLong(productDto.getProductId()))
					.orElseThrow(() -> new InvalidProduct("Product Not Found"));
			log.info("Product From Create ClientList Product", productEntity);

			// Handle optional fields and set them to null in the response if not provided
			if (productDto.getPolicyType() != null) {
				clientList.setPolicyType(productDto.getPolicyType());
			} else {
				productDto.setPolicyType(null);
			}

			if (productDto.getTpaId() != null) {
				Optional<Tpa> tpa = tpaRepository.findById(Long.parseLong(productDto.getTpaId()));
				log.info("Tpa From Create ClientList Product", tpa);
				clientList.setTpaId(tpa.isPresent() ? tpa.get() : null);
			} else {
				productDto.setTpaId(null);
			}

			if (productDto.getInsurerCompanyId() != null) {
				Optional<InsureList> insurer = insureListRepository.findById(productDto.getInsurerCompanyId());
				log.info("Insurers From Create ClientList Product", insurer);
				clientList.setInsureCompanyId(insurer.get());
			} else {
				productDto.setInsurerCompanyId(null);
			}

			// Add the Product to the ClientList
			clientList.getProduct().add(productEntity);

			// Add the ClientList to the Product
			productEntity.getClientList().add(clientList);

			// Save only the ClientList entity
			clientListRepository.save(clientList);

			// Set additional fields in your DTO based on the relationships
			productDto.setInsurerCompanyId(clientList.getInsureCompanyId().getInsurerName());
			productDto.setProductId(prodRepository.findById(productEntity.getProductId()).get().getProductName());

			// Return null in the response for fields that were not provided
			if (productDto.getTpaId() != null) {
				productDto.setTpaId(clientList.getTpaId() != null ? clientList.getTpaId().getTpaName() : null);
			} else {
				productDto.setTpaId(null);
			}

			return productDto;
		}

		return null; // Return null if the request is null
	}

	@Override
	public List<ProductDto> getAllProducts(Long id) {
		return prodRepository.findAll().stream().filter(user -> {
			List<ClientList> clientList = user.getClientList();
			return clientList != null && clientList.stream().anyMatch(client -> client.getCid() == id)
					&& user.getStatus().equalsIgnoreCase(active);
		}).map(users -> modelMapper.map(users, ProductDto.class)).toList();
	}

	@Override
	public ProductIntermediaryDto updatePoductById(Long productId, ProductIntermediaryDto productDto) {
		Product product = prodRepository.findById(productId).get();
		product.setProductName(productDto.getProductName());
		product.setUpdatedDate(new Date());
		log.info("Product From Update Product ",
				prodCategoryRepository.findByCategoryName(productDto.getCategoryName()).toString());
		product.setProductcategory(prodCategoryRepository.findByCategoryName(productDto.getCategoryName()));
		prodRepository.save(product);
		return productDto;
	}

	@Override
	public String deletePoductById(Long productId) {
		Product product = prodRepository.findById(productId).orElseThrow(() -> new InvalidUser("user Not Found"));
		product.setStatus("INACTIVE");
		prodRepository.save(product);
		return "Deleted Successfully";
	}

	@Override
	public List<GetProductDropdownDto> getAllProductsWithId() {
		List<Product> products = prodRepository.findAll();
		List<GetProductDropdownDto> productsWithId = new ArrayList<>();
		for (Product getProductWithIdDto : products) {
			if (getProductWithIdDto.getStatus().equalsIgnoreCase(active)) {
				GetProductDropdownDto productWithIdDto = new GetProductDropdownDto();
				productWithIdDto.setProductId(getProductWithIdDto.getProductId());
				productWithIdDto.setProductName(getProductWithIdDto.getProductName());
				productsWithId.add(productWithIdDto);
			}
		}
		return productsWithId;
	}

	@Override
	public List<GetAllProductsByClientListIdDto> getAllProductsByClientListId(Long clientListId) {
		return prodRepository.findAll().stream()
				.filter(product -> product.getClientList() != null
						&& product.getClientList().stream().anyMatch(clientList -> clientList.getCid() == clientListId)
						&& product.getClientList().stream()
								.anyMatch(clientList -> clientList.getStatus().equalsIgnoreCase(active))
						&& product.getStatus().equalsIgnoreCase(active))
				.map(product -> {
					GetAllProductsByClientListIdDto dto = new GetAllProductsByClientListIdDto();
					dto.setProductId(String.valueOf(product.getProductId()));
					dto.setProductName(product.getProductName());
					// Fetch fields from the ClientList entity
					for (ClientList clientList : product.getClientList()) {
						if (clientList.getCid() == clientListId && clientList.getStatus().equalsIgnoreCase("")) {
							if (clientList.getPolicyType() != null) {
								dto.setPolicyType(clientList.getPolicyType());
							} else {
								dto.setPolicyType(null);
							}

							if (clientList.getTpaId() != null) {
								dto.setTpaId(clientList.getTpaId().getTpaName());
							} else {
								dto.setTpaId(null);
							}

							if (clientList.getInsureCompanyId() != null) {
								dto.setInsurerCompanyId(clientList.getInsureCompanyId().getInsurerName());
							} else {
								dto.setInsurerCompanyId(null);
							}
							// Break the loop after fetching details from the correct ClientList
							break;
						}
					}

					return dto;
				}).toList();
	}


	// update ClientList
	@Transactional
	public AddProductClientDto updateClientListProduct(Long clientId, Long productId,
			AddProductClientDto addProductClientDto) {
		if (clientId != null && productId != null) {
			Optional<ClientList> clientOptional = clientListRepository.findById(clientId);
			log.info("ClientList from Update ClientList Product:{}", clientOptional.orElse(null));

			Optional<Product> productOptional = prodRepository.findById(productId);
			log.info("Product from Update ClientList Product:{}", productOptional.orElse(null));

			if (clientOptional.isPresent() && productOptional.isPresent()) {
				// Update the product relationship within a transaction

				updateProductRelationship(Long.parseLong(addProductClientDto.getProductId()), clientId, productId);


				if (addProductClientDto.getInsurerCompanyId() != null
						&& !addProductClientDto.getInsurerCompanyId().trim().isEmpty()) {
					Optional<InsureList> insurer = insureListRepository
							.findById(addProductClientDto.getInsurerCompanyId());
					addProductClientDto.setInsurerCompanyId(insurer.map(InsureList::getInsurerName).orElse(null));
				} else {
					addProductClientDto.setInsurerCompanyId(null);
				}

				if (addProductClientDto.getTpaId() != null && !addProductClientDto.getTpaId().trim().isEmpty()) {
					Optional<Tpa> tpa = tpaRepository.findById(Long.parseLong(addProductClientDto.getTpaId()));
					addProductClientDto.setTpaId(tpa.map(Tpa::getTpaName).orElse(null));
				} else {
					addProductClientDto.setTpaId(null);
				}

				if (addProductClientDto.getPolicyType() != null
						&& !addProductClientDto.getPolicyType().trim().isEmpty()) {
					addProductClientDto.setPolicyType(addProductClientDto.getPolicyType());
				} else {
					addProductClientDto.setPolicyType(null);
				}

				return addProductClientDto;
			}
		}

		return null;
	}

	@Transactional
	public void updateProductRelationship(Long newProductId, Long clientListId, Long oldProductId) {
		log.info("newProductId: {}, clientListId: {}, oldProductId: {}", newProductId, clientListId, oldProductId);
		clientListRepository.updateProductRelationship(newProductId, clientListId, oldProductId);
	}

	@Override
	@Transactional
	public String deleteProductRelationForClientList(Long productId, Long clientListId) {
		clientListRepository.deleteProductRelationShip(productId, clientListId);

		return "Product relation deleted successfully for client list";
	}

}