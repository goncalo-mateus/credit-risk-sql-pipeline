-- 1. CRIAR TABELAS
CREATE TABLE clientes (
  cliente_id INT PRIMARY KEY,
  Nome VARCHAR(100) NOT NULL,
  idade INT,
  rendimento_mensal DECIMAL(10,2),
  score_credito_inicial INT,
  data_registo DATE
);

CREATE TABLE pedidos_credito (
  pedido_id INT PRIMARY KEY,
  cliente_id INT,
  montante_solicitado DECIMAL(10,2),
  finalidade VARCHAR(50),
  canal_origem VARCHAR(50),
  data_pedido DATE,
  estado_pedido VARCHAR(20),
  FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);

CREATE TABLE contratos_credito (
  contrato_id INT UNIQUE,
  pedido_id INT,
  cliente_id INT,
  montante_financiado DECIMAL(10,2),
  taxa_juro_anual DECIMAL(5,2),
  prazo_meses INT,
  data_inicio DATE,
  estado_contrato VARCHAR(20),
  FOREIGN KEY (pedido_id) REFERENCES pedidos_credito(pedido_id),
  FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);

CREATE TABLE pagamentos (
  pagamento_id INT PRIMARY KEY,
  contrato_id INT,
  numero_prestacao INT,
  valor_prestacao DECIMAL(10,2),
  data_vencimento DATE,
  data_pagamento DATE,
  dias_atraso INT DEFAULT 0,
  FOREIGN KEY (contrato_id) REFERENCES contratos_credito(contrato_id)
);

--dados clintes
INSERT INTO clientes VALUES 
(1, 'Ana Silva', 34, 2100.00, 720, '2025-01-10'),
(2, 'João Santos', 45, 1250.00, 580, '2025-03-15'),
(3, 'Maria Costa', 29, 3100.00, 810, '2025-06-20');

INSERT INTO pedidos_credito VALUES 
(101, 1, 5000.00, 'Automóvel', 'Website', '2026-01-15', 'Aprovado'),
(102, 2, 12000.00, 'Pessoal', 'Loja FNAC', '2026-02-01', 'Recusado'),
(103, 3, 15000.00, 'Obras', 'Website', '2026-02-10', 'Aprovado');

INSERT INTO contratos_credito VALUES 
(5001, 101, 1, 5000.00, 8.50, 24, '2026-01-20', 'Ativo'),
(5002, 103, 3, 15000.00, 6.75, 60, '2026-02-15', 'Ativo');

INSERT INTO pagamentos VALUES 
(9001, 5001, 1, 227.00, '2026-02-20', '2026-02-19', 0),
(9002, 5001, 2, 227.00, '2026-03-20', '2026-03-25', 5),
(9003, 5001, 3, 227.00, '2026-04-20', NULL, 0),
(9004, 5002, 1, 295.00, '2026-03-15', '2026-03-15', 0);

SELECT 
    canal_origem,
    COUNT(pedido_id) AS total_pedidos,
    SUM(CASE WHEN estado_pedido = 'Aprovado' THEN 1 ELSE 0 END) AS pedidos_aprovados,
    ROUND(CAST(SUM(CASE WHEN estado_pedido = 'Aprovado' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(pedido_id) * 100, 2) AS taxa_aprovacao_pct
FROM pedidos_credito
GROUP BY canal_origem; 

SELECT 
    c.nome,
    p.contrato_id,
    p.numero_prestacao,
    p.valor_prestacao,
    p.data_vencimento
FROM pagamentos p
JOIN contratos_credito cc ON p.contrato_id = cc.contrato_id
JOIN clientes c ON cc.cliente_id = c.cliente_id
WHERE p.data_pagamento IS NULL