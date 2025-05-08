package br.com.hematsu.stock_flow.mappers;

import org.springframework.stereotype.Component;

import br.com.hematsu.stock_flow.dtos.ProductDTO;
import br.com.hematsu.stock_flow.entities.Product;

@Component
public class ProductMapper {

    public ProductDTO toDTO(Product product) {
        return new ProductDTO(product);
    }

    public Product toEntity(ProductDTO productDTO) {
        return new Product(productDTO.productId(), productDTO.name(), productDTO.description(), productDTO.code(),
                productDTO.costPrice(), productDTO.salePrice(), productDTO.stockQuantity());
    }

}
