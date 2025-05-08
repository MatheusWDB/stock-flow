package br.com.hematsu.stock_flow.dtos;

import java.util.HashSet;
import java.util.Set;
import java.util.stream.Collectors;

import br.com.hematsu.stock_flow.entities.Category;
import br.com.hematsu.stock_flow.entities.Product;

public record ProductDTO(
        Long productId,
        String name,
        String description,
        String code,
        Double costPrice,
        Double salePrice,
        Integer stockQuantity,
        Set<InnerCategoryDTO> categories) {

    public ProductDTO(Product product) {
        this(
                product.getProductId(),
                product.getName(),
                product.getDescription(),
                product.getCode(),
                product.getCostPrice(),
                product.getSalePrice(),
                product.getStockQuantity(),
                product.getCategories() != null
                        ? product.getCategories().stream()
                                .map(InnerCategoryDTO::new)
                                .collect(Collectors.toSet())
                        : new HashSet<>());
    }

    public record InnerCategoryDTO(String name) {
        public InnerCategoryDTO(Category category) {
            this(category.getName());
        }
    }
}