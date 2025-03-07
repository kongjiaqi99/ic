package com.bhg.bhgadmin.api.dto.request.account;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.Date;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu
 * @create: 2023-02-23 22:35
 **/
@Data
@ApiModel(description = "Recent Activities Query Request")
public class ClientInfoEditRequest {
    @Email
    @NotBlank
    @ApiModelProperty(value = "Email")
    private String email;

    @ApiModelProperty(value = "密码，如果用户没填就传null")
    private String password;

    @NotBlank
    @ApiModelProperty(value = "name")
    private String name;

    @NotBlank
    @ApiModelProperty(value = "mobile")
    private String mobile;

    @NotNull
    @ApiModelProperty(value = "生日，例：2023-02-23")
    private Date birth;
}
