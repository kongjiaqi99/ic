package com.bhg.bhgadmin.dto.response.enquiries;

import cn.afterturn.easypoi.excel.annotation.Excel;
import com.bhg.bhgadmin.entity.EnquiriesEntity;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;
import java.util.Date;

@Data
@XmlRootElement
@NoArgsConstructor
public class EnquiriesExportDTO implements Serializable {

    @Excel(name = "Id")
    private Long id;

    @Excel(name = "Name")
    private String name;

    @Excel(name = "Broker")
    private String broker;

    @Excel(name = "Message")
    private String message;

    @Excel(name = "Email")
    private String email;

    @Excel(name = "Created at")
    private Date createdAt;

    @Excel(name = "Updated at")
    private Date updatedAt;

    @Excel(name = "Phone")
    private String phone;

    @Excel(name = "Interest")
    private String interest;

    @Excel(name = "Suburb")
    private String suburb;

    @Excel(name = "State")
    private String state;

    private static final long serialVersionUID = 1L;

    public EnquiriesExportDTO(EnquiriesEntity entity) {
        this.id = entity.getId();
        this.name = entity.getName();
        this.message = entity.getMessage();
        this.email = entity.getEmail();
        this.createdAt = entity.getCreatedAt();
        this.updatedAt = entity.getUpdatedAt();
        this.phone = entity.getPhone();
        this.interest = entity.getInterest();
        this.suburb = entity.getSuburb();
        this.state = entity.getState();
        this.broker = entity.getBroker();
    }
}