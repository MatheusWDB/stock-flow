package br.com.hematsu.stock_flow.mappers;

import org.springframework.stereotype.Component;

import br.com.hematsu.stock_flow.dto.ProductDTO;
import br.com.hematsu.stock_flow.entities.Product;

@Component
public class ProductMapper {

    public ProductDTO toDTO(Product product) {
        return new ProductDTO(product);
    }

    public Product toEntity(ProductDTO productDTO) {
        return new Product(productDTO.getName(), productDTO.getDescription(), productDTO.getCode(),
                productDTO.getCostPrice(), productDTO.getSalePrice(), productDTO.getStockQuantity());
    }


}
