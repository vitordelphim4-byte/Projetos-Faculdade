-- Criar tabelas

CREATE TABLE CATEGORIA (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome_categoria VARCHAR(100) NOT NULL UNIQUE,
    descricao TEXT
);

CREATE TABLE EDITORA (
    id_editora INT AUTO_INCREMENT PRIMARY KEY,
    nome_editora VARCHAR(150) NOT NULL UNIQUE,
    pais VARCHAR(50)
);

CREATE TABLE AUTOR (
    id_autor INT AUTO_INCREMENT PRIMARY KEY,
    nome_autor VARCHAR(150) NOT NULL,
    nacionalidade VARCHAR(50),
    biografia TEXT
);

CREATE TABLE LIVRO (
    id_livro INT AUTO_INCREMENT PRIMARY KEY,
    isbn VARCHAR(20) NOT NULL UNIQUE,
    titulo VARCHAR(255) NOT NULL,
    id_categoria INT NOT NULL,
    id_editora INT NOT NULL,
    descricao TEXT,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT NOT NULL DEFAULT 0,
    num_paginas INT,
    idioma VARCHAR(30) DEFAULT 'Português',
    data_publicacao DATE,
    FOREIGN KEY (id_categoria) REFERENCES CATEGORIA(id_categoria),
    FOREIGN KEY (id_editora) REFERENCES EDITORA(id_editora)
);

CREATE TABLE LIVRO_AUTOR (
    id_livro INT NOT NULL,
    id_autor INT NOT NULL,
    PRIMARY KEY (id_livro, id_autor),
    FOREIGN KEY (id_livro) REFERENCES LIVRO(id_livro),
    FOREIGN KEY (id_autor) REFERENCES AUTOR(id_autor)
);

CREATE TABLE CLIENTE (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    email VARCHAR(150) NOT NULL UNIQUE,
    nome VARCHAR(100) NOT NULL,
    sobrenome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    senha VARCHAR(255) NOT NULL,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE ENDERECO (
    id_endereco INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    cep VARCHAR(10) NOT NULL,
    rua VARCHAR(200) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    complemento VARCHAR(100),
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado VARCHAR(2) NOT NULL,
    endereco_principal BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente)
);

CREATE TABLE CARRINHO (
    id_carrinho INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL UNIQUE,
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente)
);

CREATE TABLE ITEM_CARRINHO (
    id_item_carrinho INT AUTO_INCREMENT PRIMARY KEY,
    id_carrinho INT NOT NULL,
    id_livro INT NOT NULL,
    quantidade INT NOT NULL DEFAULT 1,
    preco_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_carrinho) REFERENCES CARRINHO(id_carrinho),
    FOREIGN KEY (id_livro) REFERENCES LIVRO(id_livro),
    UNIQUE (id_carrinho, id_livro)
);

CREATE TABLE PEDIDO (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_endereco INT NOT NULL,
    data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    valor_total DECIMAL(10,2) NOT NULL,
    status VARCHAR(30) DEFAULT 'Aguardando Pagamento',
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente),
    FOREIGN KEY (id_endereco) REFERENCES ENDERECO(id_endereco)
);

CREATE TABLE ITEM_PEDIDO (
    id_item_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_livro INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES PEDIDO(id_pedido),
    FOREIGN KEY (id_livro) REFERENCES LIVRO(id_livro)
);

CREATE TABLE PAGAMENTO (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL UNIQUE,
    forma_pagamento VARCHAR(50) NOT NULL,
    status_pagamento VARCHAR(30) DEFAULT 'Pendente',
    valor_pago DECIMAL(10,2) NOT NULL,
    data_pagamento DATETIME,
    FOREIGN KEY (id_pedido) REFERENCES PEDIDO(id_pedido)
);

CREATE TABLE AVALIACAO (
    id_avaliacao INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_livro INT NOT NULL,
    nota INT NOT NULL,
    comentario TEXT,
    data_avaliacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente),
    FOREIGN KEY (id_livro) REFERENCES LIVRO(id_livro),
    UNIQUE (id_cliente, id_livro)
);

-- Inserir dados

