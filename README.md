# Configuração PostgreSQL com Liquibase

Este repositório contém uma configuração Docker para PostgreSQL e Liquibase para migrações de banco de dados.

## Pré-requisitos

- Docker e Docker Compose instalados
- PostgreSQL instalado no sistema
- Liquibase CLI instalado (para comandos diretos)

### Instalação do PostgreSQL

Antes de executar o `run.sh`, é necessário instalar o cliente PostgreSQL no sistema (não um banco completo):

**Ubuntu/Debian:**
```bash
sudo apt update
sudo apt install postgresql postgresql-contrib
```

**macOS:**
```bash
brew install postgresql
```

*Nota: Estamos instalando apenas o cliente PostgreSQL, não um servidor de banco de dados completo. O banco será executado via Docker.*

### Instalação do Liquibase CLI

Antes de executar comandos do Liquibase, é necessário instalar o cliente Liquibase:

**Ubuntu/Debian:**
```bash
# Baixar e instalar Liquibase
```bash
# Adicionar repositório oficial do Liquibase
wget -O- https://repo.liquibase.com/liquibase.asc | sudo apt-key add -
echo "deb https://repo.liquibase.com stable main" | sudo tee /etc/apt/sources.list.d/liquibase.list

# Atualizar lista de pacotes e instalar
sudo apt update
sudo apt install liquibase
```

**macOS:**
```bash
brew install liquibase
```

**Windows:**
```bash
# Usar Chocolatey
choco install liquibase
```

*Nota: Verifique a versão mais recente disponível no [site oficial do Liquibase](https://www.liquibase.org/download).*

## Começando

### 1. Iniciar o Container PostgreSQL

```bash
docker-compose up -d
```

Isso iniciará um container PostgreSQL com as seguintes credenciais:
- **Usuário**: postgres
- **Senha**: postgres
- **Banco de dados**: postgres
- **Porta**: 5432

### 2. Conectar ao PostgreSQL

Você pode conectar ao banco de dados PostgreSQL usando o script fornecido:

```bash
./run.sh
```

## Usando Liquibase

Liquibase é uma ferramenta de gerenciamento de mudanças de esquema de banco de dados que permite rastrear, versionar e implantar mudanças no banco de dados.

### Estrutura do Liquibase

- `liquibase/changelog.xml`: Arquivo de changelog mestre que inclui todos os scripts SQL
- `liquibase/liquibase.properties`: Arquivo de configuração com detalhes de conexão do banco de dados
- `liquibase/sql/`: Diretório contendo scripts de migração SQL

### Comandos Liquibase

Aqui estão alguns comandos Liquibase comuns que você pode usar:

#### Atualizar Banco de Dados

Aplicar todos os changesets pendentes ao banco de dados:

```bash
liquibase update
```

#### Gerar SQL de Atualização

Gerar SQL para changesets pendentes sem aplicá-los:

```bash
liquibase update-sql
```

#### Rollback

Fazer rollback do changeset mais recente:

```bash
liquibase rollback-count 1
```

Fazer rollback para uma tag específica:

```bash
liquibase rollback TAG_NAME
```

#### Status

Verificar o status dos changesets:

```bash
liquibase status
```

#### Validar

Validar o changelog para erros:

```bash
liquibase validate
```

#### Histórico

Visualizar o histórico de changesets aplicados:

```bash
liquibase history
```

### Executando Comandos Liquibase

Para executar comandos Liquibase, navegue até o diretório liquibase e execute:

```bash
cd liquibase
liquibase --defaultsFile=liquibase.properties <comando>
```

Por exemplo:

```bash
cd liquibase
liquibase --defaultsFile=liquibase.properties update
```

### Trabalhando com Tags de Versão

O projeto utiliza tags para marcar versões específicas do banco de dados. As tags disponíveis são:
- v1.0: Após criação da tabela de usuários
- v1.1: Após criação da tabela de produtos
- v1.2: Após criação da tabela de pedidos
- v1.3: Após adição das chaves estrangeiras
- v1.4: Após inserção dos dados de exemplo

#### Listando Tags Disponíveis

Para listar todas as tags disponíveis no banco de dados:

```bash
cd liquibase
liquibase --defaultsFile=liquibase.properties tag-exists v1.0
```

Repita o comando para cada tag (v1.0, v1.1, v1.2, v1.3, v1.4) para verificar quais estão aplicadas.

#### Atualizando até uma Tag Específica

Para atualizar o banco de dados até uma tag específica:

```bash
cd liquibase
liquibase --defaultsFile=liquibase.properties update-to-tag v1.2
```

Este comando aplicará todos os changesets até a tag v1.2 (inclusive).

#### Rollback para uma Tag Específica

Para reverter o banco de dados para uma tag específica:

```bash
cd liquibase
liquibase --defaultsFile=liquibase.properties rollback v1.1
```

Este comando reverterá todas as alterações feitas após a tag v1.1, retornando o banco ao estado marcado por essa tag.

## Esquema de Banco de Dados de Exemplo

Os changesets do Liquibase criarão as seguintes tabelas:

1. `users`: Informações do usuário
2. `products`: Catálogo de produtos
3. `orders`: Pedidos do cliente
4. `order_items`: Itens dentro dos pedidos

Cada script inclui instruções de rollback para fácil reversão de mudanças se necessário.

## Solução de Problemas

### Identificadores de Changeset Duplicados

Se você encontrar um erro como:
```
Validation Failed: 5 changesets had duplicate identifiers
```

Isso significa que seus IDs de changeset não são únicos entre os arquivos. Em nossa configuração, cada changeset tem um identificador único no formato `autor:id`, por exemplo:

```
--changeset testuser:01-create-users-table
```

Certifique-se de que cada changeset tenha um ID único em todos os seus arquivos SQL.
