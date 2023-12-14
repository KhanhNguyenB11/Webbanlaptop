package com.devpro.repositories;

import java.util.Collection;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.devpro.entities.Product;


@Repository 
public interface ProductRepo extends JpaRepository<Product, Integer> {
    @Query(value = "SELECT * FROM tbl_products ORDER BY discount DESC LIMIT 12", nativeQuery = true)
    List<Product> findTop12ProductsOrderByDiscountDesc();
    @Query(value = "SELECT * FROM tbl_products ORDER BY price DESC", nativeQuery = true)
    List<Product> findAllMaxToMinOfPrice();
    @Query(value = "SELECT * FROM tbl_products ORDER BY price ASC", nativeQuery = true)
    List<Product> findAllMinToMaxOfPrice();

	
	
}