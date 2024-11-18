CREATE DATABASE farmacia;
USE farmacia;

CREATE TABLE usuarios(
    id_usuarios INT PRIMARY KEY AUTO_INCREMENT,
    nome_usuarios VARCHAR(100) NOT NULL,
    senha_usuario VARCHAR(50)
);

CREATE TABLE fornecedor(
    id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    usuario_fornecedor VARCHAR(200),
    email_fornecedor VARCHAR(100),
    telefone_fornecedor INT (11)
);

CREATE TABLE produto(
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR (150) NOT NULL,
    preço INT,
    descricao INT,
    fornecedor INT,
    FOREIGN KEY (fornecedor) REFERENCES fornecedor(id_fornecedor)
);

INSERT INTO usuarios(nome_usuarios, senha_usuario)
VALUES
('LCOMPARINI', 12345678),
('IPAIOLA', 87654321),
('YBORBA', 24681357)

INSERT INTO fornecedor(usuario_fornecedor, email_fornecedor, telefone_fornecedor)
VALUES
('LCOMPARINI','lucas.comparini@email', 11-234567890),
('IPAIOLA','isabela.paiola@email', 11-246803579),
('YBORBA','yasmin.borba@email', 11-098765432);

INSERT INTO produto(nome, preco, descricao, fornecedor)
VALUES
('Parecetamol',50.00,' dores',1),
('Buscofem',25.00,' colicas e dores de cabeça',2),
('Dramin',45.00,'enjoos',3);

DELIMITER $$

CREATE TRIGGER antes_deletar_fornecedor
BEFORE DELETE ON fornecedor
FOR EACH ROW
BEGIN
    -- Verifica se o fornecedor está associado a algum produto
    IF EXISTS (SELECT 1 FROM produto WHERE fornecedor = OLD.id_fornecedor) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Não é possível excluir o fornecedor porque ele possui produtos cadastrados.';
    END IF;
END$$

DELIMITER ;

DELETE FROM fornecedor WHERE id_fornecedor = 1;

