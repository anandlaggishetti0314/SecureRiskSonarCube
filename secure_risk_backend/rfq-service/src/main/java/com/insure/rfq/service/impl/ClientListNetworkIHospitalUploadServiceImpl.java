package com.insure.rfq.service.impl;

import com.insure.rfq.dto.ClientListNetworkHospitalHeaderMappingDto;
import com.insure.rfq.dto.NetworkHospitalMemberDetailsHeadersDto;
import com.insure.rfq.entity.ClientListNetworkHospitalHeadersMappingEntity;
import com.insure.rfq.entity.Tpa;
import com.insure.rfq.exception.InvalidTpaException;
import com.insure.rfq.repository.ClientListNetworkHospitalHeadersMappingRepository;
import com.insure.rfq.repository.TpaRepository;
import com.insure.rfq.service.ClientListNetworkHospitalUploadService;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ClientListNetworkIHospitalUploadServiceImpl implements ClientListNetworkHospitalUploadService {


    private ClientListNetworkHospitalHeadersMappingRepository clientListNetworkHospitalHeadersMappingRepository;



    private TpaRepository tpaRepository;

    public ClientListNetworkIHospitalUploadServiceImpl(ClientListNetworkHospitalHeadersMappingRepository clientListNetworkHospitalHeadersMappingRepository, TpaRepository tpaRepository) {
        this.clientListNetworkHospitalHeadersMappingRepository = clientListNetworkHospitalHeadersMappingRepository;

        this.tpaRepository = tpaRepository;
    }

    @Override
    public ClientListNetworkHospitalHeaderMappingDto uploadNetworkHospital(ClientListNetworkHospitalHeaderMappingDto clientListNetworkHospitalHeaderUploadDto) {
        if (clientListNetworkHospitalHeaderUploadDto.getTpaId() != null) {
            Tpa tpa = tpaRepository.findById(clientListNetworkHospitalHeaderUploadDto.getTpaId())
                    .orElseThrow(() -> new InvalidTpaException("Tpa is not found"));

            List<ClientListNetworkHospitalHeadersMappingEntity> savedEntities = new ArrayList<>();
            for (NetworkHospitalMemberDetailsHeadersDto headerDto : clientListNetworkHospitalHeaderUploadDto.getHeaders()) {
                ClientListNetworkHospitalHeadersMappingEntity mappingEntity = new ClientListNetworkHospitalHeadersMappingEntity();
                mappingEntity.setTpaId(tpa);
                mappingEntity.setHeaderAliasName(headerDto.getHeaderAliasName());
                mappingEntity.setHeaderName(headerDto.getHeaderName());
                mappingEntity.setSheetName(headerDto.getSheetName());

                savedEntities.add(clientListNetworkHospitalHeadersMappingRepository.save(mappingEntity));
            }

            List<NetworkHospitalMemberDetailsHeadersDto> savedDtos = new ArrayList<>();
            for (ClientListNetworkHospitalHeadersMappingEntity entity : savedEntities) {
                NetworkHospitalMemberDetailsHeadersDto dto = new NetworkHospitalMemberDetailsHeadersDto();
                dto.setHeaderAliasName(entity.getHeaderAliasName());
                dto.setHeaderName(entity.getHeaderName());
                dto.setSheetName(entity.getSheetName());
                savedDtos.add(dto);
            }

            return new ClientListNetworkHospitalHeaderMappingDto(clientListNetworkHospitalHeaderUploadDto.getTpaId(), savedDtos);
        }

        return null;
    }


}
