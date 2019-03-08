//
//  Viagem.swift
//  Alura Viagens
//
//  Created by Alura on 21/06/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import UIKit

struct Viagem: Codable {

  let id: Int
  let titulo: String
  let quantidadeDeDias: Int
  let preco: String
  let caminhoDaImagem: String
  let localizacao: String

  enum CodingKeys: String, CodingKey {
    case id, titulo, quantidadeDeDias, preco, localizacao
    case caminhoDaImagem = "imageUrl"
  }
}
