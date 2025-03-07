package com.ic.icadmin.DAO.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;

import com.ic.icadmin.DAO.FundEntityDAO;
import com.ic.icadmin.entity.FundEntity;

@Repository
public class FundEntityDAOImpl implements FundEntityDAO{

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public FundEntity findById(Long Id) {
        return entityManager.find(FundEntity.class, Id);
    }
    
    @Override
    public List<FundEntity> findNonTaggedFunds() {
        return entityManager.createQuery("select f from FundEntity f where not exists (select ft from FundTag ft where ft.fundId = f.id)", FundEntity.class).getResultList();
    }
}
