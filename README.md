# Stock Flow  
[![NPM](https://img.shields.io/npm/l/react)](https://github.com/MatheusWDB/stock-flow/blob/main/LICENSE)

# Sobre o projeto  
**Stock Flow** é uma aplicação full stack desenvolvida para gerenciamento de estoque. O sistema permite o controle de movimentações de entrada e saída de produtos, além de alertar quando produtos estão abaixo do nível mínimo de estoque. Também apresenta gráficos com os dados de movimentações e gera relatórios em PDF.

## Funcionalidades:
- Cadastro e login de usuário.
- Cadastrar, atualizar ou apagar um produto.
- Registrar movimentações de entrada e saída de produtos.
- Visualizar produtos com estoque baixo.
- Exibir gráfico de movimentações.
- Gerar PDFs com:
  - Lista de todos os produtos.
  - Lista de produtos com estoque baixo.
  - Lista de movimentações.
 
# Layout
| ![0](https://github.com/user-attachments/assets/8c28557f-bbf7-4e27-954f-18f5732f21eb) | ![1](https://github.com/user-attachments/assets/bb778d98-b173-4f05-a3b4-a0e9412ba757) | ![2](https://github.com/user-attachments/assets/f7ee5b9e-1d7c-4cf3-8965-a0159c3af79e) |
|:-------------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------------:|
| ![3](https://github.com/user-attachments/assets/fa7da7cf-b2ea-4c68-9899-e5b62db5d7f2) | ![4](https://github.com/user-attachments/assets/686ba23a-8d3c-4fd8-b9ff-8e23d65d9735) | ![5](https://github.com/user-attachments/assets/5378836e-ec7f-4bbe-befd-1b660e8747d8) |
| ![6](https://github.com/user-attachments/assets/1a9bf516-3fe8-4bfe-b5da-64f5bb7e4e90) | ![7](https://github.com/user-attachments/assets/120729f1-8e54-4c39-a1e7-836e3748655b) | ![8](https://github.com/user-attachments/assets/f46515f0-d0ed-4634-987d-36e3c39683e1) |
| ![9](https://github.com/user-attachments/assets/ad708aaf-8711-44c6-8bb1-345aa9f98c3b) | ![10](https://github.com/user-attachments/assets/acbabd15-70c0-4b97-a35f-173fea918f4b) | ![11](https://github.com/user-attachments/assets/e13482e6-badf-4b2e-9192-4d50c08eb1d2) |

# Tecnologias utilizadas  
## Frontend
- Flutter
- Dart

## Backend
- Java
- Spring Boot
- Postman (para testar as API's)

## Banco de dados
- JPA / Hibernate
- H2 (banco de dados em memória)
  
<!--  
# Implantação em produção
- Backend: [Render](https://stock-flow-backend.onrender.com)
- Frontend: [Em breve]()
- Banco de dados: [H2 - em memória]()
-->

# Como executar o projeto  
## Frontend  
Pré-requisitos: Flutter e emulador andorid instalado e aberto

```bash
# clonar repositório
git clone https://github.com/MatheusWDB/stock-flow.git

# entrar na pasta do projeto frontend
cd stock-flow/frontend

# baixar dependências
flutter pub get

# executar o projeto
flutter run
```

## Backend  
Pré-requisitos: Java 21
```bash
# clonar repositório
git clone https://github.com/MatheusWDB/stock-flow.git

# entrar na pasta do projeto backend
cd stock-flow/backend

# baixar dependências
./mvnw clean install

# executar o projeto
./mvnw spring-boot:run
```


# Autor
Matheus Wendell Dantas Bezerra

- [LinkedIn](https://www.linkedin.com/in/mwdb1703)
- [Portfólio](https://portfolio-vwy3.onrender.com/)
