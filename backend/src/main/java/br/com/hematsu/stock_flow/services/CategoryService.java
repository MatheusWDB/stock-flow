package br.com.hematsu.stock_flow.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.hematsu.stock_flow.entities.Category;
import br.com.hematsu.stock_flow.repositories.CategoryRepository;
import jakarta.transaction.Transactional;

@Service
public class CategoryService {

    @Autowired
    private CategoryRepository categoryRepository;

    @Transactional
    public List<Category> findAll() {
        return categoryRepository.findAll();
    }

    @Transactional
    public Category findByName(String name) {
        return categoryRepository.findByName(name).orElse(null);
    }

    @Transactional
    public Category save(Category category) {
        return categoryRepository.save(category);
    }

}
