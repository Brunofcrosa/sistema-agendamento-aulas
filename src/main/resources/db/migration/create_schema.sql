CREATE TABLE usuario (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    email VARCHAR(160) NOT NULL UNIQUE,
    senha VARCHAR(120) NOT NULL,
    ativo BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE docente (
    id SERIAL PRIMARY KEY,
    matricula VARCHAR(60) NOT NULL UNIQUE,
    nome VARCHAR(120) NOT NULL
);

CREATE TABLE sala (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    bloco VARCHAR(80) NOT NULL,
    capacidade INTEGER NOT NULL CHECK (capacidade > 0),
    recursos VARCHAR(255),
    ativa BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE reserva (
    id SERIAL PRIMARY KEY,
    sala_id INTEGER NOT NULL REFERENCES sala(id),
    docente_id INTEGER NOT NULL REFERENCES docente(id),
    data_reserva DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fim TIME NOT NULL,
    finalidade VARCHAR(180) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'ATIVA',
    CHECK (hora_fim > hora_inicio)
);

CREATE INDEX idx_reserva_sala_data ON reserva (sala_id, data_reserva);
