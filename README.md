# FastPass — Sistema de Passe de Ônibus Digital

Projeto da disciplina de Programação Orientada a Objetos — Universidade Federal do Agreste de Pernambuco (UFAPE).

Sistema de gerenciamento de passe de ônibus digital, baseado no sistema de transporte público de Garanhuns/PE. Permite cadastro de usuário, consulta de saldo, recarga do passe (Pix/Débito), consulta de horários de linhas e validação de carteirinha estudantil.

## Equipe

- Isaac de Sousa Cadé
- Cauã Luis da Silva
- Antony Caio Tomé de Andrade

## Stack técnica

| Camada | Tecnologia |
|---|---|
| Backend | Java 21, Spring Boot 3.5.6 |
| Persistência | Spring Data JPA (Hibernate) + PostgreSQL 16 |
| Frontend | Flutter |
| Build | Maven (via wrapper)|
| Banco de dados| PostgreSQL rodando em container Docker |

## Pré-requisitos

Antes de rodar o projeto, é necessário ter instalado:

- **JDK 21** 
- **Docker Desktop** — para subir o banco PostgreSQL sem precisar instalar localmente
- **Flutter SDK** (apenas para rodar o front-end) — Que no momento ainda nâo foi feito

## Como rodar o backend

**1. Clonar o repositório**
```bash
git clone <link-do-repositorio>
cd fastpass-POO
```

**2. Subir o banco de dados (Docker)**

O projeto usa um container PostgreSQL definido em `docker-compose.yml`, na raiz do repositório. Para subir:
```bash
docker compose up -d
```
Isso baixa a imagem do PostgreSQL 16 (apenas na primeira vez) e sobe o banco em segundo plano, na porta `5432`. Para conferir se está rodando:
```bash
docker ps
```

Para parar o banco quando não estiver em uso:
```bash
docker compose down
```

**3. Rodar a aplicação**

Com o banco no ar, execute (Windows):
```powershell
.\mvnw.cmd spring-boot:run
```
Ou (Linux/macOS):
```bash
./mvnw spring-boot:run
```
A aplicação sobe em `http://localhost:8080`.

**4. Rodar os testes**
```powershell
.\mvnw.cmd test
```
Os testes de persistência usam um banco H2 em memória, não dependem do Docker estar rodando.

## Estrutura do projeto

```
fastpass-POO/
├── docker-compose.yml          # Configuração do banco PostgreSQL
├── pom.xml                     # Dependências do backend (Maven)
├── src/
│   ├── main/java/com/example/fastpass/
│   │   ├── model/               # Entidades JPA
│   │   ├── repository/          # Repositórios (Spring Data JPA)
│   │   ├── service/              # Regras de negócio
│   │   ├── facade/               # Fachada
│   │   └── controller/           # Endpoints REST
│   └── test/                    # Testes automatizados
└── frontend/
    └── fastpass_app/            # Aplicativo Flutter em desenvilvimento
        └── lib/
            ├── core/            
            ├── models/           
            ├── shared/
            └── features/        
```

## Cronograma de entregas

| Semana | Entrega | Tag do Git |
|---|---|---|
| 1 | Model, Repository, testes de persistência | `semana-1` |
| 2 | Service, Fachada, Exceções | `semana-2` |
| 3 | DTO, Validation, Controller | `semana-3` |
| 4 | Integração front-end ↔ back-end | `semana-4` |
| 5 | Finalização | `entrega-final` |
