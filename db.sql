CREATE TABLE client(
   id INT,
   nom VARCHAR(50) NOT NULL,
   prenom VARCHAR(50),
   adresse VARCHAR(50),
   code_postal INT,
   pays VARCHAR(50),
   telephone INT,
   email VARCHAR(50) NOT NULL,
   PRIMARY KEY(id)
);

CREATE TABLE article(
   id INT,
   code VARCHAR(50) NOT NULL,
   nom VARCHAR(50) NOT NULL,
   PRIMARY KEY(id),
   UNIQUE(code)
);

CREATE TABLE commande(
   id INT,
   numero VARCHAR(50) NOT NULL,
   date_ DATETIME NOT NULL,
   id_1 INT NOT NULL,
   PRIMARY KEY(id),
   UNIQUE(numero),
   FOREIGN KEY(id_1) REFERENCES client(id)
);

CREATE TABLE _Commande_concerne_un_article(
   id INT,
   id_1 INT,
   PRIMARY KEY(id, id_1),
   FOREIGN KEY(id) REFERENCES article(id),
   FOREIGN KEY(id_1) REFERENCES commande(id)
);
