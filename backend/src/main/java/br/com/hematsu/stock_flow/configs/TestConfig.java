package br.com.hematsu.stock_flow.configs;

import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;

import at.favre.lib.crypto.bcrypt.BCrypt;
import br.com.hematsu.stock_flow.entities.Category;
import br.com.hematsu.stock_flow.entities.Product;
import br.com.hematsu.stock_flow.entities.StockMovement;
import br.com.hematsu.stock_flow.entities.User;
import br.com.hematsu.stock_flow.enums.TypeEnum;
import br.com.hematsu.stock_flow.enums.UserRole;
import br.com.hematsu.stock_flow.repositories.CategoryRepository;
import br.com.hematsu.stock_flow.repositories.ProductRepository;
import br.com.hematsu.stock_flow.repositories.StockMovementRepository;
import br.com.hematsu.stock_flow.repositories.UserRepository;

@Configuration
@Profile("test")
public class TestConfig implements CommandLineRunner {
        @Autowired
        private UserRepository userRepository;

        @Autowired
        private ProductRepository productRepository;

        @Autowired
        private CategoryRepository categoryRepository;

        @Autowired
        private StockMovementRepository movementRepository;

        @Override
        public void run(String... args) throws Exception {
                // Criar usuário
                User user = new User("teste@gmail.com", BCrypt.withDefaults().hashToString(12, "12345678".toCharArray()),
                                "Usuário Teste", UserRole.ADMIN);
                user = userRepository.save(user);

                // Criar categorias
                Category catRoupa = new Category("roupas");
                Category catFeminino = new Category("feminino");
                Category catMasculino = new Category("masculino");
                Category catVerão = new Category("verão");
                Category catInverno = new Category("inverno");
                Category catCasual = new Category("casual");
                Category catEsporte = new Category("esporte");

                categoryRepository.saveAll(
                                List.of(catRoupa, catFeminino, catMasculino, catVerão, catInverno, catCasual,
                                                catEsporte));

                // Produtos e movimentações
                Product p1 = new Product(null,
                                "Cropped Listrado Feminino",
                                "Cropped feminino com estampa listrada, tecido leve e confortável.",
                                "CRP-STR-003", 25.90, 59.90, 120);
                p1.getCategories().addAll(Set.of(catRoupa, catFeminino, catVerão));
                productRepository.save(p1);
                movementRepository.save(new StockMovement(TypeEnum.IN.getCode(), 15550, p1, user));

                Product p2 = new Product(null,
                                "Bermuda Masculina Moletom",
                                "Bermuda esportiva masculina, ideal para o dia a dia.",
                                "BRM-MOL-102", 35.00, 79.90, 80);
                p2.getCategories().addAll(Set.of(catRoupa, catMasculino, catCasual));
                productRepository.save(p2);
                movementRepository.save(new StockMovement(TypeEnum.IN.getCode(), 6500, p2, user));

                Product p3 = new Product(null,
                                "Jaqueta Corta Vento Feminina",
                                "Jaqueta leve ideal para ventos e dias frios.",
                                "JKT-VNT-020", 49.90, 129.90, 45);
                p3.getCategories().addAll(Set.of(catRoupa, catFeminino, catInverno));
                productRepository.save(p3);
                movementRepository.save(new StockMovement(TypeEnum.IN.getCode(), 12000, p3, user));

                Product p4 = new Product(null,
                                "Camisa Polo Masculina",
                                "Camisa polo básica, perfeita para eventos informais.",
                                "CMS-PLM-450", 28.90, 89.90, 65);
                p4.getCategories().addAll(Set.of(catRoupa, catMasculino, catCasual));
                productRepository.save(p4);
                movementRepository.save(new StockMovement(TypeEnum.IN.getCode(), 7500, p4, user));

                Product p5 = new Product(null,
                                "Legging Esportiva Feminina",
                                "Calça legging com tecido respirável e elástico.",
                                "LGG-ESP-011", 32.50, 99.90, 150);
                p5.getCategories().addAll(Set.of(catRoupa, catFeminino, catEsporte));
                productRepository.save(p5);
                movementRepository.save(new StockMovement(TypeEnum.IN.getCode(), 18000, p5, user));

                movementRepository.saveAll(List.of(
                                // Produto 1 – Cropped
                                new StockMovement(TypeEnum.OUT.getCode(), 2500, p1, user), // Saída de 25 unid
                                new StockMovement(TypeEnum.IN.getCode(), 3000, p1, user), // Entrada de 30 unid

                                // Produto 2 – Bermuda
                                new StockMovement(TypeEnum.OUT.getCode(), 1500, p2, user), // Saída de 15 unid
                                new StockMovement(TypeEnum.IN.getCode(), 2000, p2, user), // Entrada de 20 unid

                                // Produto 3 – Jaqueta
                                new StockMovement(TypeEnum.OUT.getCode(), 3000, p3, user), // Saída de 30 unid
                                new StockMovement(TypeEnum.IN.getCode(), 5000, p3, user), // Entrada de 50 unid

                                // Produto 4 – Camisa Polo
                                new StockMovement(TypeEnum.OUT.getCode(), 1800, p4, user), // Saída de 18 unid
                                new StockMovement(TypeEnum.IN.getCode(), 2500, p4, user), // Entrada de 25 unid

                                // Produto 5 – Legging
                                new StockMovement(TypeEnum.OUT.getCode(), 5000, p5, user), // Saída de 50 unid
                                new StockMovement(TypeEnum.IN.getCode(), 7000, p5, user) // Entrada de 70 unid
                ));
        }

}
