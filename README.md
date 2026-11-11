# Usuários e Permissões no MySQL

## Sobre a atividade

Este repositório reúne a atividade prática sobre **gerenciamento de usuários e permissões no MySQL**, com foco no controle de acesso ao banco de dados.

O objetivo é compreender como criar usuários, definir senhas, conceder privilégios específicos e revogar permissões quando necessário.

## Objetivos de aprendizagem

- Compreender a importância do controle de acesso a bancos de dados.
- Criar e administrar usuários no MySQL.
- Conceder permissões de acordo com a necessidade de cada usuário.
- Consultar os privilégios atribuídos.
- Revogar permissões e reforçar a segurança do banco de dados.

## Conceitos e comandos utilizados

Os exemplos abaixo demonstram comandos comuns relacionados ao gerenciamento de usuários e privilégios no MySQL.

### 1. Criar um usuário

```sql
CREATE USER 'usuario'@'localhost' IDENTIFIED BY 'senha_segura';
```

### 2. Conceder permissões

Para conceder permissões de consulta e inclusão em um banco específico:

```sql
GRANT SELECT, INSERT ON nome_do_banco.* TO 'usuario'@'localhost';
```

### 3. Consultar permissões

```sql
SHOW GRANTS FOR 'usuario'@'localhost';
```

### 4. Revogar permissões

```sql
REVOKE INSERT ON nome_do_banco.* FROM 'usuario'@'localhost';
```

### 5. Excluir um usuário

```sql
DROP USER 'usuario'@'localhost';
```

> **Atenção:** substitua os nomes de usuários, bancos de dados e senhas pelos valores definidos no ambiente da atividade. Execute comandos administrativos somente em um banco de testes ou em um ambiente no qual você tenha autorização.

## Como executar

1. Instale e inicie o MySQL Server.
2. Acesse o MySQL com uma conta que tenha privilégios administrativos.
3. Abra o MySQL Workbench ou outro cliente SQL de sua preferência.
4. Execute os comandos da atividade na ordem indicada, adaptando os identificadores conforme necessário.
5. Utilize `SHOW GRANTS` para conferir se as permissões foram aplicadas corretamente.

## Tecnologias e ferramentas

- **MySQL** — sistema gerenciador de banco de dados relacional.
- **SQL** — linguagem utilizada para criar usuários e administrar privilégios.
- **MySQL Workbench** — ferramenta opcional para conexão e execução de comandos SQL.

## Aprendizado

A atividade demonstra a importância de aplicar o princípio do menor privilégio: cada usuário deve receber somente as permissões necessárias para realizar suas tarefas. Essa prática contribui para a segurança, a organização e a integridade das informações armazenadas.

---

**Repositório acadêmico:** atividade prática de banco de dados — usuários e permissões no MySQL.
