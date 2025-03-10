package com.ic.icadmin.dto.response.audit;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.ic.icadmin.share.enums.AuditStatusEnum;
import com.ic.icadmin.share.enums.AuditTypeEnum;
import io.swagger.annotations.ApiModel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.util.Date;

/**
 * <p>
 * 
 * </p>
 *
 * @author ljc
 * @since 2023-09-26
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@AllArgsConstructor
@NoArgsConstructor
@ApiModel(value="Audit对象", description="")
public class AuditResponse implements Serializable {

    private static final long serialVersionUID=1L;

    private Integer id;
    /**
     * {@link AuditTypeEnum}
     */
    private String auditType;

    private Object entityContent;

    private Long entityId;
    private String entityName;

    private Object newEntity;

    private Date createdAt;

    private Date updatedAt;

    /**
     * {@link AuditStatusEnum}
     */
    private String status;

    private Long creator;

    private String creatorName;

    private Long approver;

    private String approverName;


}
