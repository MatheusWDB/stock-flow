package br.com.hematsu.stock_flow.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.hematsu.stock_flow.entities.Product;
import br.com.hematsu.stock_flow.repositories.ProductRepository;

@Service
public class ProductService {

    @Autowired
    private ProductRepository productRepository;

    public void save(Product newProduct) {
        productRepository.save(newProduct);
    }
}
