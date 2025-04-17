package br.com.hematsu.stock_flow.mappers;

import org.springframework.stereotype.Component;

import br.com.hematsu.stock_flow.dtos.StockMovementDTO;
import br.com.hematsu.stock_flow.entities.Product;
import br.com.hematsu.stock_flow.entities.StockMovement;
import br.com.hematsu.stock_flow.entities.User;

@Component
public class StockMovementeMapper {

    public StockMovementDTO toDTO(StockMovement movement) {
        return new StockMovementDTO(movement);
    }

    public StockMovement toEntity(StockMovementDTO movementDTO, Product product, User user) {
        return new StockMovement(movementDTO.getType(), movementDTO.getQuantity(), product, user);
    }
}
