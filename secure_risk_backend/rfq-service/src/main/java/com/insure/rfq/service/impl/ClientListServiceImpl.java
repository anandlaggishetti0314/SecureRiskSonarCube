package com.insure.rfq.service.impl;

import com.insure.rfq.dto.*;
import com.insure.rfq.entity.ClientList;
import com.insure.rfq.entity.InsureList;
import com.insure.rfq.entity.Product;
import com.insure.rfq.entity.Tpa;
import com.insure.rfq.exception.InvalidClientList;
import com.insure.rfq.exception.InvalidUser;
import com.insure.rfq.login.entity.Location;
import com.insure.rfq.login.repository.LocationRepository;
import com.insure.rfq.repository.*;
import com.insure.rfq.service.ClientListService;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@Slf4j
public class ClientListServiceImpl implements ClientListService {

	private ClientListRepository clientListRepository;

	private ProductRepository prodRepository;

	private ModelMapper mapper;

	private LocationRepository locationRepository;

	private TpaRepository tpaRepository;

	private InsureListRepository insureListRepository;

	private ClientListUserRepository clientListUserRepository;

	public ClientListServiceImpl(ClientListRepository clientListRepository, ProductRepository prodRepository, ModelMapper mapper, LocationRepository locationRepository, TpaRepository tpaRepository, InsureListRepository insureListRepository, ClientListUserRepository clientListUserRepository) {
		this.clientListRepository = clientListRepository;
		this.prodRepository = prodRepository;
		this.mapper = mapper;
		this.locationRepository = locationRepository;
		this.tpaRepository = tpaRepository;
		this.insureListRepository = insureListRepository;
		this.clientListUserRepository = clientListUserRepository;
	}
	String active = "ACTIVE";

	@Override
	public ClientListDto createClientList(ClientListDto clientListDto) {
		if (clientListDto != null) {
			ClientList clientListEntity = new ClientList();
			Optional<Location> location = locationRepository.findById(Long.parseLong(clientListDto.getLocationId()));
			log.info("Location From Create Client List", location);
			Optional<Product> products = prodRepository.findById(Long.parseLong(clientListDto.getProductId()));
			log.info("Product From Create Client List", products);
			Optional<Tpa> tpa = tpaRepository.findById(Long.parseLong(clientListDto.getTpaId()));
			log.info("Tpa From Create Client List", tpa);
			Optional<InsureList> insurers = insureListRepository.findById(clientListDto.getInsuranceCompanyId());
			log.info("Insurer From Create Client List", insurers);
			List<Product> listOfProducts = new ArrayList<>();
			listOfProducts.add(products.get());
			clientListEntity.setClientName(clientListDto.getClientName());
			clientListEntity.setLocationId(location.isPresent() ? location.get() : null);
			clientListEntity.setProduct(listOfProducts);
			clientListEntity.setPolicyType(clientListDto.getPolicyType());
			clientListEntity.setTpaId(tpa.isPresent() ? tpa.get() : null);
			clientListEntity.setInsureCompanyId(insurers.isPresent() ? insurers.get() : null);
			clientListEntity.setCreatedDate(LocalDateTime.now());

			clientListEntity.setStatus(active);
			ClientList savedClientList = clientListRepository.save(clientListEntity);
			Product productEntity = products.get();
			productEntity.setStatus(active);
			productEntity.getClientList().add(savedClientList);
			productEntity.setInsureCompanyId(clientListEntity.getInsureCompanyId());
			productEntity.setPolicyType(clientListEntity.getPolicyType());
			productEntity.setTpaId(clientListEntity.getTpaId());
			productEntity.setProductName(
					prodRepository.findById(Long.parseLong(clientListDto.getProductId())).get().getProductName());
			prodRepository.save(productEntity);
			ClientListDto listDto = mapper.map(savedClientList, ClientListDto.class);
			listDto.setInsuranceCompanyId(savedClientList.getInsureCompanyId().getInsurerName());
			listDto.setProductId(productEntity.getProductName());
			return listDto;
		} else {
			return null;
		}
	}

	@Override
	public ClientListDto getClientById(long id) {
		ClientList clientList = clientListRepository.findById(id)
				.orElseThrow(() -> new InvalidUser(" invalid user Id"));
		return mapper.map(clientList, ClientListDto.class);
	}

	@Override
	public List<ClientListDto> getAllClients(int pageNo, int size, String sort) {
		Pageable pageable = PageRequest.of(pageNo, size, Sort.by(sort).descending());
		Page<ClientList> clientListPage = clientListRepository.findAll(pageable);
		return clientListPage.getContent().stream().filter(list -> list.getStatus().equalsIgnoreCase(active))
				.map(list -> mapper.map(list, ClientListDto.class)).toList();
	}

