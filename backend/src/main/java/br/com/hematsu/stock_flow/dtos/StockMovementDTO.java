package br.com.hematsu.stock_flow.dtos;

import java.time.Instant;

import com.fasterxml.jackson.annotation.JsonFormat;

import br.com.hematsu.stock_flow.entities.StockMovement;

public record StockMovementDTO(
        Long stockMovementId,
        @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss'Z'", timezone = "GMT-03:00") Instant date,
        Integer type, Integer quantity,
        Long productId, InnerUserDTO user) {

    public StockMovementDTO(StockMovement stockMovement) {
        this(
                stockMovement.getStockMovementId(),
                stockMovement.getDate(),
                stockMovement.getType().getCode(),
                stockMovement.getQuantity(),
                stockMovement.getProduct().getProductId(),
                new InnerUserDTO(
                        stockMovement.getUser().getUsername(),
                        stockMovement.getUser().getName()));
    }

    public record InnerUserDTO(String username, String name) {
    }
}
