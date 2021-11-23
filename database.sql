#------------------------------------------------------------
#        Script MySQL.
#------------------------------------------------------------


DROP TABLE IF EXISTS Objet;
DROP TABLE IF EXISTS possede;
DROP TABLE IF EXISTS Radio;
DROP TABLE IF EXISTS Role;
DROP TABLE IF EXISTS TypeObjet;
DROP TABLE IF EXISTS Achete;
DROP TABLE IF EXISTS Commentaire;
DROP TABLE IF EXISTS Ecoute;
DROP TABLE IF EXISTS est_un;
DROP TABLE IF EXISTS favoris;
DROP TABLE IF EXISTS Mood;
DROP TABLE IF EXISTS Utilisateur;


#------------------------------------------------------------
# Table: Utilisateur
#------------------------------------------------------------

CREATE TABLE Utilisateur(
        idUtilisateur Int  Auto_increment  NOT NULL ,
        pseudo        Varchar (50) NOT NULL ,
        mdpUti        Char (50) NOT NULL ,
        mail          Varchar (50) NOT NULL ,
        sexe          Varchar (30) NOT NULL ,
        niveauUti     Int NOT NULL DEFAULT 1,
        experience    Int NOT NULL DEFAULT 0,
        moodPoints    Int NOT NULL DEFAULT 0,
        photoProfil   Varchar (255) DEFAULT NULL ,
        banniere      Varchar (255) DEFAULT NULL
	,CONSTRAINT Utilisateur_PK PRIMARY KEY (idUtilisateur)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Radio
#------------------------------------------------------------

CREATE TABLE Radio(
        idRadio     Int  Auto_increment  NOT NULL ,
        nomRadio    Varchar (255) NOT NULL ,
        categorie   Varchar (30) NOT NULL ,
        enLigne     TinyINT NOT NULL ,
        photoRadio  Varchar (255) NOT NULL ,
        description Text NOT NULL ,
        url         Text NOT NULL ,
        slogan      Text NOT NULL
	,CONSTRAINT Radio_PK PRIMARY KEY (idRadio)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Commentaire
#------------------------------------------------------------

CREATE TABLE Commentaire(
        idCommentaire Int  Auto_increment  NOT NULL ,
        nbSignalement Int NOT NULL DEFAULT 0,
        contenu       Text NOT NULL ,
        date          Date NOT NULL ,
        idRadio       Int NOT NULL ,
        idUtilisateur Int NOT NULL
	,CONSTRAINT Commentaire_PK PRIMARY KEY (idCommentaire)

	,CONSTRAINT Commentaire_Radio_FK FOREIGN KEY (idRadio) REFERENCES Radio(idRadio)
	,CONSTRAINT Commentaire_Utilisateur0_FK FOREIGN KEY (idUtilisateur) REFERENCES Utilisateur(idUtilisateur)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Role
#------------------------------------------------------------

CREATE TABLE Role(
        idRole  Int  Auto_increment  NOT NULL ,
        nomRole Varchar (50) NOT NULL
	,CONSTRAINT Role_PK PRIMARY KEY (idRole)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: TypeObjet
#------------------------------------------------------------

CREATE TABLE TypeObjet(
        idType  Int  Auto_increment  NOT NULL ,
        nomType Varchar (50) NOT NULL
	,CONSTRAINT TypeObjet_PK PRIMARY KEY (idType)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Objet
#------------------------------------------------------------

CREATE TABLE Objet(
        idObjet       Int  Auto_increment  NOT NULL ,
        nomObjet      Varchar (30) NOT NULL ,
        prixObjet     Int NOT NULL ,
        photoObjet    Varchar (255) NOT NULL ,
        disponibilite TinyINT NOT NULL ,
        niveauObj     Int NOT NULL ,
        idType        Int NOT NULL
	,CONSTRAINT Objet_PK PRIMARY KEY (idObjet)

	,CONSTRAINT Objet_TypeObjet_FK FOREIGN KEY (idType) REFERENCES TypeObjet(idType)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Mood
#------------------------------------------------------------

CREATE TABLE Mood(
        idMood  Int  Auto_increment  NOT NULL ,
        idRadio Int NOT NULL ,
        humeur  Varchar (50) NOT NULL ,
        couleur Varchar (50) NOT NULL
	,CONSTRAINT Mood_PK PRIMARY KEY (idMood)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Ecoute
#------------------------------------------------------------

CREATE TABLE Ecoute(
        idUtilisateur  Int NOT NULL ,
        idRadio        Int NOT NULL ,
        derniereEcoute Datetime NOT NULL ,
        dureeEcoute    Datetime NOT NULL ,
        diffDuree      Int NOT NULL DEFAULT 0,
        premiereEcoute Datetime DEFAULT NULL,
        ecouteGlobal   Int NOT NULL DEFAULT 0
	,CONSTRAINT Ecoute_PK PRIMARY KEY (idUtilisateur,idRadio)

	,CONSTRAINT Ecoute_Utilisateur_FK FOREIGN KEY (idUtilisateur) REFERENCES Utilisateur(idUtilisateur)
	,CONSTRAINT Ecoute_Radio0_FK FOREIGN KEY (idRadio) REFERENCES Radio(idRadio)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Achète
#------------------------------------------------------------

CREATE TABLE Achete(
        idUtilisateur Int NOT NULL ,
        idObjet       Int NOT NULL
	,CONSTRAINT Achete_PK PRIMARY KEY (idUtilisateur,idObjet)

	,CONSTRAINT Achete_Utilisateur_FK FOREIGN KEY (idUtilisateur) REFERENCES Utilisateur(idUtilisateur)
	,CONSTRAINT Achete_Objet0_FK FOREIGN KEY (idObjet) REFERENCES Objet(idObjet)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: est_un
#------------------------------------------------------------

CREATE TABLE est_un(
        idUtilisateur Int NOT NULL ,
        idRole        Int NOT NULL
	,CONSTRAINT est_un_PK PRIMARY KEY (idUtilisateur,idRole)

	,CONSTRAINT est_un_Utilisateur_FK FOREIGN KEY (idUtilisateur) REFERENCES Utilisateur(idUtilisateur)
	,CONSTRAINT est_un_Role0_FK FOREIGN KEY (idRole) REFERENCES Role(idRole)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: favoris
#------------------------------------------------------------

CREATE TABLE favoris(
        idRadio       Int NOT NULL ,
        idUtilisateur Int NOT NULL
	,CONSTRAINT favoris_PK PRIMARY KEY (idRadio,idUtilisateur)

	,CONSTRAINT favoris_Radio_FK FOREIGN KEY (idRadio) REFERENCES Radio(idRadio)
	,CONSTRAINT favoris_Utilisateur0_FK FOREIGN KEY (idUtilisateur) REFERENCES Utilisateur(idUtilisateur)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: possede
#------------------------------------------------------------

CREATE TABLE possede(
        idUtilisateur Int NOT NULL ,
        idMood        Int NOT NULL
	,CONSTRAINT possede_PK PRIMARY KEY (idUtilisateur,idMood)

	,CONSTRAINT possede_Utilisateur_FK FOREIGN KEY (idUtilisateur) REFERENCES Utilisateur(idUtilisateur)
	,CONSTRAINT possede_Mood0_FK FOREIGN KEY (idMood) REFERENCES Mood(idMood)
)ENGINE=InnoDB;



