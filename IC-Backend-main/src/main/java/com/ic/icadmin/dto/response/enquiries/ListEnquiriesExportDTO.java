package com.ic.icadmin.dto.response.enquiries;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;
import java.util.List;

@Data
@XmlRootElement
@NoArgsConstructor
@AllArgsConstructor
public class ListEnquiriesExportDTO implements Serializable {

    List<EnquiriesExportDTO> enquiries;
}