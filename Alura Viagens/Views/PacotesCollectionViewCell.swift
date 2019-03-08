//
//  PacotesCollectionViewCell.swift
//  Alura Viagens
//
//  Created by Alura on 21/06/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import UIKit

class PacotesCollectionViewCell: UICollectionViewCell {

  // MARK: - IBOutlets

  @IBOutlet weak var imagemViagem: UIImageView!
  @IBOutlet weak var labelTitulo: UILabel!
  @IBOutlet weak var labelQuantidadeDias: UILabel!
  @IBOutlet weak var labelPreco: UILabel!

  let serviceAPI = APIViagensService()

  // MARK: - Métodos

  func configuraCelula(_ pacoteViagem: PacoteViagem) {
    labelTitulo.text = pacoteViagem.titulo
    labelQuantidadeDias.text = "\(pacoteViagem.quantidadeDeDias) dias"
    labelPreco.text = "R$ \(pacoteViagem.preco)"
    configuraImagem(pacoteViagem)

    layer.borderWidth = 0.5
    layer.borderColor = UIColor(red: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 1).cgColor
    layer.cornerRadius = 8
  }

  private func configuraImagem(_ pacoteViagem: PacoteViagem) {
    serviceAPI.requestImage(string: pacoteViagem.caminhoDaImagem) { (result) in
      if let image = result {
        self.imagemViagem.image = image
      }
    }
  }

}
