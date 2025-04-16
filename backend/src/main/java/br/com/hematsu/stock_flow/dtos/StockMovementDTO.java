package br.com.hematsu.stock_flow.dtos;

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
    private InnerUserDTO user;

    public StockMovementDTO() {
    }

    public StockMovementDTO(StockMovement stockMovement) {
        this.stockMovementId = stockMovement.getStockMovementId();
        this.date = stockMovement.getDate();
        this.type = stockMovement.getType();
        this.quantity = stockMovement.getQuantity();
        this.productId = stockMovement.getProduct().getProductId();
        this.user = new InnerUserDTO(stockMovement.getUser().getEmail(), stockMovement.getUser().getName());
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

    public InnerUserDTO getUser() {
        return user;
    }

    public void setUser(InnerUserDTO user) {
        this.user = user;
    }

    public static class InnerUserDTO {
        private String email;
        private String name;

        public InnerUserDTO(String email, String name) {
            this.email = email;
            this.name = name;
        }

        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        @Override
        public String toString() {
            return "InnerUserDTO [email=" + email + ", name=" + name + "]";
        }
    }

    @Override
    public String toString() {
        return "StockMovementDTO [stockMovementId=" + stockMovementId + ", date=" + date + ", type=" + type
                + ", quantity=" + quantity + ", productId=" + productId + ", user=" + user + "]";
    }

}
