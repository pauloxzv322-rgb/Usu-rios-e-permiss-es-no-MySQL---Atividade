-- Banco da loja virtual (rode como root)
CREATE DATABASE loja_online_seg;
USE loja_online_seg;
 
CREATE TABLE produto (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  preco DECIMAL(7,2) NOT NULL,
  estoque INT NOT NULL
);
 
-- Clientes: e-mail é dado pessoal
CREATE TABLE cliente (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  cidade VARCHAR(40) NOT NULL
);
 
-- Pedidos: ligam cliente e produto
CREATE TABLE pedido (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cliente_id INT NOT NULL,
  produto_id INT NOT NULL,
  quantidade INT NOT NULL,
  status VARCHAR(20) NOT NULL,
  FOREIGN KEY (cliente_id) REFERENCES cliente(id),
  FOREIGN KEY (produto_id) REFERENCES produto(id)
);
 
INSERT INTO produto (nome, preco, estoque) VALUES
  ('Fone Bluetooth', 149.90, 25),
  ('Mouse sem fio', 79.90, 40),
  ('Teclado mecânico', 289.00, 12),
  ('Webcam HD', 199.00, 9);
 
INSERT INTO cliente (nome, email, cidade) VALUES
  ('Larissa Prado', 'larissa.prado@email.com', 'Recife'),
  ('Otávio Cunha', 'otavio.cunha@email.com', 'Curitiba'),
  ('Sabrina Melo', 'sabrina.melo@email.com', 'Belém');
 
INSERT INTO pedido (cliente_id, produto_id, quantidade, status) VALUES
  (1, 1, 1, 'Entregue'),
  (2, 3, 1, 'Pago'),
  (3, 2, 2, 'Pago'),
  (1, 4, 1, 'Novo');
  
  SELECT CURRENT_USER();
  
  CREATE USER 'site_loja'@'localhost'
  IDENTIFIED BY 'Site@Loja2026';
  
  SELECT user, host FROM mysql.user;

-- Limpa caso algum tenha sido criado antes com erro
DROP USER IF EXISTS 'site_loja '@'localhost';
DROP USER IF EXISTS 'site_loja'@'localhost';
DROP USER IF EXISTS 'suporte'@'localhost';
DROP USER IF EXISTS 'financeiro'@'localhost';

-- Cria os 3 usuários exatamente como pedido na tabela
CREATE USER 'site_loja'@'localhost' IDENTIFIED BY 'Site@Loja2026';
CREATE USER 'suporte'@'localhost' IDENTIFIED BY 'Suporte@2026';
CREATE USER 'financeiro'@'localhost' IDENTIFIED BY 'Financ@2026';
-- 1. Permissões do site_loja (ver produtos e cadastrar pedidos)
GRANT SELECT ON loja_online_seg.produto TO 'site_loja'@'localhost';
GRANT INSERT ON loja_online_seg.pedido TO 'site_loja'@'localhost';

-- 2. Permissões do suporte (ver clientes, ver pedidos e atualizar pedidos)
GRANT SELECT ON loja_online_seg.cliente TO 'suporte'@'localhost';
GRANT SELECT, UPDATE ON loja_online_seg.pedido TO 'suporte'@'localhost';

-- 3. Permissões do financeiro (só consultar todas as tabelas do banco)
GRANT SELECT ON loja_online_seg.* TO 'financeiro'@'localhost';

SHOW GRANTS FOR 'site_loja'@'localhost';
SHOW GRANTS FOR 'suporte'@'localhost';
SHOW GRANTS FOR 'financeiro'@'localhost';

  -- Vamos adicionar algumas permissões para o Luiz?
GRANT SELECT ON loja_online_seg.produto TO 'site_loja'@'localhost';
GRANT INSERT ON loja_online_seg.pedido TO 'site_loja'@'localhost';

SHOW GRANTS FOR 'site_loja'@'localhost';

-- 1. site_loja: ver produtos (SELECT) e cadastrar pedidos (INSERT)
GRANT SELECT ON loja_online_seg.produto TO 'site_loja'@'localhost';
GRANT INSERT ON loja_online_seg.pedido TO 'site_loja'@'localhost';

-- 2. suporte: ver clientes (SELECT), ver pedidos (SELECT) e mudar status do pedido (UPDATE)
GRANT SELECT ON loja_online_seg.cliente TO 'suporte'@'localhost';
GRANT SELECT, UPDATE ON loja_online_seg.pedido TO 'suporte'@'localhost';

-- 3. financeiro: só consultar (SELECT) em todas as tabelas (*)
GRANT SELECT ON loja_online_seg.* TO 'financeiro'@'localhost';

SHOW GRANTS FOR 'site_loja'@'localhost';
SHOW GRANTS FOR 'suporte'@'localhost';
SHOW GRANTS FOR 'financeiro'@'localhost';

USE loja_online_seg;

-- (a) Ver produtos
SELECT * FROM produto;

-- (b) Cadastrar pedido
INSERT INTO pedido (cliente_id, produto_id, quantidade, status)
VALUES (2, 1, 1, 'Novo');

-- (c) Ver clientes
SELECT * FROM cliente;

-- (d) Apagar pedido
DELETE FROM pedido WHERE id = 1;

USE loja_online_seg;

-- (a) Mudar o status do pedido 2 para Enviado
UPDATE pedido SET status = 'Enviado' WHERE id = 2;

-- (b) Apagar o cliente 3
DELETE FROM cliente WHERE id = 3;

-- Tira a permissão de cadastrar pedidos (INSERT) do site_loja
REVOKE INSERT ON loja_online_seg.pedido FROM 'site_loja'@'localhost';

-- Mostra que agora ele só tem permissão de ver produtos (SELECT)
SHOW GRANTS FOR 'site_loja'@'localhost';

-- Tira a permissão de INSERT na tabela pedido
REVOKE INSERT ON loja_online_seg.pedido FROM 'site_loja'@'localhost';

-- Mostra que agora ele só pode consultar (SELECT) a tabela produto
SHOW GRANTS FOR 'site_loja'@'localhost';

ALTER USER 'financeiro'@'localhost' ACCOUNT LOCK;

-- Apaga os 3 usuários criados
DROP USER 'site_loja'@'localhost';
DROP USER 'suporte'@'localhost';
DROP USER 'financeiro'@'localhost';

-- Confirma que os 3 sumiram da lista do servidor
SELECT user, host FROM mysql.user;

/*
Pergunta: Por que o site não deve se conectar ao banco como root?

Resposta: O site não deve se conectar ao banco como root devido ao princípio do menor privilégio,
que determina que cada usuário ou sistema deve ter apenas as permissões mínimas necessárias para
realizar suas funções. Como o usuário root tem controle total sobre o servidor, se o site sofrer
um ataque (como SQL Injection) ou apresentar alguma falha de segurança, o invasor poderá ler dados
pessoais dos clientes, alterar preços, apagar registros ou até excluir o banco de dados inteiro.
*/











