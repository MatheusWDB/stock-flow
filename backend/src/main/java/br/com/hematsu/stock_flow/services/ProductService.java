package br.com.hematsu.stock_flow.services;

import java.util.List;

import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import br.com.hematsu.stock_flow.dto.ProductDTO;
import br.com.hematsu.stock_flow.entities.Product;
import br.com.hematsu.stock_flow.repositories.ProductRepository;

@Service
public class ProductService {

    @Autowired
    private ProductRepository productRepository;

    public Product save(Product newProduct) {
        return productRepository.save(newProduct);
    }

    @Transactional
    public List<ProductDTO> findAll() {
        List<Product> products = productRepository.findAll();
        for (Product product : products) {
            Hibernate.initialize(product.getCategories());
        }
        return products.stream().map(ProductDTO::new).toList();
    }

    @Transactional
    public Product findById(Long productId) {
        Product oldProduct = productRepository.findById(productId).orElse(null);
        Hibernate.initialize(oldProduct.getCategories());
        return oldProduct;
    }
}
