package com.ic.icadmin.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import java.util.Date;
import com.baomidou.mybatisplus.annotation.TableId;
import java.io.Serializable;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 
 * </p>
 *
 * @author ljc
 * @since 2023-10-30
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("investment_entities_kyc")
@ApiModel(value="InvestmentEntitiesKyc对象", description="")
public class InvestmentEntitiesKyc implements Serializable {

    private static final long serialVersionUID=1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    private Long clientId;

    private Integer entityType;

    private Boolean kycResult;

    private String entityName;

    private Date createdAt;

    private Date updatedAt;

    private String bsb;

    private String accountNumber;

    private String accountName;

    @TableField(value = "file_1_front")
    private String file1Front;

    @TableField(value = "file_1_back")
    private String file1Back;

    @TableField(value = "file_2_front")
    private String file2Front;

    @TableField(value = "file_2_back")
    private String file2Back;

    private Object detailInfo;

    private Integer kycStatus;

    private Boolean delFlag;

    private String transcationId;


}
