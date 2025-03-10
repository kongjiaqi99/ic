package com.ic.icadmin.dto.response.newsImgs;

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
public class ListNewsImgsExportDTO implements Serializable {

    List<NewsImgsExportDTO> items;
}