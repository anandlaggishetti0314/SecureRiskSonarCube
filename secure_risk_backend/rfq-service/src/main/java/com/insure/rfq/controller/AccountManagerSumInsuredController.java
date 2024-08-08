package com.insure.rfq.controller;

import com.insure.rfq.dto.AccountManagerSumInsuredDisplayDto;
import com.insure.rfq.dto.AccountManagerSumInsuredDto;
import com.insure.rfq.service.AccountManagerSumInsuredService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/rfq/accountManagerSumInsured")
@CrossOrigin("*")
@Slf4j
public class AccountManagerSumInsuredController {

//     this is an autowired class for the accountcontroller
    private final AccountManagerSumInsuredService sumInsuredService;

    public AccountManagerSumInsuredController(AccountManagerSumInsuredService sumInsuredService) {
        this.sumInsuredService = sumInsuredService;
    }

    @PostMapping("/createAccountManagerSumInsuredDetails")
    @ResponseStatus(HttpStatus.CREATED)
    public String createAccountManagerSumInsuredDetails(
            @ModelAttribute AccountManagerSumInsuredDto sumInsuredDisplayDto, @RequestParam Long clientListId,
            @RequestParam Long productId) {
        return sumInsuredService.createAccountManagerSumInsured(sumInsuredDisplayDto,
                clientListId, productId);


    }

    @GetMapping("/getAllAccountManagerSumInsuredDetails")
    @ResponseStatus(HttpStatus.OK)
    public List<AccountManagerSumInsuredDisplayDto> getAllAccountManagerSumInsuredetails(@RequestParam Long clientListId,
                                                                                         @RequestParam Long productId) {
        return sumInsuredService.getAllSumInsuredDetails(clientListId, productId);
    }

    @PatchMapping("/updateAccountManagerSumInsuredDetails")
    @ResponseStatus(HttpStatus.OK)
    public AccountManagerSumInsuredDisplayDto updateAccountManagerSumInsuredDetails(
            @ModelAttribute AccountManagerSumInsuredDto sumInsuredDisplayDto, @RequestParam Long sumInsuredId) {

        return sumInsuredService.upadateAccountManagerSumInsured(sumInsuredDisplayDto,
                sumInsuredId);


    }


    @DeleteMapping("/deleteSumInsured/{id}")
    @ResponseStatus(HttpStatus.OK)
    public String deleteSumInsuredDetails(@PathVariable Long id) {
        return sumInsuredService.deleteSumInsuredDetailsById(id);
    }

}
