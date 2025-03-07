package com.bhg.bhgadmin.dto.response.financings;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.io.Serializable;

/**
 * <p>
 * 
 * </p>
 *
 * @author ljc
 * @since 2023-10-03
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@NoArgsConstructor
@AllArgsConstructor
public class FinanceRefResponse implements Serializable {

    private static final long serialVersionUID=1L;

    private Integer id;

    private Integer level;

    private Long financeId;

    private Long clientId;

    private Long entityId;

    private String clientName;

    private String entityName;

    private Long parentId;
}
