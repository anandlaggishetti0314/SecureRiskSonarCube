package com.insure.rfq.controller;

import com.insure.rfq.dto.ClientListEmployeeECashlessDisplayDto;
import com.insure.rfq.dto.ClientListEmployeeECashlessDto;
import com.insure.rfq.service.ClientListEmployeeECashlessService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@CrossOrigin(origins = "*")
@RequestMapping("rfq/clientListEmployee_E_Cashless")
public class ClientListEmployeeECashlessController {


    private ClientListEmployeeECashlessService serviceImpl;

    public ClientListEmployeeECashlessController(ClientListEmployeeECashlessService serviceImpl) {
        this.serviceImpl = serviceImpl;
    }


    @PostMapping("/saveClientListEmployee_E_Cashless")
    public String  saveClientListEmployeeECashless(@ModelAttribute ClientListEmployeeECashlessDto dto, @RequestParam Long clientId, @RequestParam Long productId, @RequestParam Long employeeId) {
        return serviceImpl.saveClientListECashless(dto, clientId, productId, employeeId);
    }

    @GetMapping("/getAllClientListEmployeeECashlessData")
    public List<ClientListEmployeeECashlessDisplayDto> getListEmployeeECashlessDisplay() {
        return serviceImpl.getAllClientListEmployeeECashlessDtoList();
    }

}
