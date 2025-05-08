package br.com.hematsu.stock_flow.services;

import java.util.List;

import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import br.com.hematsu.stock_flow.dtos.ProductDTO;
import br.com.hematsu.stock_flow.entities.Product;
import br.com.hematsu.stock_flow.entities.StockMovement;
import br.com.hematsu.stock_flow.enums.TypeEnum;
import br.com.hematsu.stock_flow.exceptions.movement.InvalidMovementTypeException;
import br.com.hematsu.stock_flow.exceptions.product.DuplicateProductCodeException;
import br.com.hematsu.stock_flow.exceptions.product.InvalidProductPriceException;
import br.com.hematsu.stock_flow.exceptions.product.ProductHasMovementsException;
import br.com.hematsu.stock_flow.exceptions.product.ProductNotFoundException;
import br.com.hematsu.stock_flow.repositories.ProductRepository;

@Service
public class ProductService {

    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private StockMovementService stockMovementService;

    @Transactional
    public Product save(Product newProduct, String createOrUpdate) {
        if (createOrUpdate == "create") {
            if (findByCode(newProduct.getCode()) != null) {
                throw new DuplicateProductCodeException();
            }

            if (newProduct.getCostPrice() >= newProduct.getSalePrice()) {
                throw new InvalidProductPriceException();
            }
        }

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
        Product product = productRepository.findById(productId).orElseThrow(() -> new ProductNotFoundException());

        Hibernate.initialize(product.getCategories());

        return product;
    }

    @Transactional
    public void deleteById(Long productId) {
        Product product = findById(productId);

        List<StockMovement> movements = stockMovementService.findByProduct(product);

        if (!movements.isEmpty()) {
            throw new ProductHasMovementsException();
        }

        productRepository.deleteById(productId);
    }

    @Transactional
    public Product findByCode(String code) {
        Product product = productRepository.findByCode(code).orElse(null);

        return product;
    }

    @Transactional
    public void hasCodeChanged(ProductDTO product) {
        Product product1 = findById(product.productId());
        Product product2 = findByCode(product.code());

        if (product2 == null){
            throw new ProductNotFoundException();
        }

        if (!product1.equals(product2)) {
            throw new DuplicateProductCodeException();
        }
    }

    public void updateStockQuantity(TypeEnum type, Integer quantity, Product product) {
        switch (type) {
            case IN:
                product.setStockQuantity(product.getStockQuantity() + quantity);
                break;
            case OUT:
                if (product.getStockQuantity() >= quantity) {
                    product.setStockQuantity(product.getStockQuantity() - quantity);
                } else {
                    throw new InvalidProductPriceException();
                }
                break;
            default:
                throw new InvalidMovementTypeException();
        }

        save(product, "update");
    }
}
