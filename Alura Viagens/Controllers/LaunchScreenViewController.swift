//
//  LaunchScreenViewController.swift
//  Alura Viagens
//
//  Created by Ivan De Martino on 4/25/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {

  // MARK - IBOutlets

  @IBOutlet weak var labelTopConstrant: NSLayoutConstraint!

  override func viewDidLoad() {
    super.viewDidLoad()
    animateLabel()
  }

  private func animateLabel() {
    UIView.animate(withDuration: 2.0, animations: {
      self.labelTopConstrant.constant = 330
      self.view.layoutIfNeeded()
    }) { (_) in
      self.showMainTabBarViewController()
    }
  }

  private func showMainTabBarViewController() {
    let tabBarViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")
    let navigation = UINavigationController(rootViewController: tabBarViewController)
    navigation.setNavigationBarHidden(true, animated: false)
    present(navigation, animated: true)
  }
}
