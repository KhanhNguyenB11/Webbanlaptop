package com.devpro.repositories;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.NoRepositoryBean;

import java.util.List;

@NoRepositoryBean
public interface GenericRepo<O, T> extends JpaRepository<O, T>, JpaSpecificationExecutor<O> {
    @Override
    @Query(value = "SELECT e FROM #{#tableName} e WHERE e.status = 0", nativeQuery = true)
    Page<O> findAll(Pageable pageable);

    @Override
    @Query(value = "SELECT e FROM #{#tableName} e WHERE e.status = 0", nativeQuery = true)
    List<O> findAll();

    @Override
    @Query(value = "SELECT count(*) FROM #{#tableName} e WHERE e.status = 0", nativeQuery = true)
    long count();

    @Query(value = "SELECT e FROM #{#tableName} e WHERE e.status = 1", nativeQuery = true)
    List<O> recycleBin();

    @Query(value = "SELECT count(*) FROM #{#tableName} e", nativeQuery = true)
    long countAll();
}
