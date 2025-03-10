package com.ic.icadmin.dto.response.admin;

import cn.afterturn.easypoi.excel.annotation.Excel;
import com.ic.icadmin.entity.AdminUsersEntity;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;
import java.util.Date;

@Data
@XmlRootElement
@NoArgsConstructor
public class AdminUsersExportDTO implements Serializable {

    @Excel(name = "Id")
    private Long id;

    @Excel(name = "Email")
    private String email;

    @Excel(name = "Role")
    private String role;

    @Excel(name = "Reset password token")
    private String resetPasswordToken;

    @Excel(name = "Reset password sent at")
    private Date resetPasswordSentAt;

    @Excel(name = "Remember created at")
    private Date rememberCreatedAt;

    @Excel(name = "Created at")
    private Date createdAt;

    @Excel(name = "Updated at")
    private Date updatedAt;

    private static final long serialVersionUID = 1L;

    public AdminUsersExportDTO(AdminUsersEntity entity, String role) {
        this.id = entity.getId();
        this.email = entity.getEmail();
        this.role = role;
        this.resetPasswordToken = entity.getResetPasswordToken();
        this.resetPasswordSentAt = entity.getResetPasswordSentAt();
        this.rememberCreatedAt = entity.getRememberCreatedAt();
        this.createdAt = entity.getCreatedAt();
        this.updatedAt = entity.getUpdatedAt();
    }
}