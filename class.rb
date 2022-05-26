=begin
L’objectif est d’implémenter un programme en Ruby de gestion d’une bibliothèque.
- Une bibliothèque permet de créer des ressources (Documents, Adhérents, Matériels) et les emprunts.
- Les adhérents doivent avoir un nom et un prénom
- Les documents peuvent être des livres, des revues, des dictionnaires et des BD
- Le matériel empruntable est de type ordinateur portable
- Un adhèrent peut emprunter au plus cinq livres mais un seul ordinateur portable
=end
Statut=["Etudiant","Enseignant"] #Statur de l'adhérent

module Empruntable
  attr_accessor :disponible
  def Dispo?
    disponible ? true : false
  end
end

#---------------------------------------------------------------
#                          LA CLASSE BIBLIOTHQUE
#---------------------------------------------------------------

class Library
  #initialisation des données qu'on pourra lire et modifier
  attr_accessor :listAdh, :listMat, :listDoc, :listEmpr, :listAut
  def initialize
    @listAdh  = []
    @listMat  = []
    @listDoc  = []
    @listEmpr = []
    @listAut  = []
  end

  #-------CREATION ET AJOUT--------

  #Créer un adhérent et l'Ajouter à la bibliothèque
  def CreerAdherent(adhr)
    @listAdh.push(adhr)
  end

  #Ajouter un materiel
  def AjouterMat(mat)
    @listMat.push(mat)
  end

  #Ajouter un document
  def AjouterDoc(doc)
    @listDoc.push(doc)
  end

  #Ajouter un document
  def AjouterEmpr(empr, adhr)
    @listEmpr.push(empr)
  end

  #Ajouter un document
  def AjouterAut(aut)
    @listAut.push(aut)
  end

  #---------------------
  #Retourne un adhérent
  def RetourneAdherent(idAdherent)
    for i in 0..listAdh.length-1
      if i==idAdherent
        return listAdh[i]
      end
    end

    raise(InconnuError, "L'adhérent est inconnu")
  end

  #Retourne un document correspondant à un ISBN
  def RetourneDocument(isbn)
    for i in 0..listDoc.length-1
      if i==isbn
        return listDoc[i]
      end
    end
    raise(InconnuError, "Le document est inconnu")
  end

  #Retourne un matériel correspondant à un id
  def RetourneMateriel(idMateriel)
    for i in 0..listMat.length-1
      if i==idMateriel
        return listMat[i]
      end
    end
    raise(InconnuError, "Le matériel est inconnu")
  end

  #Retourne la collection des adhérents de la bibliothèque
  def RetourneCollectionAdherents()
     @listAdh.each{ |adh| puts "Adhérent : "+adh.afficher}
  end

  #Retourne la liste des documents de la bibliothèque
  def RetourneListeDocs()
     @listDoc.each{ |doc| puts  "Document : "+doc.afficher}
  end

  #Retourne la collection des matériels de la bibliothèque
  def RetourneCollectionMateriel()
     @listMat.each{ |mat| puts  "Matériel : "+doc.afficher}
  end

  #Ajoute une personne aux auteurs d’un livre.
  def AjoutePersAuxAteursLivre()

  end

  #Retourne un auteur d’un livre correspondant à un id
  def RetourneAuteurLivre(idLivre)

  end

  #Retourne L'ensemble des Ids des auteurs
  def RetourneIdsAuteurs()
    for i in 0..listAut.length-1
			puts "#{listAut[i]} => #{i}"
		end
  end

  #Retourne L'ensemble des Id des matériels
  def RetourneIdsMateriel()
    for i in 0..listMat.length-1
			puts "#{listMat[i]} => #{i}"
		end
  end

  #chercher Livre
  def chercherLivre(titre)
    for i in 0..listDoc.length-1
      if(listDoc[i].kind_of?(Livre) and listDoc[i].titre.eql?titre)
        return listDoc[i]
      end
    end
    #Si le titre est inconnu
    raise(InconnuError, "Le livre est inconnu")
  end

  #chercher Ordinateur
  def chercherOrdinateur(marque)
    for i in 0..listMat.length-1
      if(listMat[i].marque.eql?marque)
        return listMat[i]
      end
    end
    #Si le titre est inconnu
    raise(InconnuError, "L'odinateur est inconnu")
  end

  #chercher auteur
  def chercherAut(id)
    for i in 0..listAut.length-1
			if i==id
        return  listAut[i]
			end
		end
	  raise(InconnuError,"l'auteur est inconnu")
  end

  #Supprime un adhérent de la bibliothèque
  def SupprimeAdherent(id)
    @listAdh.each_index{
     |index|
      if index==id then listAdh.delete_at(index)
      end
    }
  end

  #Supprime un matériel de la bibliothèque
  def SupprimeMateriel()
    @listMat.each_index{
     	|index|
     	 if index==id then listAdh.delete_at(index)
     	 end
     	}
  end

  #Supprime un document de la bibliothèque
  def SupprimeDoc()
    @listDoc.each_index{
     	|index|
     	 if index==id then listAdh.delete_at(index)
     	 end
     	}
  end

  #Charge la bibliothèque à partir des fichiers CSV
  def ChargeBibCSV()

    #chargrer un Adherent
    adh = CSV.read('Adherents.csv')
    adh.each do |x|
      nom,prenom,statut = x.join(";").split(/;/)
      a= Adherent.new(nom,prenom,statut)
      CreerAdherent(a) #creer l'adhérent et l'ajouter à la bibliotheque
    end
	  puts "adhérents ajoutés"

    #chargrer un matériel
	  mat = CSV.read('Materiel.csv')
	  mat.each do |x|
      etat,marque,disponible = x.join(";").split(/;/)
      etat == "panne" ? panne=true : panne=false
      disponible == "disponible" ? disponible=true : disponible=false
      o = Pc.new(panne,marque,disponible)
      AjouterMat(o)
	  end
	  puts "matériels ajoutés"

    #chargrer un document
	  doc = CSV.read('Documents.csv')
	  doc.each do |x|
      titre,auteur,disponible = x.join(";").split(/;/)
      disponible == "disponible" ? disponible=true : disponible=false
      l = Livre.new(titre,auteur,disponible)
      AjouterAut(auteur)
      AjouterDoc(l)
	  end
	  puts "livres ajoutés"

  end


  #Enregistre la bibliothèque dans des fichiers CSV
  def EregistrerBibCSV()

    #enregistrer un Adherent
    adh = listAdh
    CSV.open("outputAdherents.csv", "w") do |f|
      adh.each do |x|
        f << [x]
      end
    end

    #enregistrer un document
    doc = listDoc
    CSV.open("outputDocuments.csv", "w") do |f|
      doc.each do |x|
        f << [x]
      end
    end

    #enregistrer un matériel
    mat = listMat
    CSV.open("outputMateriels.csv", "w") do |f|
      mat.each do |x|
        f << [x]
      end
    end
  end

  #rechercherTitre(mot): retourne une collection contenant des références vers les documents qui comportent la chaîne mot dans leur titre.
  def RechercherTitre(mot)
    ref = [] #reference

    for i in 0..listDoc.length-1
			if(listDoc[i].titre.match(mot))
        ref.push(listDoc[i])
			end
		end

    frequence=Hash.new(0)
    ref.each do |mot|
      if !frequence[mot]
        frequence[mot]=1
      else
        frequence[mot]=frequence[mot]+1
      end
    end
    puts frequence.inspect

    # for i in 0..listDoc.length-1
		# 	if(listDoc[i].titre.match(mot))
    #     ref.push(listDoc[i])
		# 	end
		# end
    # if ref == []
    #   puts "On a rien trouvé"
    # else
    #   return ref
    # end
	end


  #---------EXCEPTIONS---------
  # begin
  #   # Any exceptions in here...
  #   1/0
  # rescue
  #   # ...will cause this code to run
  #   puts "Got an exception, but I'm responding intelligently!"
  #   #do_something_intelligent()
  # end
  class DejaEmprunteError < RuntimeError
  end

  class InconnuError < RuntimeError
  end

  class IndisponibleError < RuntimeError
  end

  class MaxAtteintError < RuntimeError
  end

  class PasEmpruntableError < RuntimeError
  end

