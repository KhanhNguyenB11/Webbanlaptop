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
    
    @Query(nativeQuery = true, value = "SELECT COUNT(user_id) FROM tbl_saleorder GROUP BY user_id ORDER BY COUNT(user_id) DESC LIMIT 5;")
    List<Integer> findTop5OrderCount();
    @Query(nativeQuery = true, value = "SELECT user_id FROM tbl_saleorder GROUP BY user_id ORDER BY COUNT(user_id) DESC LIMIT 5;")
    List<Integer> findTop5userID();
    @Query(nativeQuery = true, value = "SELECT SUM(total) FROM tbl_saleorder GROUP BY user_id ORDER BY COUNT(user_id) DESC LIMIT 5;")
    List<Integer> findTop5Total();
    
    
    @Query(nativeQuery = true, value = "SELECT created_by FROM tbl_saleorder GROUP BY created_by ORDER BY COUNT(created_by) DESC LIMIT 5;")
    List<Integer> findTop5CreatedID();
    @Query(nativeQuery = true, value = "SELECT COUNT(created_by) FROM tbl_saleorder GROUP BY created_by ORDER BY COUNT(created_by) DESC LIMIT 5;")
    List<Integer> findTop5OrderCreatedCount();
}
