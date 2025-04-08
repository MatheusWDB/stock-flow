package br.com.hematsu.stock_flow.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import br.com.hematsu.stock_flow.entities.StockMovement;

public interface StockMovementRepository extends JpaRepository<StockMovement, Long> {
    
}
