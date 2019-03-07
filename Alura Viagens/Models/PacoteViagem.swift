//
//  PacoteViagem.swift
//  Alura Viagens
//
//  Created by Alura on 21/06/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import UIKit

struct PacoteViagem: Codable {

  let id: Int
  let titulo: String
  let quantidadeDeDias: Int
  let preco: String
  let caminhoDaImagem: String
  let localizacao: String
  let nomeDoHotel: String
  let servico: String
  let dataViagem: String

  enum CodingKeys: String, CodingKey {
    case id, titulo, quantidadeDeDias, preco, localizacao, nomeDoHotel, servico
    case dataViagem = "data"
    case caminhoDaImagem = "imageUrl"
  }
}
