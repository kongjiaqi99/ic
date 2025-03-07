package com.bhg.bhgadmin.DAO;

import java.util.List;

import com.bhg.bhgadmin.entity.FundEntity;

public interface FundEntityDAO {
    FundEntity findById(Long Id);
    List<FundEntity> findNonTaggedFunds();
}
