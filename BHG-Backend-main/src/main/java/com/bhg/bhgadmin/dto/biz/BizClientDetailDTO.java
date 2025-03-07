package com.bhg.bhgadmin.dto.biz;

import com.bhg.bhgadmin.entity.ClientsEntity;
import lombok.Data;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-22 22:19
 **/
@Data
public class BizClientDetailDTO extends ClientsEntity {

    private String upperClientName;

    private String level2UpperClientName;
}
