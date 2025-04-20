package br.com.hematsu.stock_flow.repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import br.com.hematsu.stock_flow.entities.Product;

public interface ProductRepository extends JpaRepository<Product, Long> {
    void deleteByProductId(Long productId);

    Optional<Product> findByCode(String code);
}