end

#---------------------------------------------------------------
#                          LA CLASSE Adherent
#---------------------------------------------------------------
class Adherent
  #initialisation d'un Adherent
  attr_accessor :nom, :prenom, :statut, :listEmprAdhr
  def initialize(nom="unknown", prenom="unknown", statut="unknown")
    @nom          = nom
    @prenom       = prenom
    @statut       = statut
    @listEmprAdhr = []
  end

  def afficher
    @nom+" "+@prenom+"  "+@statut
  end

  #Rendre un Ordinateur
  def RendreOrdinateur(bib, marque)
    ordinateur = bib.chercherOrdinateur(marque)

    bib.listEmpr.each{
      |emp|
      if emp[0].eql?ordinateur then
        bib.listEmpr.delete(emp) #
      end
    }

    @listEmprAdhr.each{
      |emp|
      if emp[0].eql?ordinateur then
        bib.listEmprAdhr.delete(emp) #
      end
    }

    ordinateur.disponible = true
  end

  #Rendre un Livre
  def RendreLivre(bib,titre)
    livre = bib.chercherLivre(titre)

    bib.listEmpr.each{
      |emp|
      if emp[0].eql?livre then
        bib.listEmpr.delete(emp) #
      end
    }

    @listEmprAdhr.each{
      |emp|
      if emp[0].eql?livre then
        bib.listEmprAdhr.delete(emp) #
      end
    }

    livre.disponible = true
  end

  #verifier si le pc est déjà emprunté
  def pcDejaEmprunte?
		for i in 0..listEmprAdhr.length-1
			if(listEmprAdhr[i].kind_of?Pc)
				return true
			end
		end
		return false
  end

  #Emprunter un Ordinateur
  def EmprunterOrdinateur(bib, marque)
    if(listEmprAdhr.length<5 && !pcDejaEmprunte?) then
      if(bib.chercherOrdi(marque)) then
        pc=bib.chercherOrdi(marque)
        if(pc.disponible==true)then
          @listEmprAdhr.push(pc)
          bib.AjouterEmpr(pc, self)
					pc.disponible=false
        else
          raise(DejaEmprunteError,"le PC Portable que vous demandé est déja emprunté")
        end
      else
        raise(InconnuErrorError,"le PC Portable n'est pas dans notre bibliotheque")
      end
    else
      raise(DejaEmprunteError,"le pc est déja emprunté")
    end
  end

  #Emprunter un Livre
  def EmprunterLivre()
    if(listEmprAdhr.length<5) then
      if(bib.chercherLivre(titre)) then
        l=bib.chercherLivre(titre)
        if(l.disponible==true)then
          @listEmprAdhr.push(l)
          bib.AjouterEmpr(l,self)
          l.disponible=false
        else
          raise(DejaEmprunteError,"le livre est déja emprunté")
        end
      else
        raise(InconnuError,"le livre est inconnu")
      end
    else
      raise(MaxAtteintError,"vous avez dépasser les limites")
    end
  end

