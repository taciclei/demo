# language: fr
Fonctionnalité:
  Scénario: Appel une page qui existe pas
    Étant donné j'ajoute l'entête "Content-Type" égale à "application/json"
    Quand j'envoie une requête GET sur "/api/v1/not-found-route"
    Alors le code de status de la réponse devrait être 404

  Scénario: test ConstraintViolationList
    Étant donné j'ajoute l'entête "Content-Type" égale à "application/json"
    Et j'ajoute l'entête "Accept" égale à "application/ld+json"
    Quand j'envoie une requête POST sur "/books" avec le contenu :
"""
{
  "isbn": "plop",
  "title": "Clean Code",
  "description": "A Handbook of Agile Software Craftsmanship",
  "author": "Robert C. Martin",
  "publicationDate": "2008-08-01T23:11:31",
  "cover": "https://productimages.worldofbooks.com/0132350882.jpg"
}
"""
    Et l'entête "Content-Type" devrait contenir "application/ld+json; charset=utf-8"
    Alors le code de status de la réponse devrait être 400
    Et les nœuds JSON devraient être égaux à:
    | hydra:description | isbn: This value is neither a valid ISBN-10 nor a valid ISBN-13.|

  Scénario: Ajout d'un livre
    Étant donné j'ajoute l'entête "Content-Type" égale à "application/json"
    Et j'ajoute l'entête "Accept" égale à "application/ld+json"
    Quand j'envoie une requête POST sur "/books" avec le contenu :
"""
{
  "isbn": "9780132350884",
  "title": "Clean Code",
  "description": "A Handbook of Agile Software Craftsmanship",
  "author": "Robert C. Martin",
  "publicationDate": "2008-08-01T23:11:31",
  "cover": "https://productimages.worldofbooks.com/0132350882.jpg"
}
"""
    Et l'entête "Content-Type" devrait contenir "application/ld+json; charset=utf-8"
    Et imprimer la dernière réponse JSON
    Alors le code de status de la réponse devrait être 201
    Et les nœuds JSON devraient être égaux à:
      | isbn   | 9780132350884    |
      | title  | Clean Code       |
      | author | Robert C. Martin |

  Scénario: Mise a jour du livre qui vient d'etre creer
    Étant donné j'ajoute l'entête "Content-Type" égale à "application/json"
    Et j'ajoute l'entête "Accept" égale à "application/ld+json"
    Et I send a "PUT" project request to "$id" where id is "@id" from last request with body:
"""
{
  "isbn": "232600227X",
  "title": "Coder proprement",
  "description": "Le point sur les pratiques pour nettoyer un code.",
  "author": "Robert C. Martin",
  "publicationDate": "2019-04-05T23:11:31",
  "cover": "https://static.fnac-static.com/multimedia/Images/FR/NR/73/22/a7/10953331/1540-1/tsp20190510112036/Coder-proprement.jpg"
}
"""
    Alors le code de status de la réponse devrait être 200
    Et les nœuds JSON devraient être égaux à:
      | isbn   | 232600227X       |
      | title  | Coder proprement |
      | author | Robert C. Martin |

  Scénario: Recupere le dernier livre ajouter
    Étant donné j'ajoute l'entête "Content-Type" égale à "application/json"
    Et j'ajoute l'entête "Accept" égale à "application/ld+json"
    Et J'envoie une requete "GET" à "$id" où l'id est "@id" de la dernière requete
    Alors le code de status de la réponse devrait être 200
    Et imprimer la dernière réponse JSON

  Scénario: essaye de supprimer le dernier livre
    Étant donné j'ajoute l'entête "Content-Type" égale à "application/json"
    Et j'ajoute l'entête "Accept" égale à "application/ld+json"
    Et J'envoie une requete "DELETE" à "$id" où l'id est "@id" de la dernière requete
    Alors le code de status de la réponse devrait être 401
    Et imprimer la dernière réponse JSON
