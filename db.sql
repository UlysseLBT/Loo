SET NAMES utf8mb4;
CREATE DATABASE IF NOT EXISTS commandes
  CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE commandes;

DROP TABLE IF EXISTS ligne_commande;
DROP TABLE IF EXISTS commande;
DROP TABLE IF EXISTS article;
DROP TABLE IF EXISTS client;

CREATE TABLE client (
  id           BIGINT PRIMARY KEY AUTO_INCREMENT,
  nom          VARCHAR(50)  NOT NULL,
  prenom       VARCHAR(50)  NOT NULL,
  adresse      VARCHAR(100),
  code_postal  VARCHAR(10),
  pays         VARCHAR(50),
  telephone    VARCHAR(20),
  email        VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE article (
  id          BIGINT PRIMARY KEY AUTO_INCREMENT,
  code        VARCHAR(50)  NOT NULL UNIQUE,
  nom         VARCHAR(100) NOT NULL,
  prix_ht     DECIMAL(10,2) NOT NULL DEFAULT 0,
  tva         DECIMAL(5,2)  NOT NULL DEFAULT 20.00,
  stock       INT NOT NULL DEFAULT 0
) ENGINE=InnoDB;

CREATE TABLE commande (
  id             BIGINT PRIMARY KEY AUTO_INCREMENT,
  numero         VARCHAR(50) NOT NULL UNIQUE,
  date_commande  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  client_id      BIGINT NOT NULL,
  CONSTRAINT fk_commande_client
    FOREIGN KEY (client_id) REFERENCES client(id)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE ligne_commande (
  commande_id    BIGINT NOT NULL,
  article_id     BIGINT NOT NULL,
  quantite       INT    NOT NULL,
  prix_unitaire  DECIMAL(10,2) NOT NULL,
  remise_pct     DECIMAL(5,2)  NOT NULL DEFAULT 0,
  PRIMARY KEY (commande_id, article_id),
  CONSTRAINT fk_lc_commande
    FOREIGN KEY (commande_id) REFERENCES commande(id)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_lc_article
    FOREIGN KEY (article_id) REFERENCES article(id)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- INDEX (équivalents à ceux que tu avais “inline”)
CREATE INDEX idx_client_nom           ON client(nom);
CREATE INDEX idx_client_prenom        ON client(prenom);
CREATE INDEX idx_client_email         ON client(email);
-- Pas besoin d’index supplémentaire sur email : UNIQUE crée déjà un index.

CREATE INDEX idx_article_prix_ht      ON article(prix_ht);

CREATE INDEX idx_commande_date        ON commande(date_commande);
CREATE INDEX idx_commande_client      ON commande(client_id);

-- La PK (commande_id, article_id) indexe déjà commande_id, mais on l’ajoute pour coller à ton ancien code
CREATE INDEX idx_lc_commande          ON ligne_commande(commande_id);
CREATE INDEX idx_lc_article           ON ligne_commande(article_id);
