package com.insure.rfq.service;

import com.insure.rfq.dto.CdbalanceDisplayDto;
import com.insure.rfq.dto.CdbalanceHeaderMappingDto;
import com.insure.rfq.dto.CdbalanceHeaderStatusDto;
import com.insure.rfq.dto.CdbalanceValueStatus;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;


public interface CdbalanceHeaderUploadService {

    CdbalanceHeaderMappingDto uploadEnrollement(CdbalanceHeaderMappingDto clientListEnrollementUploadDto);
    CdbalanceHeaderStatusDto validateHeaders(MultipartFile multipartFile);
//
    List<CdbalanceDisplayDto> getDataformFile(Long clientID, Long produtId);
     String saveData(List<CdbalanceValueStatus> valueStatuses,
                           Long clientID, Long productId);
     String deleteTheCdBalancData(Long cdbalanceId);
      String updateCdBalanceData(CdbalanceDisplayDto dto,Long cdbalanceId);
     List<CdbalanceValueStatus> validateValuesBased(MultipartFile multipartFile ) throws IOException;
     byte[] generateExcelFromData(Long clientListId, Long productId);

}
