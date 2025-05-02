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
