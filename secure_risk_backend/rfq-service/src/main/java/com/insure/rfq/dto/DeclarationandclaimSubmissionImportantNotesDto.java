package com.insure.rfq.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class DeclarationandclaimSubmissionImportantNotesDto {

    private  String proofidType;
    private  String idproof;           // select the proof NAME WE HAVE TO GIVE
    private  MultipartFile idproofUpload;//  we have to upload the proof
    private  String userdetailsId;

}
