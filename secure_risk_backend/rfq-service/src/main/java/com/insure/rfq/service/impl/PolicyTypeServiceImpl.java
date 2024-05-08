package com.insure.rfq.service.impl;

import com.insure.rfq.dto.PolicyTypeDto;
import com.insure.rfq.entity.PolicyType;
import com.insure.rfq.repository.PolicyTypeRepository;
import com.insure.rfq.service.PolicyTypeService;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PolicyTypeServiceImpl implements PolicyTypeService {


	private PolicyTypeRepository policyTypeRepository;


	private ModelMapper modelMapper;

	public PolicyTypeServiceImpl(PolicyTypeRepository policyTypeRepository, ModelMapper modelMapper) {
		this.policyTypeRepository = policyTypeRepository;
		this.modelMapper = modelMapper;
	}

	@Override
	public List<String> getPolicyTypeById(Long id) {
		return policyTypeRepository.findAll().stream().filter(policy -> policy.getPolicyId() == id)
				.map(policy -> modelMapper.map(policy, PolicyTypeDto.class)).map(u->u.getName()).toList();
	}

	@Override
	public PolicyTypeDto createPolicy(PolicyTypeDto policyTypeDto, Long id) {
		if (policyTypeDto != null) {
			PolicyType map = modelMapper.map(policyTypeDto, PolicyType.class);
			map.setPolicyId(id);
			return modelMapper.map(policyTypeRepository.save(map), PolicyTypeDto.class);
		}
		return null;
	}

}
