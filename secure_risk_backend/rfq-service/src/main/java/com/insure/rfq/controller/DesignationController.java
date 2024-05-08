package com.insure.rfq.controller;

import com.insure.rfq.login.dto.DesignationLoginDto;
import com.insure.rfq.login.service.DesignationService;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/rfq/designation")
@CrossOrigin(origins = {"*"})
public class DesignationController {

    private DesignationService designationService;

    public DesignationController(DesignationService designationService) {
        this.designationService = designationService;
    }


    @GetMapping("/getAllDesignation")
    @ResponseStatus(value = HttpStatus.OK)
    public List<DesignationLoginDto> getAllDesignation() {
        return designationService.getAllDesiDesignation();
    }

}
