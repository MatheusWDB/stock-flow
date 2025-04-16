package br.com.hematsu.stock_flow.dtos;

import java.util.HashSet;
import java.util.Set;

import org.springframework.beans.BeanUtils;

import br.com.hematsu.stock_flow.entities.Category;
import br.com.hematsu.stock_flow.entities.Product;

public class ProductDTO {
    private Long productId;
    private String name;
    private String description;
    private String code;
    private Double costPrice;
    private Double salePrice;
    private Integer stockQuantity;
    private Set<InnerCategoryDTO> categories = new HashSet<>();

    public ProductDTO() {
    }

    public ProductDTO(Product product) {
        BeanUtils.copyProperties(product, this);
    }

    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Double getCostPrice() {
        return costPrice;
    }

    public void setCostPrice(Double costPrice) {
        this.costPrice = costPrice;
    }

    public Double getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(Double salePrice) {
        this.salePrice = salePrice;
    }

    public Integer getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(Integer stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public Set<InnerCategoryDTO> getCategories() {
        return categories;
    }

    public void setCategories(Set<InnerCategoryDTO> categories) {
        this.categories = categories;
    }

    public static class InnerCategoryDTO {
        private String name;

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        @Override
        public String toString() {
            return "InnerCategoryDTO [name=" + name + "]";
        }
        
    }

    public Product toEntityForUpdate(Product updatedProduct, Set<Category> categories) {
        BeanUtils.copyProperties(this, updatedProduct, "categories");

        updatedProduct.getCategories().clear();
        if (this.categories != null) {
            updatedProduct.getCategories().addAll(categories);
        }

        return updatedProduct;
    }

}
