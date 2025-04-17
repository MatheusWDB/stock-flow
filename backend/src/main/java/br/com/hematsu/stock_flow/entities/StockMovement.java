package br.com.hematsu.stock_flow.entities;

import java.io.Serializable;
import java.time.Instant;

import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonFormat;

import br.com.hematsu.stock_flow.enums.TypeEnum;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Entity(name = "tb_stock_movements")
public class StockMovement implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long stockMovementId;

    @CreationTimestamp
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss'Z'", timezone = "GMT-03:00")
    private Instant date;
    private Integer type;
    private Integer quantity;

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    public StockMovement() {
    }

    public StockMovement(int type, Integer quantity, Product product, User user) {
        this.type = type;
        this.quantity = quantity;
        this.product = product;
        this.user = user;
    }

    public Long getStockMovementId() {
        return stockMovementId;
    }

    public Instant getDate() {
        return date;
    }

    public void setDate(Instant date) {
        this.date = date;
    }

    public TypeEnum getType() {
        return TypeEnum.valueOf(type);
    }

    public void setType(TypeEnum type) {
        if (type != null)
            this.type = type.getCode();
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((stockMovementId == null) ? 0 : stockMovementId.hashCode());
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        StockMovement other = (StockMovement) obj;
        if (stockMovementId == null) {
            if (other.stockMovementId != null)
                return false;
        } else if (!stockMovementId.equals(other.stockMovementId))
            return false;
        return true;
    }

}
