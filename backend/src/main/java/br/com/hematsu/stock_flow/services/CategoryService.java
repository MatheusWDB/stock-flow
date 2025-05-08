package br.com.hematsu.stock_flow.services;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.hematsu.stock_flow.dtos.ProductDTO;
import br.com.hematsu.stock_flow.dtos.ProductDTO.InnerCategoryDTO;
import br.com.hematsu.stock_flow.entities.Category;
import br.com.hematsu.stock_flow.repositories.CategoryRepository;
import jakarta.transaction.Transactional;

@Service
public class CategoryService {

    @Autowired
    private CategoryRepository categoryRepository;

    public List<Category> findAll() {
        return categoryRepository.findAll();
    }

    public Category findByName(String name) {
        return categoryRepository.findByName(name).orElse(null);
    }

    @Transactional
    public Category save(Category category) {
        return categoryRepository.save(category);
    }

    public Set<Category> findOrCreateCategories(Set<ProductDTO.InnerCategoryDTO> categories) {
        Set<Category> updatedCategories = new HashSet<>();

        for (InnerCategoryDTO category : categories) {

            Category existing = findByName(category.name());

            if (existing == null) {
                existing = save(new Category(category.name()));
            }

            updatedCategories.add(existing);
        }

        return updatedCategories;
    }
}
