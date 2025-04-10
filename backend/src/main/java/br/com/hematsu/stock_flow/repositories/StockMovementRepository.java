package br.com.hematsu.stock_flow.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import br.com.hematsu.stock_flow.entities.Product;
import br.com.hematsu.stock_flow.entities.StockMovement;

public interface StockMovementRepository extends JpaRepository<StockMovement, Long> {
    Optional<List<StockMovement>> findByProduct(Product product);
}
