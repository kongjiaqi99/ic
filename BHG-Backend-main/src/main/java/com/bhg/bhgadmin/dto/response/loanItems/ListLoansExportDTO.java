package com.bhg.bhgadmin.dto.response.loanItems;

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
public class ListLoansExportDTO implements Serializable {

    List<LoanItemsExportDTO> items;
}