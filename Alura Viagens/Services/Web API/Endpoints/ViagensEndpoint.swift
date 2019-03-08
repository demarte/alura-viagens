//
//  ViagensEndpoint.swift
//  Alura Viagens
//
//  Created by Ivan De Martino on 3/6/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import Foundation

enum ViagensEndpoint {
  case fetchViagens()
  case fetchPacotes()
}

extension ViagensEndpoint: EndpointType {
  var path: String {
    switch self {
    case .fetchViagens():
      return "viagens"
    case .fetchPacotes():
      return "pacotes"
    }
  }

  var method: Method {
    return .get
  }

  var parameters: [String : String]? {
    return nil
  }

}
