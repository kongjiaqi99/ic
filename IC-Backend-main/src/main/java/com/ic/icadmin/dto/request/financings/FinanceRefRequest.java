package com.ic.icadmin.dto.request.financings;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.util.List;

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
public class FinanceRefRequest implements Serializable {

    private static final long serialVersionUID=1L;

    private Long id;

    private Integer level;

    private Long financeId;

    private Long clientId;

    private Long entityId;

    private Long parentId;

    private List<FinanceRefRequest> children;
}
