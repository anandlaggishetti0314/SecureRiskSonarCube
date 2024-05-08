package com.insure.rfq.repository;

import com.insure.rfq.entity.ClientListPerLifePremiumCalculator;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ClientListLifePremiumCalcuaterepository
		extends JpaRepository<ClientListPerLifePremiumCalculator, Long> {

}
