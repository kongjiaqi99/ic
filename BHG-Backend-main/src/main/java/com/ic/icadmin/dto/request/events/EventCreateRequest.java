package com.ic.icadmin.dto.request.events;

import com.baomidou.mybatisplus.annotation.TableField;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.NotBlank;
import java.util.Date;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 11:21
 **/
@Data
@ApiModel(value = "QueryByIdRequest", description = "Event Detail Request")
public class EventCreateRequest {

    @NotBlank
    @ApiModelProperty("title")
    private String title;

    @NotBlank
    @ApiModelProperty("start time")
    private String startTime;

    @ApiModelProperty("city code")
    private Integer city;

    @ApiModelProperty("location")
    private String location;

    @ApiModelProperty("brief introduction")
    private String briefIntroduction;

    private MultipartFile mainImg;

    @ApiModelProperty("language code")
    private Integer language;

    @ApiModelProperty("trans Id")
    private Long trans;

    @ApiModelProperty("status")
    private String status;

    private MultipartFile fileUrl;

    @ApiModelProperty("type")
    private String type;

    @ApiModelProperty("link")
    private String link;
}