	@Override
	public ClientListChildDto updateClientList(ClientListChildDto clientListChildDto, Long clientListid) {
		if (clientListChildDto != null) {
			ClientList clientList = clientListRepository.findById(clientListid)
					.orElseThrow(() -> new InvalidClientList("Id is not found"));
			log.info("ClientList From Update Client List", clientList);
			Optional<Location> location = locationRepository.findById(Long.parseLong(clientListChildDto.getLocation()));
			log.info("Location From Update Client List", location);
			clientListChildDto.setClientName(clientListChildDto.getClientName());
			clientListChildDto.setLocation(location.get().getLocationName());
			clientList.setClientName(clientListChildDto.getClientName());
			clientList.setLocationId(location.get());
			clientListRepository.save(clientList);
			return clientListChildDto;
		}
		return null;
	}

	@Override
	public String deleteClientById(Long clientId) {
		ClientList clientList = clientListRepository.findById(clientId).get();
		clientList.setStatus("INACTIVE");
		clientListRepository.save(clientList);
		return "Deleted Sucessfully";
	}

	@Override
	public List<GetAllClientListDto> getAllClientList() {
		List<GetAllClientListDto> list = clientListRepository.findAll().stream()
				.filter(obj -> obj.getStatus().equalsIgnoreCase(active)).map(obj -> {
					GetAllClientListDto allClientListDto = new GetAllClientListDto();
					allClientListDto.setClientName(obj.getClientName());
					allClientListDto.setClientId(obj.getCid());
					List<GetAllClientListUserByClientListIdDto> listOfUsers = clientListUserRepository
							.findByClientList(obj.getCid()).stream()
							.filter(users -> users.getClientList() != null
									&& users.getClientList().getStatus().equalsIgnoreCase(active)
									&& users.getStatus().equalsIgnoreCase(active))
							.map(users -> {
								GetAllClientListUserByClientListIdDto allClientListUserByClientListIdDto = new GetAllClientListUserByClientListIdDto();
								allClientListUserByClientListIdDto.setEmployeeId(users.getEmployeeId());
								allClientListUserByClientListIdDto.setEmailId(users.getMailId());
								allClientListUserByClientListIdDto.setName(users.getName());
								allClientListUserByClientListIdDto.setPhoneNumber(users.getPhoneNo());
								return allClientListUserByClientListIdDto;
							}).toList();
					List<GetAllProductsByClientListIdDto> listOfProducts = prodRepository.findByClientList(obj.getCid())
							.stream()
							.filter(users -> users.getClientList() != null && users.getInsureCompanyId() != null
									&& users.getClientList().stream()
											.anyMatch(client -> client.getStatus().equalsIgnoreCase(active))
									&& users.getStatus().equalsIgnoreCase(active))
							.map(product -> {
								GetAllProductsByClientListIdDto getProducts = new GetAllProductsByClientListIdDto();
								String categoryNameByProductId = prodRepository
										.findCategoryNameByProductId(product.getProductId());
								getProducts.setProductCategoryId(categoryNameByProductId);
								getProducts.setProductId(String.valueOf(product.getProductId()));
								getProducts.setProductName(product.getProductName());
								for (ClientList clientList : product.getClientList()) {
									if (clientList.getCid() == obj.getCid()
											&& clientList.getStatus().equalsIgnoreCase(active)) {
										if (clientList.getPolicyType() != null) {
											getProducts.setPolicyType(clientList.getPolicyType());
										} else {
											getProducts.setPolicyType(null);
										}

										if (clientList.getTpaId() != null) {
											getProducts.setTpaId(clientList.getTpaId().getTpaName());
										} else {
											getProducts.setTpaId(null);
										}

										if (clientList.getInsureCompanyId() != null) {
											getProducts.setInsurerCompanyId(
													clientList.getInsureCompanyId().getInsurerName());
										} else {
											getProducts.setInsurerCompanyId(null);
										}
										// Break the loop after fetching details from the correct ClientList
										break;
									}
								}
								return getProducts;
							}).toList();
					allClientListDto.setListOfUsers(listOfUsers);
					allClientListDto.setListOfProducts(listOfProducts);
					if (obj.getLocationId() != null) {
						allClientListDto.setLocation(obj.getLocationId().getLocationName());
					} else {
						allClientListDto.setLocation(null);
					}
					allClientListDto.setStatus(obj.getStatus());
					return allClientListDto;
				}).toList();
		int sno = 1; // Start sno from 1
		for (GetAllClientListDto dto : list) {
			dto.setSNO(sno);
			sno++; // Increment SNO for the next item
		}
		return list;
	}
}
