package com.bhg.bhgadmin.DAO.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;

import com.bhg.bhgadmin.DAO.FundTagDAO;
import com.bhg.bhgadmin.entity.FundTag;

@Repository
public class FundTagDAOImpl implements FundTagDAO{
    
    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<FundTag> findByTagId(Long id) {
        return entityManager.createQuery("select ft from FundTag ft join FundEntity f on ft.fundId = f.id where ft.tagId = :id", FundTag.class)
                            .setParameter("id", id)
                            .getResultList();
    }

    @Override
    public void save(FundTag fundTag) {
        entityManager.persist(fundTag);
    }

    @Override
    public void delete(Long fundId, Long tagId) {
        FundTag fundTag = entityManager.createQuery("select ft from FundTag ft where ft.fundId = :fundId and ft.tagId = :tagId", FundTag.class)
                                       .setParameter("fundId", fundId)
                                       .setParameter("tagId", tagId)
                                       .getSingleResult();
        if (fundTag != null) {
            entityManager.remove(fundTag);
        }
    }

    @Override
    public void update(FundTag fundTag) {
        entityManager.merge(fundTag);
    }

    @Override
    public List<FundTag> findAll() {
        return entityManager.createQuery("select ft from FundTag ft", FundTag.class).getResultList();
    }

}
