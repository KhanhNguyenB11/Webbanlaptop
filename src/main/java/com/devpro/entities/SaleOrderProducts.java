package com.devpro.entities;

import javax.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "tbl_saleorder_products")
public class SaleOrderProducts extends BaseEntity {
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "product_id")
	private Product product;
	
	@Column(name = "quantity")
	private Integer quantity;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "saleorder_id")
	private SaleOrder saleOrder;


	private int discount;

	public int getDiscount() {
		return discount;
	}
	@Transient
	private BigDecimal priceAfterDiscount;

	@Transient
	private BigDecimal total;

	public BigDecimal getTotal() {
		return total;
	}

	public void setTotal(BigDecimal total) {
		this.total = total;
	}

	public BigDecimal getPriceAfterDiscount() {
		return priceAfterDiscount;
	}

	public void setPriceAfterDiscount(BigDecimal priceAfterDiscount) {
		this.priceAfterDiscount = priceAfterDiscount;
	}

	public void setDiscount(int discount) {
		this.discount = discount;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	private BigDecimal price;
	public SaleOrder getSaleOrder() {
		return saleOrder;
	}

	public void setSaleOrder(SaleOrder saleOrder) {
		this.saleOrder = saleOrder;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}




}
