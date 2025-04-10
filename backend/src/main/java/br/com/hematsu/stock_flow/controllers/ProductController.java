package br.com.hematsu.stock_flow.controllers;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
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
import br.com.hematsu.stock_flow.services.CategoryService;
import br.com.hematsu.stock_flow.services.ProductService;

@RestController
@RequestMapping("/products")
public class ProductController {

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ProductService productService;

    @PostMapping("/save")
    public ResponseEntity<Void> save(@RequestBody Product obj) {

        Product newProduct = new Product(obj.getName(), obj.getDescription(), obj.getCode(), obj.getCostPrice(),
                obj.getSalePrice(), obj.getStockQuantity());

        newProduct = productService.save(newProduct);

        Set<Category> categories = categoryService.findOrCreateCategories(obj.getCategories());

        newProduct.getCategories().addAll(categories);

        productService.save(newProduct);

        return ResponseEntity.ok().build();
    }

    @GetMapping("/findAll")
    public ResponseEntity<List<ProductDTO>> findAll() {
        return ResponseEntity.ok().body(productService.findAll());
    }

    @PutMapping("/update/{productId}")
    public ResponseEntity<Void> update(@PathVariable Long productId, @RequestBody ProductDTO updatedProduct) {

        Product oldProduct = productService.findById(productId);

        Set<Category> categories = categoryService.findOrCreateCategories(updatedProduct.getCategories());

        productService.save(updatedProduct.toEntity(oldProduct, categories));

        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/delete/{productId}")
    public ResponseEntity<Void> delete(@PathVariable Long productId) {
        productService.deleteByProductId(productId);

        return ResponseEntity.ok().build();
    }

}
