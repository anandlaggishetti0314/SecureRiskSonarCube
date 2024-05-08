package com.insure.rfq.controller;

import com.insure.rfq.login.dto.DepartmentLoginDto;
import com.insure.rfq.login.service.DepatmentService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@Slf4j
@RequestMapping("/rfq")
@CrossOrigin(origins = { "*" })
public class DepartmentController {

	private DepatmentService depatmentService;

	public DepartmentController(DepatmentService depatmentService) {
		this.depatmentService = depatmentService;
	}


	@GetMapping("/getAllDepartment")
	@ResponseStatus(value = HttpStatus.OK)
	public List<DepartmentLoginDto> getAllDepartmentDetails() {
		return depatmentService.getAllDepartment();
	}

}
