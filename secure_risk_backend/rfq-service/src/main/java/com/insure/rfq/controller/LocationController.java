package com.insure.rfq.controller;

import com.insure.rfq.login.dto.LocationLoginDto;
import com.insure.rfq.login.service.impl.LocationServiceImpl;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequestMapping("/location")
@RestController
@CrossOrigin(origins = { "*" })
public class LocationController {


	private LocationServiceImpl locationServiceImpl;

	public LocationController(LocationServiceImpl locationServiceImpl) {
		this.locationServiceImpl = locationServiceImpl;
	}

	@GetMapping("/getAllLocations")
	@ResponseStatus(value = HttpStatus.OK)
	public List<LocationLoginDto> getAllLocations() {
		return locationServiceImpl.getAllLocations();

	}

}
