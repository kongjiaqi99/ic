package com.ic.icadmin.dto.response.financings;

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
public class ListFinancingsExportDTO implements Serializable {

    List<FinancingsExportDTO> items;
}