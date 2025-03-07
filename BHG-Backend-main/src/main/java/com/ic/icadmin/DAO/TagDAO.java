package com.ic.icadmin.DAO;

import java.util.List;

import com.ic.icadmin.entity.Tags;

public interface TagDAO {
    Tags findById(Long id);
    List<Tags> findAll();
    void save(Tags tag);
    void update(Tags tag);
    void delete(Long id);
    boolean existsById(Long id);
}
