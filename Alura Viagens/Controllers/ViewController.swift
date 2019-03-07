//
//  ViewController.swift
//  Alura Viagens
//
//  Created by Alura on 21/06/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  // MARK: - IBOutlets

  @IBOutlet weak var tabelaViagens: UITableView!
  @IBOutlet weak var viewHoteis: UIView!
  @IBOutlet weak var viewPacotes: UIView!

  // MARK: - Atributos

  var listaViagens:[Viagem]?

  // MARK: - View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    configuraViews()
    fetchViagens()
  }

  // MARK: - Métodos

  private func configuraViews() {
    viewPacotes.layer.cornerRadius = 10
    viewHoteis.layer.cornerRadius = 10
  }

  private func fetchViagens() {
    APIViagensService().fetchViagens { (viagens) in
      switch viagens {
      case .success(let value):
        self.listaViagens = value
        DispatchQueue.main.async {
          self.tabelaViagens.reloadData()
        }
        break
      case .failure(_):
        break
      }
    }
  }

  // MARK: - UITableViewDataSource

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return listaViagens?.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
    if let viagens = listaViagens {
      let viagemAtual = viagens[indexPath.row]
      cell.configuraCelula(viagemAtual)
    }
    return cell
  }

  // MARK: - UITableViewDelegate

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? 175 : 260
  }
}
