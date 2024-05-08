package com.insure.rfq.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ImportantNotesDisplayDto {
    private  Long id;
    private String userdetailsId;
    private String proofidType;
    private String idproof;           // select the proof NAME WE HAVE TO GIVE
    private String idproofUpload;//  we have to upload the proof
}
