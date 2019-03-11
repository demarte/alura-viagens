//
//  FavoritesViewController.swift
//  Alura Viagens
//
//  Created by Ivan De Martino on 3/9/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

  // MARK: - IBOutlets
  @IBOutlet weak var colecaoFavoritos: UICollectionView!

  // MARK: - Atributos

  var listaFavoritos: [PacoteViagem] = []
  let persistenceService = PersistenceService.shared

  override func viewWillAppear(_ animated: Bool) {
    fetchPacotes()
    colecaoFavoritos.reloadData()
  }

  private func fetchPacotes() {
    guard let pacotes = persistenceService.fetch(Pacote.self) else { return }
    listaFavoritos = PacoteViagem.convertArrayOfManagedObject(pacotes)
  }

  // MARK: - UICollectionViewDelegate

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return listaFavoritos.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let celulaPacote = collectionView.dequeueReusableCell(withReuseIdentifier: "celulaPacote", for: indexPath) as! PacotesCollectionViewCell
    let pacoteAtual = listaFavoritos[indexPath.item]
    celulaPacote.configuraCelula(pacoteAtual)
    return celulaPacote
  }

  // MARK: - UICollectionViewDelegate

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let pacote = listaFavoritos[indexPath.item]
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let controller = storyboard.instantiateViewController(withIdentifier: "detalhes") as! DetalhesViagemViewController
    controller.pacoteSelecionado = pacote
    navigationController?.pushViewController(controller, animated: true)
  }

  // MARK: - UICollectionViewLayout

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return UIDevice.current.userInterfaceIdiom == .phone ? CGSize(width: collectionView.bounds.width/2-20, height: 160) : CGSize(width: collectionView.bounds.width/3-20, height: 250)
  }
}
