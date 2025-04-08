package br.com.hematsu.stock_flow.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.com.hematsu.stock_flow.entities.Category;
import br.com.hematsu.stock_flow.services.CategoryService;

@RestController
@RequestMapping("/categories")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    @GetMapping("/findAll")
    public ResponseEntity<List<Category>> findAll(){
        List<Category> results = categoryService.findAll();
        return ResponseEntity.ok().body(results);
    }
}

