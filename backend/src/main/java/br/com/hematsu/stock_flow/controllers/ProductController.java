package br.com.hematsu.stock_flow.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.com.hematsu.stock_flow.dto.ProductDTO;
import br.com.hematsu.stock_flow.entities.Category;
import br.com.hematsu.stock_flow.entities.Product;
import br.com.hematsu.stock_flow.services.CategoryService;
import br.com.hematsu.stock_flow.services.ProductService;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.PathVariable;

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

        for (Category category : obj.getCategories()) {

            Category checkCategory = categoryService.findByName(category.getName()) == null
                    ? categoryService.save(category)
                    : categoryService.findByName(category.getName());

            newProduct.getCategories().add(checkCategory);
        }

        productService.save(newProduct);

        return ResponseEntity.ok().build();
    }

    @GetMapping("/findAll")
    public ResponseEntity<List<ProductDTO>> findAll() {
        return ResponseEntity.ok().body(productService.findAll());
    }

    @PutMapping("/update/{productId}")
    public ResponseEntity<Void> update(@PathVariable Long productId, @RequestBody ProductDTO updatedProduct) {

        Product olProduct = productService.findById(productId);

        updatedProduct.setProductId(olProduct.getProductId());

        productService.save(updatedProduct.toEntity(olProduct));

        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/delete/{productId}")
    public ResponseEntity<Void> delete(@PathVariable Long productId){
        productService.deleteByProductId(productId);

        return ResponseEntity.ok().build();
    }

}
