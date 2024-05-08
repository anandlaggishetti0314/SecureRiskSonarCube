package com.wellness.serviceimpl;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.wellness.entities.PaymentDetails;
import com.wellness.enums.PaymentMode;
import com.wellness.enums.PaymentStatus;
import com.wellness.enums.PaymentType;
import com.wellness.exceptions.OrderIdNotFound;
import com.wellness.exceptions.PaymentDetailsNotFoundException;
import com.wellness.exceptions.PaymentIdNotFoundException;
import com.wellness.exceptions.PaymentModeNotFoundException;
import com.wellness.exceptions.PaymentTypeNotFoundException;
import com.wellness.exceptions.UserIdNotFoundException;
import com.wellness.payload.OrderDto;
import com.wellness.payload.OrderPayload;
import com.wellness.payload.PaymentDetailsDTO;
import com.wellness.payment.PaymentIntegration;
import com.wellness.repo.PaymentDetailsRepo;
import com.wellness.service.PaymentService;

@Service
public class PaymentServiceImpl implements PaymentService {

	@Autowired
	private PaymentDetailsRepo paymentRepo;

	@Autowired
	private ModelMapper modelMapper;

	@Autowired
	private PaymentIntegration paymentIntegration;

	@Autowired
	private ObjectMapper objectMapper;

	@Override
	public String paymentCreation(PaymentDetails paymentDetails) {
		String message = "failed the payment creation";
		paymentDetails.setPaymentStatus(PaymentStatus.PENDING);
		PaymentDetails details = paymentRepo.save(paymentDetails);
		if (details != null) {
			message = "payment creation sucess.";
		}
		return message;
	}

	@Override
	public PaymentDetailsDTO getPaymentDetailsByPaymentId(long paymentId) {
		PaymentDetails payment = null;
		payment = paymentRepo.findById(paymentId)
				.orElseThrow(() -> new PaymentIdNotFoundException("Payment not done by id :" + paymentId));
		PaymentDetailsDTO payDto = modelMapper.map(payment, PaymentDetailsDTO.class);
		return payDto;
	}

	@Override
	public List<PaymentDetailsDTO> getPaymentDetailsByuserId(long userId) {

		List<PaymentDetails> payment = paymentRepo.findByUserId(userId)
				.orElseThrow(() -> new UserIdNotFoundException("user not found with an id : " + userId));
		if (!payment.isEmpty()) {
			return payment.stream().map(p -> modelMapper.map(p, PaymentDetailsDTO.class)).collect(Collectors.toList());
		} else {
			throw new UserIdNotFoundException("user not found with an id : " + userId);
		}
	}

	@Override
	public List<PaymentDetailsDTO> getPaymentDetailsByPaymentMode(PaymentMode paymentMode) {
		List<PaymentDetails> findByPaymentMode = paymentRepo.findByPaymentMode(paymentMode);

		if (!findByPaymentMode.isEmpty()) {
			return findByPaymentMode.stream().map(payment -> modelMapper.map(payment, PaymentDetailsDTO.class))
					.collect(Collectors.toList());
		} else {
			throw new PaymentModeNotFoundException("payment mode not found : " + paymentMode);
		}

	}

	@Override
	public List<PaymentDetailsDTO> getPaymentDetailsByPaymentType(PaymentType paymentType) {
		List<PaymentDetails> paymentDetailsList = paymentRepo.findByPaymentType(paymentType);
		if (!paymentDetailsList.isEmpty()) {
			return paymentDetailsList.stream().map(payment -> modelMapper.map(payment, PaymentDetailsDTO.class))
					.collect(Collectors.toList());
		} else {
			throw new PaymentTypeNotFoundException("payment type not found : " + paymentType);
		}
	}

	@Override
	public List<PaymentDetailsDTO> getPaymentDetailsWithinDateRange(Date startDate, Date endDate) {

		LocalDate localStartDate = startDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		startDate = Date.from(localStartDate.atStartOfDay(ZoneId.systemDefault()).toInstant());

		LocalDate localEndDate = endDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		endDate = Date.from(localEndDate.atStartOfDay(ZoneId.systemDefault()).plusDays(1).minusNanos(1).toInstant());

		if (startDate != null && endDate != null) {
			List<PaymentDetails> paymentDetailsList = paymentRepo.findByCreationDateBetween(startDate, endDate);
			if (!paymentDetailsList.isEmpty()) {
				return paymentDetailsList.stream().map(payment -> modelMapper.map(payment, PaymentDetailsDTO.class))
						.collect(Collectors.toList());
			} else {
				throw new PaymentDetailsNotFoundException(
						"payment details not found in between " + startDate + " to " + endDate);
			}
		} else {
			throw new PaymentDetailsNotFoundException("payment details not found provide valid date");
		}

	}

	@Override
	public String createOrder(OrderDto order) {
		
		String createOrder = paymentIntegration.createOrder(order);

		OrderPayload readValue = null;
		try {
			readValue = objectMapper.readValue(createOrder, OrderPayload.class);
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}

		PaymentDetails payment = modelMapper.map(order, PaymentDetails.class);
		payment.setAmount(Double.parseDouble(order.getAmount()));
		payment.setUserId(order.getUserId());

		payment.setOrderId(readValue.getId());
		payment.setStatus(readValue.getStatus());
		payment.setCatpturePayload(createOrder);

		PaymentDetails save = paymentRepo.save(payment);

		if (save != null) {
			return readValue.getId();
		}

		return "it's under maintance";
	}

	@Override
	public PaymentDetailsDTO getPaymentDetailsByOrderId(String orderId) {
		PaymentDetails orderDeatils = paymentRepo.findByOrderId(orderId)
				.orElseThrow(() -> new OrderIdNotFound("order id not found"));
		PaymentDetailsDTO dto = modelMapper.map(orderDeatils, PaymentDetailsDTO.class);
		return dto;
	}

}
