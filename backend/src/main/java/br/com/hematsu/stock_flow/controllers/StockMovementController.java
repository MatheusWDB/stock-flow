package br.com.hematsu.stock_flow.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.com.hematsu.stock_flow.dtos.StockMovementDTO;
import br.com.hematsu.stock_flow.entities.Product;
import br.com.hematsu.stock_flow.entities.StockMovement;
import br.com.hematsu.stock_flow.entities.User;
import br.com.hematsu.stock_flow.mappers.StockMovementeMapper;
import br.com.hematsu.stock_flow.services.ProductService;
import br.com.hematsu.stock_flow.services.StockMovementService;
import br.com.hematsu.stock_flow.services.UserService;

@RestController
@RequestMapping("/stock-movements")
public class StockMovementController {

    @Autowired
    private StockMovementService stockMovementService;
    @Autowired
    private ProductService productService;
    @Autowired
    private UserService userService;

    @Autowired
    private StockMovementeMapper stockMovementeMapper;

    @PostMapping("/{userId}")
    public ResponseEntity<Void> createStockMovement(@PathVariable Long userId,
            @RequestBody StockMovementDTO movementDTO) {
        User user = userService.findById(userId);
        Product product = productService.findById(movementDTO.productId());

        StockMovement newMovement = stockMovementeMapper.toEntity(movementDTO, product, user);

        productService.updateStockQuantity(newMovement.getType(), newMovement.getQuantity(), product);
        
        stockMovementService.save(newMovement);

        return ResponseEntity.status(HttpStatus.CREATED).build();
    }

    @GetMapping
    public ResponseEntity<List<StockMovementDTO>> getAllStockMovement() {
        return ResponseEntity.ok().body(stockMovementService.findAll());
    }

}
