package com.insure.rfq.controller;

import com.insure.rfq.dto.TpaDto;
import com.insure.rfq.repository.TpaRepository;
import com.insure.rfq.service.impl.TpaServiceImpl;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RequestMapping("/tpa")
@RestController
@CrossOrigin(origins = {"*"})
public class TpaController {


    private TpaServiceImpl tpaServiceImpl;


    private TpaRepository tpaRepository;

    public TpaController(TpaServiceImpl tpaServiceImpl, TpaRepository tpaRepository) {
        this.tpaServiceImpl = tpaServiceImpl;
        this.tpaRepository = tpaRepository;
    }

    @PostMapping("/createTpa")
    public ResponseEntity<TpaDto> createTpa(@RequestBody TpaDto tpa) {
        TpaDto createTpa = tpaServiceImpl.createTpa(tpa);
        return new ResponseEntity<>(createTpa, HttpStatus.CREATED);

    }

    @GetMapping("/getAllTpa")
    public ResponseEntity<List<TpaDto>> getAllTpa() {
        List<TpaDto> findAll = tpaServiceImpl.viewAllTpa();
        return new ResponseEntity<>(findAll, HttpStatus.OK);
    }

    @PutMapping("/updateTpa/{tpaId}")
    public ResponseEntity<TpaDto> updateTpa(@RequestBody TpaDto tpaDto, @PathVariable Long tpaId) {
        TpaDto updateTpa = tpaServiceImpl.updateTpa(tpaDto, tpaId);
        return new ResponseEntity<>(updateTpa, HttpStatus.OK);
    }

    @GetMapping("/getTpaById/{tpaId}")
    public ResponseEntity<TpaDto> getTpaById(@PathVariable Long tpaId) {
        Optional<TpaDto> byId = tpaServiceImpl.getById(tpaId);
        return byId.map(tpaDto -> new ResponseEntity<>(tpaDto, HttpStatus.OK)).orElseGet(() -> new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }

    @GetMapping("/getTpaList")
    public ResponseEntity<List<String>> getTpaList() {
        List<String> tpaList = tpaRepository.getTpaList();
        return new ResponseEntity<>(tpaList, HttpStatus.OK);
    }

    @DeleteMapping("/deleteTpa/{id}")
    public ResponseEntity<String> deleteTpaList(@PathVariable Long id) {
        String deleteTpa = tpaServiceImpl.deleteTpa(id);
        return new ResponseEntity<>(deleteTpa, HttpStatus.OK);
    }

    @GetMapping("/getCountTpa")
    public Long getRfqCountByCount() {

        return tpaRepository.countApplicationsByStatus();

    }
}
