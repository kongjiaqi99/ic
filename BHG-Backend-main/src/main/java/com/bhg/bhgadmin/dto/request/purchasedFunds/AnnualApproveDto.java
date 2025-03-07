package com.bhg.bhgadmin.dto.request.purchasedFunds;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.util.List;

/**
 * (annual_approve)实体类
 *
 * @author ljc
 * @since 2024-06-25 15:00:56
 * @description 由 Mybatisplus Code Generator 创建
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
public class AnnualApproveDto implements Serializable {
    private static final long serialVersionUID = 1L;
    /**
     * id
     */
	private Long id;
    /**
     * fundId
     */
    private Long fundId;
    /**
     * clientId
     */
    private Long clientId;
    /**
     * entityId
     */
    private Long entityId;
    /**
     * entityId
     */
    private List<Integer> yearList;


}