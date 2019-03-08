//
//  EndpointType.swift
//  Alura Viagens
//
//  Created by Ivan De Martino on 3/6/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import Foundation

protocol EndpointType {
  var request: URLRequest? { get }
  var baseURL: URL { get }
  var path: String { get }
  var method: Method { get }
  var headers: [String: String]? { get }
  var parameters: [String: String]? { get }
}

extension EndpointType {
  var headers: [String: String]? {
    return nil
  }
  var baseURL: URL {
    return Constants.baseURL
  }
  var request: URLRequest? {
    return nil
  }
}
