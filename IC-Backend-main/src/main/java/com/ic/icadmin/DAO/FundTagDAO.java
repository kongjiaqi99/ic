package com.ic.icadmin.DAO;

import java.util.List;

import com.ic.icadmin.entity.FundTag;

public interface FundTagDAO {
    List<FundTag> findByTagId(Long id);
    void save(FundTag fundTag);
    void delete(Long fundId, Long tagId);
    void update(FundTag fundTag);
    List<FundTag> findAll();
}
