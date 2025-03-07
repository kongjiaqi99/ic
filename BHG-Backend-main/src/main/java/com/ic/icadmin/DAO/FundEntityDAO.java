package com.ic.icadmin.DAO;

import java.util.List;

import com.ic.icadmin.entity.FundEntity;

public interface FundEntityDAO {
    FundEntity findById(Long Id);
    List<FundEntity> findNonTaggedFunds();
}
