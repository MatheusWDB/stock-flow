package br.com.hematsu.stock_flow.dto;

import java.time.Instant;

import com.fasterxml.jackson.annotation.JsonFormat;

import br.com.hematsu.stock_flow.entities.StockMovement;

public class StockMovementDTO {
    private Long stockMovementId;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss'Z'", timezone = "GMT-03:00")
    private Instant date;
    private String type;
    private Integer quantity;
    private Long productId;
    private UserSummaryDTO user;

    public StockMovementDTO() {
    }

    public StockMovementDTO(StockMovement stockMovement) {
        this.stockMovementId = stockMovement.getStockMovementId();
        this.date = stockMovement.getDate();
        this.type = stockMovement.getType();
        this.quantity = stockMovement.getQuantity();
        this.productId = stockMovement.getProduct().getProductId();
        this.user = new UserSummaryDTO(stockMovement.getUser().getUserId(), stockMovement.getUser().getName());
    }

    public Long getStockMovementId() {
        return stockMovementId;
    }

    public void setStockMovementId(Long stockMovementId) {
        this.stockMovementId = stockMovementId;
    }

    public Instant getDate() {
        return date;
    }

    public void setDate(Instant date) {
        this.date = date;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }

    public UserSummaryDTO getUser() {
        return user;
    }

    public void setUser(UserSummaryDTO user) {
        this.user = user;
    }

    public static class UserSummaryDTO {
        private Long userId;
        private String name;

        public UserSummaryDTO(Long userId, String name) {
            this.userId = userId;
            this.name = name;
        }

        public Long getUserId() {
            return userId;
        }

        public void setUserId(Long userId) {
            this.userId = userId;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        @Override
        public String toString() {
            return "UserSummaryDTO [userId=" + userId + ", name=" + name + "]";
        }
    }

    @Override
    public String toString() {
        return "StockMovementDTO [stockMovementId=" + stockMovementId + ", date=" + date + ", type=" + type
                + ", quantity=" + quantity + ", productId=" + productId + ", user=" + user + "]";
    }

}
