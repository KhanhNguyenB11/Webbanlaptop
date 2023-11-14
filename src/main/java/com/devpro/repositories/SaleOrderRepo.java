package com.devpro.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.devpro.entities.SaleOrder;

import java.util.List;

@Repository 
public interface SaleOrderRepo extends JpaRepository<SaleOrder, Integer>  {
    SaleOrder findById(int id);
    SaleOrder findByCode(String code);

    @Query(nativeQuery = true, value = "SELECT * FROM tbl_saleorder WHERE user_id = ?1")
    List<SaleOrder> findByUserId(int userID);
}
