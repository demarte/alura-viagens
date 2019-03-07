//
//  APIRequester.swift
//  Alura Viagens
//
//  Created by Ivan De Martino on 3/6/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import Foundation

struct APIRequester<Endpoint: EndpointType> {

  func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T>) -> Void) {

    var request = create(endpoint)

    endpoint.headers?.forEach({ (key, value) in
      request.addValue(value, forHTTPHeaderField: key)
    })

    URLSession.shared.dataTask(with: request) { (data, response, error) in
      guard let response = response, let data = data
        else {
          completion(Result.failure(APIRequesterError.noData))
          return
      }

      guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode
        else {
          completion(Result.failure(APIRequesterError.invalidResponse))
          return
      }

      do {
        let parsedObject = try JSONDecoder().decode(T.self, from: data)
        completion(Result.success(parsedObject))
      } catch {
        completion(Result.failure(error))
      }
    }.resume()

  }
  //Cria uma request com base no endpoint generico
  private func create(_ endpoint: Endpoint) -> URLRequest {

    if let request = endpoint.request { return request }

    let url: URL = {
      if endpoint.path.isEmpty {
        return endpoint.baseURL
      } else {
        return endpoint.baseURL.appendingPathComponent(endpoint.path)
      }
    }()

    var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)

    if endpoint.method == .get {
      let queryItems = endpoint.parameters?.compactMap { URLQueryItem(name: $0.key, value: $0.value) } ?? []
      urlComponents?.queryItems = queryItems
    }

    var request = URLRequest(url: urlComponents?.url ?? url)
    request.httpMethod = endpoint.method.rawValue

    if endpoint.method != .get {
      let dataParam = try? JSONSerialization.data(withJSONObject: endpoint.parameters ?? [], options: [])
      request.httpBody = dataParam
    }
    return request
  }
}
