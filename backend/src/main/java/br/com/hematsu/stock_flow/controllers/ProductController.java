package br.com.hematsu.stock_flow.controllers;

import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.com.hematsu.stock_flow.dto.ProductDTO;
import br.com.hematsu.stock_flow.entities.Category;
import br.com.hematsu.stock_flow.entities.Product;
import br.com.hematsu.stock_flow.mappers.ProductMapper;
import br.com.hematsu.stock_flow.services.CategoryService;
import br.com.hematsu.stock_flow.services.ProductService;

@RestController
@RequestMapping("/products")
public class ProductController {

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ProductService productService;

    @Autowired
    private ProductMapper productMapper;

    @PostMapping
    public ResponseEntity<Void> createProduct(@RequestBody ProductDTO productDTO) {
        Product newProduct = productMapper.toEntity(productDTO);
        newProduct = productService.save(newProduct);

        Set<Category> categories = categoryService.findOrCreateCategories(productDTO.getCategories());
        newProduct.getCategories().addAll(categories);

        productService.save(newProduct);

        return ResponseEntity.status(HttpStatus.CREATED).build();
    }

    @GetMapping
    public ResponseEntity<List<ProductDTO>> getAllProducts() {
        return ResponseEntity.ok().body(productService.findAll());
    }

    @PutMapping("/{productId}")
    public ResponseEntity<Void> updateProduct(@PathVariable Long productId, @RequestBody ProductDTO productDTO) {

        Product updatedProduct = productService.findById(productId);

        Set<Category> categories = categoryService.findOrCreateCategories(productDTO.getCategories());

        productService.save(productDTO.toEntityForUpdate(updatedProduct, categories));

        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }

    @DeleteMapping("/{productId}")
    public ResponseEntity<Void> deleteProduct(@PathVariable Long productId) {
        productService.deleteById(productId);

        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }

}
