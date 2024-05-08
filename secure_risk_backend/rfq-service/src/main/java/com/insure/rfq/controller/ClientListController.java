package com.insure.rfq.controller;

import com.insure.rfq.dto.ClientListChildDto;
import com.insure.rfq.dto.ClientListDto;
import com.insure.rfq.dto.GetAllClientListDto;
import com.insure.rfq.repository.ClientListRepository;
import com.insure.rfq.service.impl.ClientListServiceImpl;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequestMapping("/rfq/clientList")
@RestController
@CrossOrigin(origins = { "*" })
public class ClientListController {


	private ClientListServiceImpl clientListServiceImpl;

	private ClientListRepository clientListRepository;

	public ClientListController(ClientListServiceImpl clientListServiceImpl, ClientListRepository clientListRepository) {
		this.clientListServiceImpl = clientListServiceImpl;
		this.clientListRepository = clientListRepository;
	}

	@PostMapping("/add")
	public ResponseEntity<ClientListDto> createClient(@RequestBody ClientListDto clientList) {
		ClientListDto createClientList = clientListServiceImpl.createClientList(clientList);
		return new ResponseEntity<>(createClientList, HttpStatus.CREATED);
	}

	@GetMapping("/getClient/{id}")
	public ResponseEntity<ClientListDto> getClientDetailsById(@PathVariable Long id) {
		ClientListDto clientById = clientListServiceImpl.getClientById(id);
		return ResponseEntity.ok(clientById);
	}



	@PutMapping("/updateClient/{id}")
	public ResponseEntity<ClientListChildDto> updateClient(@RequestBody ClientListChildDto clientListDto,
														   @PathVariable Long id) {
		ClientListChildDto updateClientList = clientListServiceImpl.updateClientList(clientListDto, id);
		return new ResponseEntity<>(updateClientList, HttpStatus.OK);
	}

	@DeleteMapping("/deleteClientByClientListId/{id}")
	public ResponseEntity<String> deleteClientByClientListId(@PathVariable Long id) {
		String deleteClientById = clientListServiceImpl.deleteClientById(id);
		return new ResponseEntity<>(deleteClientById, HttpStatus.OK);
	}

	@GetMapping("/getAllClientList")
	public ResponseEntity<List<GetAllClientListDto>> getAllClientList() {
		List<GetAllClientListDto> allClientList = clientListServiceImpl.getAllClientList();
		return ResponseEntity.ok(allClientList);
	}


	@GetMapping("/getdashboardClientCount")
	public List<Object[]> getRfqCounts() {
		return clientListRepository.countApplicationsByStatus();

	}
}