package com.ic.icadmin.DAO.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.ic.icadmin.DAO.TagDAO;
import com.ic.icadmin.entity.Tags;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

@Repository
public class TagDAOImpl implements TagDAO{

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public Tags findById(Long id) {
        return entityManager.find(Tags.class, id);
    }
    
    @Override
    public boolean existsById(Long id) {
        Long count = entityManager.createQuery(
                "select COUNT(t) FROM Tags t WHERE t.tagId = :id", Long.class)
            .setParameter("id", id)
            .getSingleResult();

        return count > 0;
    }

    @Override
    public List<Tags> findAll() {
        return entityManager.createQuery("select t from Tags t", Tags.class).getResultList();
    }

    @Override
    public void save(Tags tag) {
        entityManager.persist(tag);
    }

    @Override
    public void update(Tags tag) {
        entityManager.merge(tag);
    }

    @Override
    public void delete(Long id) {
        Tags tag = findById(id);
        if(tag != null) {
            entityManager.remove(tag);
        }
    }

}

