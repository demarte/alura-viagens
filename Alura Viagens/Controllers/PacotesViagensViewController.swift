//
//  PacotesViagensViewController.swift
//  Alura Viagens
//
//  Created by Alura on 25/06/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import UIKit

class PacotesViagensViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UISearchBarDelegate, UINavigationControllerDelegate {

  // MARK: - IBOutlets

  @IBOutlet weak var colecaoPacotesViagens: UICollectionView!
  @IBOutlet weak var pesquisarViagens: UISearchBar!
  @IBOutlet weak var labelContadorPacotes: UILabel!

  // MARK: - Atributos
  var listaComTodasViagens: [PacoteViagem] = []
  var listaViagens: [PacoteViagem] = []
  var listaFavoritos: [PacoteViagem] = []
  let persistenceService = PersistenceService.shared
  var pacoteSelecionado: PacoteViagem?
  var frameSelecionado: CGRect?

  // MARK: - View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.delegate = self
    pesquisarViagens.delegate = self
    fetchPacotesViagensAPI()
  }

  // MARK: - Métodos

  private func atualizaContadorLabel() -> String {
    return listaViagens.count == 1 ? "1 pacote encontrado" : "\(listaViagens.count) pacotes encontrados"
  }

  private func fetchPacotesViagensAPI() {
    APIViagensService().fetchPacotesViagens { (pacotes) in
      switch pacotes {
      case .success(let value):
        DispatchQueue.main.async {
          self.configuraColecaoDePacotes(value)
        }
        break
      case .failure(let error):
        print(error)
        break
      }
    }
  }

  private func fetchFavoritos() {
    guard let favoritos = persistenceService.fetch(Pacote.self) else { return }
    listaFavoritos = PacoteViagem.convertArrayOfManagedObject(favoritos)
  }

  private func configuraColecaoDePacotes(_ lista: [PacoteViagem]) {
    listaComTodasViagens = lista
    listaViagens = lista
    fetchFavoritos()
    colecaoPacotesViagens.reloadData()
    labelContadorPacotes.text = atualizaContadorLabel()
  }

  // MARK: - UISearchBarDelegate

  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    listaViagens = listaComTodasViagens
    if searchText != "" {
      listaViagens = listaViagens.filter({ $0.titulo.contains(searchText) })
    }
    labelContadorPacotes.text = atualizaContadorLabel()
    colecaoPacotesViagens.reloadData()
  }

  // MARK: - UICollectionViewDataSource

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return listaViagens.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let celulaPacote = collectionView.dequeueReusableCell(withReuseIdentifier: "celulaPacote", for: indexPath) as! PacotesCollectionViewCell
    var pacoteAtual = listaViagens[indexPath.item]
    if listaFavoritos.contains(pacoteAtual) {
      pacoteAtual.favorito = true
    }
    celulaPacote.configuraCelula(pacoteAtual)

    return celulaPacote
  }

  // MARK: - UICollectionViewDelegate

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let pacote = listaViagens[indexPath.item]
    pacoteSelecionado = pacote
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let controller = storyboard.instantiateViewController(withIdentifier: "detalhes") as! DetalhesViagemViewController
    controller.pacoteSelecionado = pacote

    let atributosItemSelecionado = collectionView.layoutAttributesForItem(at: indexPath)
    frameSelecionado = atributosItemSelecionado?.frame

    navigationController?.pushViewController(controller, animated: true)
  }

  // MARK: - UICollectionViewLayout

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return UIDevice.current.userInterfaceIdiom == .phone ? CGSize(width: collectionView.bounds.width/2-20, height: 160) : CGSize(width: collectionView.bounds.width/3-20, height: 250)
  }

  // MARK: - UINavigationControllerDelegate

  func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

    guard let caminhoDaImagem = pacoteSelecionado?.id else { return nil}
    guard let imagem = UIImage(named: "\(caminhoDaImagem)") else { return nil}
    guard let frameInicial =  frameSelecionado else { return nil }


    switch operation {
    case .push:
      return AnimacaoTransicaoPersonalizada(
        duracao: TimeInterval(UINavigationController.hideShowBarDuration),
        imagem: imagem,
        frameInicial: frameInicial,
        apresentarViewController: true)
      
    default:
      return AnimacaoTransicaoPersonalizada(
        duracao: TimeInterval(UINavigationController.hideShowBarDuration),
        imagem: imagem,
        frameInicial: frameInicial,
        apresentarViewController: false)
    }
  }
}
