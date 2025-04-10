package br.com.hematsu.stock_flow.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.com.hematsu.stock_flow.dto.StockMovementDTO;
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

    @PostMapping
    public ResponseEntity<Void> createStockMovement(@RequestBody StockMovementDTO movementDTO) {
        User user = userService.findById(movementDTO.getUser().getUserId());
        Product product = productService.findById(movementDTO.getProductId());

        StockMovement newMovement = stockMovementeMapper.toEntity(movementDTO, product, user);

        stockMovementService.save(newMovement);

        productService.updateStockQuantity(newMovement.getType(), newMovement.getQuantity(), product);

        return ResponseEntity.status(HttpStatus.CREATED).build();
    }

    @GetMapping("/{stockMovimentId}")
    public ResponseEntity<StockMovementDTO> getById(@PathVariable Long stockMovimentId) {
        StockMovement movement = stockMovementService.findById(stockMovimentId);
        System.out.println(movement);

        StockMovementDTO movementDTO = stockMovementeMapper.toDTO(movement);

        return ResponseEntity.ok().body(movementDTO);
    }

}
