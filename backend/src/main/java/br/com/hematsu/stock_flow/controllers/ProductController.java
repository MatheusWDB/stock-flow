package br.com.hematsu.stock_flow.controllers;

import java.util.List;
import java.util.Set;
import br.com.hematsu.stock_flow.services.StockMovementService;
import br.com.hematsu.stock_flow.services.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.com.hematsu.stock_flow.dtos.ProductDTO;
import br.com.hematsu.stock_flow.entities.Category;
import br.com.hematsu.stock_flow.entities.Product;
import br.com.hematsu.stock_flow.entities.StockMovement;
import br.com.hematsu.stock_flow.entities.User;
import br.com.hematsu.stock_flow.enums.TypeEnum;
import br.com.hematsu.stock_flow.mappers.ProductMapper;
import br.com.hematsu.stock_flow.services.CategoryService;
import br.com.hematsu.stock_flow.services.ProductService;

@RestController
@RequestMapping("/products")
public class ProductController {

    @Autowired
    private StockMovementService stockMovementService;

    @Autowired
    private UserService userService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ProductService productService;

    @Autowired
    private ProductMapper productMapper;

    @PostMapping("/{userId}")
    public ResponseEntity<Void> createProduct(@PathVariable Long userId, @RequestBody ProductDTO productDTO) {
        Product newProduct = productMapper.toEntity(productDTO);
        newProduct = productService.save(newProduct, "create");

        Set<Category> categories = categoryService.findOrCreateCategories(productDTO.categories());

        newProduct.getCategories().addAll(categories);

        newProduct = productService.save(newProduct, "update");

        User user = userService.findById(userId);

        StockMovement movement = new StockMovement(TypeEnum.IN.getCode(), newProduct.getStockQuantity(), newProduct,
                user);

        stockMovementService.save(movement);

        return ResponseEntity.status(HttpStatus.CREATED).build();
    }

    @GetMapping
    public ResponseEntity<List<ProductDTO>> getAllProducts() {
        return ResponseEntity.status(HttpStatus.OK).body(productService.findAll());
    }

    @PutMapping
    public ResponseEntity<Void> updateProduct(@RequestBody ProductDTO productDTO) {

        productService.hasCodeChanged(productDTO);

        Set<Category> categories = categoryService.findOrCreateCategories(productDTO.categories());

        Product updatedProduct = productMapper.toEntity(productDTO);
        updatedProduct.getCategories().addAll(categories);

        productService.save(updatedProduct, "update");

        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }

    @DeleteMapping("/{productId}")
    public ResponseEntity<Void> deleteProduct(@PathVariable Long productId) {
        productService.deleteById(productId);

        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }

}
