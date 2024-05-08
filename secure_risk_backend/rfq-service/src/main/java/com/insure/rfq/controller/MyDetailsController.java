package com.insure.rfq.controller;

import com.insure.rfq.dto.DisplayAllMyDetailsDto;
import com.insure.rfq.dto.MyDetailsDto;
import com.insure.rfq.dto.UpdateMyDetailsDto;
import com.insure.rfq.service.MyDetailsService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/clientList/myDetails")
@CrossOrigin(origins = "*")
public class MyDetailsController {


	private MyDetailsService myDetailsService;




	public MyDetailsController(MyDetailsService myDetailsService) {
		this.myDetailsService = myDetailsService;

	}

	@PostMapping("/createMyDetails")
	public ResponseEntity<?> createMyDetails(@ModelAttribute MyDetailsDto myDetailsDto,
			@RequestParam("clientListId") Long clientListId, @RequestParam("productId") Long productId) {
		MyDetailsDto myDetailsDto1 = myDetailsService.createMyDetails(myDetailsDto, clientListId, productId);
		return new ResponseEntity<>(myDetailsDto1, HttpStatus.CREATED);
	}

	@GetMapping("/getAllMyDetails")
	@ResponseStatus(HttpStatus.OK)
	public List<DisplayAllMyDetailsDto> getAllMyDetails(@RequestParam Long clientListId, @RequestParam Long productId) {
		return myDetailsService.getAllMyDetail(clientListId, productId);
	}

	@GetMapping("/getByIdMyDetails")
	@ResponseStatus(HttpStatus.OK)
	public DisplayAllMyDetailsDto getById(@RequestParam Long myDetailId) {
		return myDetailsService.getById(myDetailId);
	}

	@PutMapping("/updateMyDetails/{myDetailId}")
	@ResponseStatus(HttpStatus.OK)
	public String updateMyDetails(@ModelAttribute UpdateMyDetailsDto dto, @PathVariable Long myDetailId) {

		return myDetailsService.updateMyDetailsById(dto, myDetailId);
	}

	@DeleteMapping("/deleteMyDetails/{myDetailId}")
	@ResponseStatus(HttpStatus.OK)
	public String deleteMyDetails(@PathVariable Long myDetailId) {
		return myDetailsService.deleteMyDetailsById(myDetailId);
	}

	

}
