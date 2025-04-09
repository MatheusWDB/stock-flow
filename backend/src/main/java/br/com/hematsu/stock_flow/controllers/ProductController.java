package br.com.hematsu.stock_flow.controllers;

import java.util.HashSet;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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

        for (Category category : obj.getCategories()) {

            Category checkCategory = categoryService.findByName(category.getName()) == null
                    ? categoryService.save(category)
                    : categoryService.findByName(category.getName());

            newProduct.getCategories().add(checkCategory);
        }

        productService.save(newProduct);

        return ResponseEntity.ok().build();
    }

}
