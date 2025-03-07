package com.bhg.bhgadmin.api.dto.request;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.Email;
import java.util.List;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-07 02:43
 **/
@Data
@ApiModel(value = "Page Request", description = "page parameter")
public class PageRequest {

    int pageNum = 1;
    int pageSize = 30;

    private Integer fundCategory;

    Long id;

    private Boolean readFlag;

    private Boolean readAll;

    private Boolean history;

    private Long entityId;
    private Long stateId;


    @ApiModelProperty(value = "fundStatus  0 coming_soon\n" +
            "1 now_open\n" +
            "2 fully_invested\n" +
            "3 completed")
    private Integer fundStatus;

    @ApiModelProperty(value = "fundStatus  0 coming_soon\n" +
            "1 now_open\n" +
            "2 fully_invested\n" +
            "3 completed")
    private List<Integer> fundStatusList;

    private String company;

}
