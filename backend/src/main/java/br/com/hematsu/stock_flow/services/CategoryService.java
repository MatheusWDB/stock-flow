package br.com.hematsu.stock_flow.services;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

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

    public Set<Category> findOrCreateCategories(Set<Category> categories) {
        Set<Category> updatedCategories = new HashSet<>();

        for (Category category : categories) {

            Category existing = findByName(category.getName());

            if (existing == null) {
                existing = save(category);
            }

            updatedCategories.add(existing);
        }

        return updatedCategories;
    }
}
