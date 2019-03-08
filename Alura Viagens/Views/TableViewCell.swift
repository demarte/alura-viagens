//
//  TableViewCell.swift
//  Alura Viagens
//
//  Created by Alura on 21/06/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

  @IBOutlet weak var labelTitulo: UILabel!
  @IBOutlet weak var labelQuantidadeDias: UILabel!
  @IBOutlet weak var labelPreco: UILabel!
  @IBOutlet weak var imagemViagem: UIImageView!

  let serviceAPI = APIViagensService()

  func configuraCelula(_ viagem: Viagem) {
    labelTitulo.text = viagem.titulo
    labelQuantidadeDias.text = viagem.quantidadeDeDias == 1 ? "1 dia" : "\(viagem.quantidadeDeDias) dias"
    labelPreco.text = "R$ \(viagem.preco)"
    configuraImagem(viagem)
  }

  private func configuraImagem(_ viagem: Viagem) {
    serviceAPI.requestImage(string: viagem.caminhoDaImagem) { (result) in
      if let image = result {
        self.imagemViagem.image = image
        self.imagemViagem.layer.cornerRadius = 10
        self.imagemViagem.layer.masksToBounds = true
      }
    }
  }
}
