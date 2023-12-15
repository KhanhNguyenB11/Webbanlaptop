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

    List<SaleOrder> findByCustomerEmail(String customer_email);
    
    @Query(nativeQuery = true, value = "SELECT COUNT(user_id) FROM tbl_saleorder where not user_id = 'NULL' and status = '0' GROUP BY user_id ORDER BY SUM(total) DESC LIMIT 5;")
    List<Integer> findTop5OrderCount();
    @Query(nativeQuery = true, value = "SELECT user_id FROM tbl_saleorder where not user_id = 'NULL' and status = '0' GROUP BY user_id ORDER BY SUM(total) DESC LIMIT 5;")
    List<Integer> findTop5userID();
    @Query(nativeQuery = true, value = "SELECT SUM(total) FROM tbl_saleorder where not user_id = 'NULL' and status = '0' GROUP BY user_id ORDER BY SUM(total) DESC LIMIT 5;")
    List<Float> findTop5Total();
    
    
    @Query(nativeQuery = true, value = "SELECT staff_id FROM tbl_saleorder where not staff_id = 'NULL' GROUP BY staff_id ORDER BY SUM(total) DESC LIMIT 5;")
    List<Integer> findTop5CreatedID();
    @Query(nativeQuery = true, value = "SELECT COUNT(staff_id) FROM tbl_saleorder where not staff_id = 'NULL' GROUP BY staff_id ORDER BY SUM(total) DESC LIMIT 5;")
    List<Integer> findTop5OrderCreatedCount();
    @Query(nativeQuery = true, value = "SELECT SUM(total) FROM tbl_saleorder where not staff_id = 'NULL' GROUP BY staff_id ORDER BY SUM(total) DESC LIMIT 5;")
    List<Float> findTop5TotalByStaff();
}
