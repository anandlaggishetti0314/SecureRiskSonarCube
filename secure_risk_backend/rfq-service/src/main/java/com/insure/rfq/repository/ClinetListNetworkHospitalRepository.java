package com.insure.rfq.repository;

import com.insure.rfq.entity.ClientListNetworkHospitalEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ClinetListNetworkHospitalRepository extends JpaRepository<ClientListNetworkHospitalEntity, Long> {
}
