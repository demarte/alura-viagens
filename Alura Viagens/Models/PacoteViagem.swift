//
//  PacoteViagem.swift
//  Alura Viagens
//
//  Created by Alura on 21/06/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import UIKit

struct PacoteViagem: Codable {

  let id: Int64
  let titulo: String
  let quantidadeDeDias: Int16
  let preco: String
  let caminhoDaImagem: String
  let localizacao: String
  let nomeDoHotel: String
  let servico: String
  let dataViagem: String
  var favorito = false

  static func convertArrayOfManagedObject(_ array: [Pacote]) -> [PacoteViagem] {
    var pacotesViagens: [PacoteViagem] = []
    array.forEach { (pacote) in
      let pacoteViagem = PacoteViagem(id: pacote.id,
                                      titulo: pacote.titulo,
                                      quantidadeDeDias: pacote.quantidadeDeDias,
                                      preco: pacote.preco,
                                      caminhoDaImagem: pacote.caminhoDaImagem,
                                      localizacao: "",
                                      nomeDoHotel: "",
                                      servico: pacote.servico,
                                      dataViagem: pacote.dataViagem,
                                      favorito: true)
      pacotesViagens.append(pacoteViagem)
    }
    return pacotesViagens
  }

  enum CodingKeys: String, CodingKey {
    case id, titulo, quantidadeDeDias, preco, localizacao, nomeDoHotel, servico
    case dataViagem = "data"
    case caminhoDaImagem = "imageUrl"
  }
}

extension PacoteViagem: Equatable {
  static func == (lhs: PacoteViagem, rhs: PacoteViagem) -> Bool{
    return lhs.id == rhs.id
  }
}
