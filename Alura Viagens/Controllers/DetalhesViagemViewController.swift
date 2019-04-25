//
//  DetalhesViagemViewController.swift
//  Alura Viagens
//
//  Created by Alura on 25/06/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import UIKit

class DetalhesViagemViewController: UIViewController {

  // MARK: - IBOutlets

  @IBOutlet weak var imagemPacoteViagem: UIImageView!
  @IBOutlet weak var labelTituloPacoteViagem: UILabel!
  @IBOutlet weak var labelDescricaoPacoteViagem: UILabel!
  @IBOutlet weak var labelQuantidadeDias: UILabel!
  @IBOutlet weak var labelDataViagem: UILabel!
  @IBOutlet weak var labelPrecoPacoteViagem: UILabel!
  @IBOutlet weak var scrollViewPrincipal: UIScrollView!
  @IBOutlet weak var textFieldData: UITextField!
  @IBOutlet weak var textFieldNumeroCartao: UITextField!
  @IBOutlet weak var textFieldNomeCartao: UITextField!
  @IBOutlet weak var textFieldSenhaCartao: UITextField!

  // MARK: - Atributos

  var pacoteSelecionado: PacoteViagem?

  // MARK: - View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    NotificationCenter.default.addObserver(self, selector: #selector(redimensionaScrollView(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(teste(_:)), name: UIResponder.keyboardDidHideNotification, object: self)
    configuraOutlets()
  }

  // MARK: - Metodos

  func configuraOutlets() {
    guard let pacote = pacoteSelecionado else { return }
    configuraImagem(pacote)
    labelTituloPacoteViagem.text = pacote.titulo
    labelDescricaoPacoteViagem.text = pacote.servico
    labelDataViagem.text = pacote.dataViagem
    labelPrecoPacoteViagem.text = pacote.preco
  }

  private func configuraImagem(_ pacote: PacoteViagem) {
    APIViagensService().requestImage(string: pacote.caminhoDaImagem) { (result) in
      if let image = result {
        self.imagemPacoteViagem.image = image
      }
    }
  }

  @objc func redimensionaScrollView(_ notification: Notification) {
    if let frameTeclado: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
      scrollViewPrincipal.contentSize = CGSize(width: scrollViewPrincipal.frame.width, height: scrollViewPrincipal.frame.height + frameTeclado.cgRectValue.height)
    }
  }

  @objc func teste(_ notification: Notification) {
    view.layoutIfNeeded()
  }

  @objc func exibeDataTextField(_ sender: UIDatePicker) {
    let formatador = DateFormatter()
    formatador.dateFormat = "dd MM yyyy"
    textFieldData.text = formatador.string(from: sender.date)
  }

  // MARK: - IBActions

  @IBAction func textFieldDataDidBegin(_ sender: UITextField) {
    let datePickerView = UIDatePicker()
    datePickerView.datePickerMode = .date
    sender.inputView = datePickerView
    datePickerView.addTarget(self, action: #selector(exibeDataTextField(_:)), for: .valueChanged)
  }

  @IBAction func botaoVoltar(_ sender: UIButton) {
    navigationController?.popViewController(animated: true)
  }

  @IBAction func botaoFinalizarCompra(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let controller = storyboard.instantiateViewController(withIdentifier: "confirmacaoPagamento") as! ConfirmacaoPagamentoViewController
    controller.pacoteComprado = pacoteSelecionado

    navigationController?.pushViewController(controller, animated: true)
  }
}