INSERT INTO CATEGORIA (nome_categoria, descricao) VALUES
('Ficção', 'Livros de ficção literária'),
('Romance', 'Livros de romance e relacionamentos'),
('Suspense', 'Livros de suspense e mistério'),
('Autoajuda', 'Livros de desenvolvimento pessoal'),
('Tecnologia', 'Livros sobre programação e tecnologia'),
('Biografia', 'Biografias e memórias'),
('Infantil', 'Livros para crianças'),
('Fantasia', 'Livros de fantasia e magia');

INSERT INTO EDITORA (nome_editora, pais) VALUES
('Companhia das Letras', 'Brasil'),
('Editora Rocco', 'Brasil'),
('Intrínseca', 'Brasil'),
('Sextante', 'Brasil'),
('Novatec', 'Brasil'),
('Casa do Código', 'Brasil'),
('Penguin', 'Estados Unidos'),
('HarperCollins', 'Estados Unidos');

INSERT INTO AUTOR (nome_autor, nacionalidade, biografia) VALUES
('Machado de Assis', 'Brasileiro', 'Escritor brasileiro considerado um dos maiores da literatura'),
('Clarice Lispector', 'Brasileira', 'Escritora e jornalista brasileira'),
('J.K. Rowling', 'Britânica', 'Autora da série Harry Potter'),
('George Orwell', 'Britânico', 'Escritor e jornalista inglês'),
('Agatha Christie', 'Britânica', 'Escritora de romances policiais'),
('Robert Martin', 'Americano', 'Engenheiro de software e autor'),
('Martin Fowler', 'Britânico', 'Autor e especialista em desenvolvimento de software'),
('Paulo Coelho', 'Brasileiro', 'Escritor e romancista brasileiro');

INSERT INTO LIVRO (isbn, titulo, id_categoria, id_editora, descricao, preco, estoque, num_paginas, idioma, data_publicacao) VALUES
('978-8535908770', 'Dom Casmurro', 1, 1, 'Romance clássico da literatura brasileira', 35.90, 50, 256, 'Português', '1899-01-01'),
('978-8535911664', 'A Hora da Estrela', 1, 1, 'Romance de Clarice Lispector', 29.90, 30, 88, 'Português', '1977-01-01'),
('978-8532530790', 'Harry Potter e a Pedra Filosofal', 8, 2, 'Primeiro livro da saga Harry Potter', 49.90, 100, 264, 'Português', '1997-06-26'),
('978-8535914849', '1984', 1, 1, 'Distopia clássica de George Orwell', 44.90, 75, 416, 'Português', '1949-06-08'),
('978-0062073488', 'Assassinato no Expresso do Oriente', 3, 7, 'Romance policial de Agatha Christie', 39.90, 40, 256, 'Português', '1934-01-01'),
('978-8576082675', 'Código Limpo', 5, 5, 'Habilidades práticas do Agile Software', 89.90, 60, 425, 'Português', '2008-08-01'),
('978-8575225646', 'Refatoração', 5, 6, 'Aperfeiçoando o design de códigos existentes', 79.90, 45, 438, 'Português', '1999-06-01'),
('978-8573028515', 'O Alquimista', 1, 4, 'Livro de Paulo Coelho', 34.90, 80, 208, 'Português', '1988-01-01'),
('978-8535929867', 'A Paixão Segundo G.H.', 1, 1, 'Romance filosófico de Clarice Lispector', 42.90, 25, 176, 'Português', '1964-01-01'),
('978-8532530806', 'Harry Potter e a Câmara Secreta', 8, 2, 'Segundo livro da saga Harry Potter', 49.90, 95, 288, 'Português', '1998-07-02');

INSERT INTO LIVRO_AUTOR (id_livro, id_autor) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 2), (10, 3);

INSERT INTO CLIENTE (cpf, email, nome, sobrenome, telefone, senha) VALUES
('123.456.789-00', 'joao.silva@email.com', 'João', 'Silva', '(11) 98765-4321', 'senha123'),
('987.654.321-00', 'maria.santos@email.com', 'Maria', 'Santos', '(21) 97654-3210', 'senha456'),
('456.789.123-00', 'pedro.oliveira@email.com', 'Pedro', 'Oliveira', '(31) 96543-2109', 'senha789'),
('789.123.456-00', 'ana.costa@email.com', 'Ana', 'Costa', '(41) 95432-1098', 'senha101'),
('321.654.987-00', 'carlos.mendes@email.com', 'Carlos', 'Mendes', '(51) 94321-0987', 'senha102');

