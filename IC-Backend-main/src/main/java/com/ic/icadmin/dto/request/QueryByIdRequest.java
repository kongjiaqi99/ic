package com.ic.icadmin.dto.request;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;
import java.util.List;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 11:21
 **/
@Data
@ApiModel(value = "QueryByIdRequest", description = "Query By Id Request")
public class QueryByIdRequest {

    @ApiModelProperty("Id")
    private Long id;

    @ApiModelProperty("Id_list")
    private List<Long> idList;
}
