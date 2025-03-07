package com.bhg.bhgadmin.dto.response.events;

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
public class ListEventsExportDTO implements Serializable {

    List<EventsExportDTO> events;
}