INSERT INTO ENDERECO (id_cliente, cep, rua, numero, complemento, bairro, cidade, estado, endereco_principal) VALUES
(1, '01310-100', 'Avenida Paulista', '1578', 'Apto 101', 'Bela Vista', 'São Paulo', 'SP', TRUE),
(2, '20040-020', 'Avenida Rio Branco', '156', 'Sala 502', 'Centro', 'Rio de Janeiro', 'RJ', TRUE),
(3, '30130-100', 'Avenida Afonso Pena', '867', 'Apto 203', 'Centro', 'Belo Horizonte', 'MG', TRUE),
(4, '80010-010', 'Rua XV de Novembro', '1299', NULL, 'Centro', 'Curitiba', 'PR', TRUE),
(5, '90010-150', 'Rua dos Andradas', '1234', 'Apto 302', 'Centro', 'Porto Alegre', 'RS', TRUE);

INSERT INTO CARRINHO (id_cliente) VALUES (1), (2), (3);

INSERT INTO ITEM_CARRINHO (id_carrinho, id_livro, quantidade, preco_unitario) VALUES
(1, 3, 1, 49.90),
(1, 6, 1, 89.90),
(2, 1, 2, 35.90),
(3, 4, 1, 44.90);

INSERT INTO PEDIDO (id_cliente, id_endereco, valor_total, status) VALUES
(1, 1, 139.80, 'Entregue'),
(2, 2, 71.80, 'Enviado'),
(4, 4, 49.90, 'Pagamento Confirmado');

INSERT INTO ITEM_PEDIDO (id_pedido, id_livro, quantidade, preco_unitario, subtotal) VALUES
(1, 3, 1, 49.90, 49.90),
(1, 6, 1, 89.90, 89.90),
(2, 1, 2, 35.90, 71.80),
(3, 3, 1, 49.90, 49.90);

INSERT INTO PAGAMENTO (id_pedido, forma_pagamento, status_pagamento, valor_pago, data_pagamento) VALUES
(1, 'Cartão de Crédito', 'Aprovado', 139.80, '2026-05-15 14:30:00'),
(2, 'PIX', 'Aprovado', 71.80, '2026-05-16 10:15:00'),
(3, 'Boleto', 'Aprovado', 49.90, '2026-05-17 09:00:00');

INSERT INTO AVALIACAO (id_cliente, id_livro, nota, comentario) VALUES
(1, 3, 5, 'Livro incrível! Meu filho adorou!'),
(1, 6, 5, 'Essencial para todo programador.'),
(2, 1, 4, 'Clássico da literatura brasileira, muito bom!'),
(4, 3, 5, 'Harry Potter é sempre mágico!');

-- Exemplos de consultas

SELECT L.titulo, L.preco, L.estoque, C.nome_categoria
FROM LIVRO L
INNER JOIN CATEGORIA C ON L.id_categoria = C.id_categoria
ORDER BY L.titulo;

SELECT L.titulo, A.nome_autor, L.preco
FROM LIVRO L
INNER JOIN LIVRO_AUTOR LA ON L.id_livro = LA.id_livro
INNER JOIN AUTOR A ON LA.id_autor = A.id_autor
ORDER BY L.titulo;

SELECT P.id_pedido, C.nome, P.data_pedido, P.valor_total, P.status
FROM PEDIDO P
INNER JOIN CLIENTE C ON P.id_cliente = C.id_cliente
ORDER BY P.data_pedido DESC;

SELECT L.titulo, SUM(IP.quantidade) AS total_vendido
FROM LIVRO L
INNER JOIN ITEM_PEDIDO IP ON L.id_livro = IP.id_livro
GROUP BY L.id_livro, L.titulo
ORDER BY total_vendido DESC;

SELECT L.titulo, COUNT(A.id_avaliacao) AS total_avaliacoes, AVG(A.nota) AS media_notas
FROM LIVRO L
LEFT JOIN AVALIACAO A ON L.id_livro = A.id_livro
GROUP BY L.id_livro, L.titulo
HAVING total_avaliacoes > 0
ORDER BY media_notas DESC;
