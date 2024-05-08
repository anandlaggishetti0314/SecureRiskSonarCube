package com.wellness.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.wellness.entities.PaymentDetails;
import com.wellness.enums.PaymentMode;
import com.wellness.enums.PaymentType;
import com.wellness.payload.OrderDto;
import com.wellness.payload.PaymentDetailsDTO;
import com.wellness.service.PaymentService;

import io.swagger.v3.oas.annotations.Operation;

@RestController
@RequestMapping("/wellness")
public class PaymentController {

	@Autowired
	private PaymentService paymentService;

	@Operation(hidden = true)
	@PostMapping("/payment")
	public ResponseEntity<String> createSubscription(@RequestBody PaymentDetails paymentDetails) {
		String createPayment = paymentService.paymentCreation(paymentDetails);
		return new ResponseEntity<>(createPayment, HttpStatus.CREATED);
	}

	@GetMapping("/viewPaymentByPaymentId/{paymentId}")
	public ResponseEntity<PaymentDetailsDTO> getPaymentByPaymentId(@PathVariable long paymentId) {
		PaymentDetailsDTO paymentDetails = paymentService.getPaymentDetailsByPaymentId(paymentId);
		return ResponseEntity.ok().body(paymentDetails);
	}

	@GetMapping("/viewPaymentByUserId/{userId}")
	public ResponseEntity<?> getPaymentByUserId(@PathVariable long userId) {
		List<PaymentDetailsDTO> paymentDetails = paymentService.getPaymentDetailsByuserId(userId);
		return ResponseEntity.ok().body(paymentDetails);
	}

	@GetMapping("/viewBypaymentMode/{paymentMode}")
	public ResponseEntity<List<PaymentDetailsDTO>> getPaymentDetailsByPaymentMode(
			@PathVariable PaymentMode paymentMode) {
		List<PaymentDetailsDTO> paymentDetailsList = paymentService.getPaymentDetailsByPaymentMode(paymentMode);
		return new ResponseEntity<>(paymentDetailsList, HttpStatus.OK);

	}

	@GetMapping("{paymentType}/viewBypaymentType")
	public ResponseEntity<List<PaymentDetailsDTO>> getPaymentDetailsByPaymentType(
			@PathVariable PaymentType paymentType) {
		List<PaymentDetailsDTO> paymentDetailsList = paymentService.getPaymentDetailsByPaymentType(paymentType);
		return new ResponseEntity<>(paymentDetailsList, HttpStatus.OK);

	}

	@GetMapping("/paymentDetailsWithinDateRange")
	public ResponseEntity<List<PaymentDetailsDTO>> getPaymentDetailsWithinDateRange(
			@RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") Date from,
			@RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") Date to) {

		List<PaymentDetailsDTO> paymentDetailsList = paymentService.getPaymentDetailsWithinDateRange(from, to);
		return new ResponseEntity<>(paymentDetailsList, HttpStatus.OK);

	}

	@Operation(hidden = true)
	@PostMapping("/createorder")
	public ResponseEntity<String> createOrder(@RequestBody OrderDto order) {
		String createOrder = paymentService.createOrder(order);
		return ResponseEntity.ok().body(createOrder);
	}

	@GetMapping("{orderId}/getbyorederid")
	public ResponseEntity<PaymentDetailsDTO> getByOrderId(@PathVariable String orderId) {
		PaymentDetailsDTO paymentDetailsByOrderId = paymentService.getPaymentDetailsByOrderId(orderId);
		return ResponseEntity.ok().body(paymentDetailsByOrderId);
	}
}
