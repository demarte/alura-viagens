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

  var pacoteViagem: PacoteViagem?
  let persistenceService = PersistenceService.shared
  // MARK: - Métodos

  func configuraCelula(_ pacoteViagem: PacoteViagem) {
    self.pacoteViagem = pacoteViagem
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

  private func salvaPacote() {
    guard let pacoteViagem = pacoteViagem else { return }

    let pacote = Pacote(context: persistenceService.context)
    pacote.caminhoDaImagem = pacoteViagem.caminhoDaImagem
    pacote.preco = pacoteViagem.preco
    pacote.quantidadeDeDias = Int16(pacoteViagem.quantidadeDeDias)
    pacote.servico = pacoteViagem.servico
    pacote.titulo = pacoteViagem.titulo

    persistenceService.saveContext()
    
  }

  // MARK: - IBActions

  @IBAction func favorite(_ sender: UIButton) {
    pacoteViagem?.favorito.toggle()

    if let favorito = pacoteViagem?.favorito {
      if favorito {
        salvaPacote()
        sender.setImage(UIImage(named: "star_yellow"), for: .normal)
      } else {
        //deleta
        sender.setImage(UIImage(named: "star"), for: .normal)
      }
    }
  }
}
