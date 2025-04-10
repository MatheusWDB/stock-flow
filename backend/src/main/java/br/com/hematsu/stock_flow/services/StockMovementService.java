package br.com.hematsu.stock_flow.services;

import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.hematsu.stock_flow.entities.StockMovement;
import br.com.hematsu.stock_flow.repositories.StockMovementRepository;

@Service
public class StockMovementService {

    @Autowired
    private StockMovementRepository stockMovementRepository;

    public StockMovement save(StockMovement movement) {
        return stockMovementRepository.save(movement);
    }

    public StockMovement findById(Long movementId) {
        StockMovement movement = stockMovementRepository.findById(movementId).orElse(null);

        Hibernate.initialize(movement.getUser());

        return movement;
    }

}
