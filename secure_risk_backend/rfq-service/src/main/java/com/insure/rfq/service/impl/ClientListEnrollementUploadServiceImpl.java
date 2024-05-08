package com.insure.rfq.service.impl;

import com.insure.rfq.dto.ClientListEnrollementHeaderMappingDto;
import com.insure.rfq.dto.EnrollementMemberDetailsHeadersDto;
import com.insure.rfq.entity.ClientListEnrollementHeadersMappingEntity;
import com.insure.rfq.entity.Tpa;
import com.insure.rfq.exception.InvalidTpaException;
import com.insure.rfq.repository.ClientListEnrollementUploadRepository;
import com.insure.rfq.repository.TpaRepository;
import com.insure.rfq.service.ClientListEnrollementUploadService;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ClientListEnrollementUploadServiceImpl implements ClientListEnrollementUploadService {

    private ClientListEnrollementUploadRepository clientListEnrollementUploadRepository;



    private TpaRepository tpaRepository;

    public ClientListEnrollementUploadServiceImpl(ClientListEnrollementUploadRepository clientListEnrollementUploadRepository,TpaRepository tpaRepository) {
        this.clientListEnrollementUploadRepository = clientListEnrollementUploadRepository;

        this.tpaRepository = tpaRepository;
    }


    @Override
    public ClientListEnrollementHeaderMappingDto uploadEnrollement(ClientListEnrollementHeaderMappingDto clientListEnrollementUploadDto) {
        if (clientListEnrollementUploadDto.getTpaid() != null) {
            Tpa tpa = tpaRepository.findById(clientListEnrollementUploadDto.getTpaid())
                    .orElseThrow(() -> new InvalidTpaException("Tpa is not found"));

            List<ClientListEnrollementHeadersMappingEntity> savedEntities = new ArrayList<>();
            for (EnrollementMemberDetailsHeadersDto headerDto : clientListEnrollementUploadDto.getHeaders()) {
                ClientListEnrollementHeadersMappingEntity mappingEntity = new ClientListEnrollementHeadersMappingEntity();
                mappingEntity.setTpaId(tpa);
                mappingEntity.setHeaderAliasName(headerDto.getHeaderAliasName());
                mappingEntity.setHeaderName(headerDto.getHeaderName());
                mappingEntity.setSheetName(headerDto.getSheetName());

                savedEntities.add(clientListEnrollementUploadRepository.save(mappingEntity));
            }

            List<EnrollementMemberDetailsHeadersDto> savedDtos = new ArrayList<>();
            for (ClientListEnrollementHeadersMappingEntity entity : savedEntities) {
                EnrollementMemberDetailsHeadersDto dto = new EnrollementMemberDetailsHeadersDto();
                dto.setHeaderAliasName(entity.getHeaderAliasName());
                dto.setHeaderName(entity.getHeaderName());
                dto.setSheetName(entity.getSheetName());
                savedDtos.add(dto);
            }

            return new ClientListEnrollementHeaderMappingDto(clientListEnrollementUploadDto.getTpaid(), savedDtos);
        }

        return null;
    }


}