end

#---------------------------------------------------------------
#                          LA CLASSE MATERIEL
#---------------------------------------------------------------
class Materiel
  def initialize(panne=false) #expliquer ce panne??
		@panne=panne
	end
end

#---------------------------------------------------------------
#                          LA CLASSE DOCUMENT
#---------------------------------------------------------------
class Document
  attr_accessor :titre
	def initialize(titre="unknown")
	   @titre=titre
	end
end

#---------------------------------------------------------------
#                          LA CLASSE Volume
#---------------------------------------------------------------
class Volume < Document
  def initialize(titre="unknown",auteur="unknown")
	super(titre)
	 @auteur=auteur
	end
end

#---------------------------------------------------------------
#                          LA CLASSE Revue
#---------------------------------------------------------------
class Revue < Document
  def initialize(titre='Inconnu', numero=0)
  	super(titre)
  	@numero = numero
	end

	def afficher
   @titre + " " + @numero.to_s
  end
end

#---------------------------------------------------------------
#                          LA CLASSE Dictionnaire
#---------------------------------------------------------------
class Dictionnaire < Document
  def initialize(titre="unknown",theme="unknown")
	   super(titre)
	   @theme = theme
	end

	def afficher
    @titre + " " + @auteur + " " + @theme
  end
end

#---------------------------------------------------------------
#                          LA CLASSE BD
#---------------------------------------------------------------
class BandeDessine < Document
  def initialize(titre="unknown", dessinateur="unknown")
	   super(titre)
	    @dessinateur = dessinateur
	end

	def afficher
	   @titre + " " + @auteur + " " + @dessinateur
	end
end

#---------------------------------------------------------------
#                          LA CLASSE Pc
#---------------------------------------------------------------
class Pc < Materiel
  include Empruntable
  attr_accessor :marque
  def initialize(panne=false, marque="unknown", disponible=true)
    super(panne)
    @marque     = marque
    @disponible = disponible
  end

  def afficher
     @marque
  end
end

#---------------------------------------------------------------
#                          LA CLASSE Livre
#---------------------------------------------------------------
class Livre < Volume
  include Empruntable
	def initialize(titre="unknown", auteur="unknown", disponible=true)
  	super(titre, auteur)
  	@disponible = disponible
	end

	def afficher
    @titre + " " + @auteur + " " + @disponible.to_s
  end
end















# -------------------------------------------------------------------


# #Créer un livre
# def CreerLivre()
#
# end
#
# #Ajouter le livre à la bibliothèque
# def AjouterLivre()
#
# end
#
# #Créer un ordinateur portable
# def CreerPC()
#
# end
#
# #Ajouter l'ordinateur à la bibliothèque
# def AjouterPC()
#
# end
