package br.com.hematsu.stock_flow.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import br.com.hematsu.stock_flow.entities.User;

public interface UserRepository extends JpaRepository<User, Long> {
    
}
