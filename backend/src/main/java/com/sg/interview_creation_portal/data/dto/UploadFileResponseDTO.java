package com.sg.interview_creation_portal.data.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UploadFileResponseDTO {
    private String fileName;
    private String fileDownloadUri;
    private String fileType;
    private long size;
}
