package com.ic.icadmin.dto.biz;

import com.ic.icadmin.entity.ClientsEntity;
import lombok.Data;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-22 22:19
 **/
@Data
public class BizClientDetailDTO extends ClientsEntity {

    private String upperClientName;

    private String level2UpperClientName;
}
