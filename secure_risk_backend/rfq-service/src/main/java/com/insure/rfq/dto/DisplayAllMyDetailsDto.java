package com.insure.rfq.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DisplayAllMyDetailsDto {

    private Long mydetailId;
    private String detailName;
    private String fileName;
}
