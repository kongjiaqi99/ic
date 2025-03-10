package com.ic.icadmin.dto.biz;

import lombok.AllArgsConstructor;
import lombok.Data;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-18 00:48
 **/
@Data
@AllArgsConstructor
public class BizMailReceiverDTO {

    public String receiverEmail;

    public String receiverName;
}
