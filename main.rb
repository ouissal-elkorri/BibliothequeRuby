require 'csv' #pour generer les fichier CSV

$LOAD_PATH.unshift(__dir__)
require 'class.rb'

#---------------------------------------------------------------
#                          MAIN
#---------------------------------------------------------------

Bib = Library.new
fin = false

while !fin

  print (
    "
  --------Bienvenue dans notre bibliothèque avancée--------

  Veuillez selectionner l'action que vous voulez effectuer?

  1) Crée un adhérent et l'ajoute à la bibliothèque
  2) Crée un livre et l'ajoute à la bibliothèque
  3) Crée un ordinateur portable et l'ajoute à la bibliothèque
  4) Retourne un adhèrent correspondant à un id de personne
  5) Retourne un document correspondant à un ISBN
  6) Retourne un matériel correspondant à un id
  7) Retourne la collection des adhérents de la bibliothèque
  8) Retourne la liste des documents de la bibliothèque
  9) Retourne la collection des matériels de la bibliothèque
  10) Ajoute une personne aux auteurs d’un livre.
  11) Retourne un auteur d’un livre correspondant à un id
  12) Retourne L'ensemble des Ids des auteurs
  13) Retourne L'ensemble des Id des matériels
  14) Supprime un adhérent de la bibliothèque
  15) Supprime un matériel de la bibliothèque
  16) Supprime un document de la bibliothèque
  17) Emprunter un Ordinateur
  18) Emprunter un Livre
  19) Rendre un Ordinateur
  20) Rendre un Livre
  21) Enregistre la bibliothèque dans des fichiers CSV
  22) Charge la bibliothèque à partir des fichiers CSV
  23) Rechercher un mot et retourner tous les documents qui comportent la chaîne mot dans leur titre
  24) Quitter
    "
  )
  choice = gets.chomp.to_i

  case choice

  #Créer et ajouter un adhérent à la bibliothèque
  when 1
    puts("Entrer le prenom de l'adhérent: ")
    prenom = gets.chomp

    puts("Entrer le nom de l'adhérent: ")
    nom = gets.chomp

    puts "choisir le Statut de l'adhérent :
		1-Etudiant
		2-Enseignant"
    num=gets.chomp.to_i
		num==1 ? statut= Statut[0] : statut= Statut[1]

    a = Adherent.new(nom, prenom, statut)
    Bib.CreerAdherent(a)

    puts("L'dherent(e) #{prenom} #{nom} créé avec succès")

  #Créer et ajouter un livre à la bibliothèque
  when 2
    puts "Entrez le titre du livre"
    titre = gets.chomp
  	puts "choisir la disponiblité du livre :"
    puts "1-Disponible"
    puts "2-Non disponible"

    num = gets.chomp.to_i
    num==1 ? dispo=true  : dispo=false
    puts "Entrer l'auteur du livre :"
    auteur= gets.chomp
    Bib.AjouterAut(auteur)
    l = Livre.new(titre,auteur,dispo)
    Bib.AjouterDoc(l)

  #Créer et ajouter un ordinateur portable à la bibliothèque
  when 3
    puts "entrer la marque de l'ordinateur :"
		marque= gets.chomp

	  puts "choisir la disponibilité de l'ordinateur :"
    puts "1-Disponible"
    puts "2-Non diponible"
    num=gets.chomp.to_i
    num==1 ? dispo=true  : dispo=false

    puts "choisir la situation de l'ordinateur :"
    puts "1-En panne"
    puts "2-En marche"
    num2=gets.chomp.to_i
    num2==1 ? panne=true  : panne=false
    m = Pc.new(panne,marque,dispo)
    Bib.AjouterMat(m)

  #Retourner un adhérent
  when 4
    puts "Entrer l'id de l'adhérent"
		id=gets.chomp.to_i
    #exception
		begin
      puts Bib.RetourneAdherent(id)
    rescue  InconnuError => e
      puts e.message
    end

  when 5
    puts "Saisir l'ISBN du document"
	  id=gets.chomp.to_i
    #exception
    begin
      puts Bib.RetourneDocument(id)
		rescue  InconnuError => e
      puts e.message
    end

  when 6
    puts "Saisir l'id du Matériel"
    id=gets.chomp.to_i
    begin
      puts Bib.chercherMat(id)
    rescue  InconnuError => e
      puts e.message
    end

  when 7
    Bib.RetourneCollectionAdherents()

  when 8
    Bib.RetourneListeDocs()

  when 9
    Bib.RetourneCollectionMateriel()

  when 10
    puts "Saisir le nom de l'auteur:"
    auteur=gets.chomp
    Bib.AjouterAut(auteur)
    #Bib.AjoutePersAuxAteursLivre()

  when 11
    puts "Entrer l'id de l'auteur"
    id=gets.chomp.to_i
    begin
      puts Bib.chercherAut(id)
    rescue InconnuError => e
      puts e.message
    end

  when 12
    Bib.RetourneIdsAuteurs()

  when 13
    Bib.RetourneIdsMateriel()

  when 14
    puts "saisir l'id d'adhérent"
	  id=gets.chomp.to_i
    begin
      Bib.RetourneAdherent(id)
      Bib.SupprimeAdherent(id)
    rescue  InconnuError => e
      puts e.message
    end

  when 15
    puts "saisir l'ISBN du document"
    id=gets.chomp.to_i
    begin
      Bib.chercherDoc(id)
      Bib.SupprimeMateriel(id)
    rescue  InconnuError => e
      puts e.message
    end

  when 16
    puts "saisir l'id du Matériel"
    id=gets.chomp.to_i
    begin
      Bib.chercherMat(id)
      Bib.SupprimerAdh(id)
    rescue  InconnuError => e
      puts e.message
    end

  when 17
    puts "saisir l'id d'adhérent"
    id=gets.chomp.to_i
    begin
      a = Bib.RetourneAdherent(id)
      puts "saisir le titre du livre"
      titre = gets.chomp
      a.EmprunterLivre(Bib,titre)
    rescue  InconnuError => e
      puts e.message
    rescue DejaEmprunteError => d
      puts d.message
    end

  when 18
    puts "Saisir l'id d'adhérent"
    id=gets.chomp.to_i

    begin
      a=Bib.RetourneAdherent(id)
     	puts "saisir la marque de l'Ordinateur"
      marque=gets.chomp
      a.EmprunterOrdinateur(Bib,marque)
    rescue  InconnuError => e
      puts e.message
    rescue DejaEmprunteError => d
      puts d.message
    end

  when 19
    puts "Saisir l'id d'adhérent"
    id=gets.chomp.to_i
    begin
      a=Bib.RetourneAdherent(id)
 	    puts "Saisir le titre du livre"
      titre=gets.chomp
      a.RendreLivre(Bib,titre)
    rescue  InconnuError => e
      puts e.message
    end

  when 20
    puts "Saisir l'id d'adhérent"
    id=gets.chomp.to_i
    begin
      a=Bib.RetourneAdherent(id)
      puts "Saisir la marque de l'Ordinateur"
      marque = gets.chomp
      a.RendreOrdinateur(Bib,marque)
    rescue  InconnuError => e
      puts e.message
    end

  when 21
    puts Bib.EregistrerBibCSV()

  when 22
    Bib.ChargeBibCSV()

  when 23
    puts "Entrer un mot"
    mot = gets.chomp
    Bib.RechercherTitre(mot)

  when 24
    fin = true

  else
    puts "Vous devez choisir un nombre entre 1 et 23"
  end
end
