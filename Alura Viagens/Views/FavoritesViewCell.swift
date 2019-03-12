//
//  FavoritesViewCell.swift
//  Alura Viagens
//
//  Created by Ivan De Martino on 3/11/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit

class FavoritesViewCell: UICollectionViewCell {

  // MARK: - IBOutlets

  @IBOutlet weak var imagemViagem: UIImageView!
  @IBOutlet weak var labelTitulo: UILabel!
  @IBOutlet weak var labelQuantidadeDias: UILabel!
  @IBOutlet weak var labelPreco: UILabel!

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
    APIViagensService().requestImage(string: pacoteViagem.caminhoDaImagem) { (result) in
      if let image = result {
        self.imagemViagem.image = image
      }
    }
  }
}
