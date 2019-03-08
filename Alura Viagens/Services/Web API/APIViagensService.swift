//
//  APIRequestService.swift
//  Alura Viagens
//
//  Created by Ivan De Martino on 3/6/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

struct APIViagensService {
  let apiRequester = APIRequester<ViagensEndpoint>()

  func fetchViagens(completion: @escaping ((Result<[Viagem]>) -> Void)) {
    apiRequester.request(ViagensEndpoint.fetchViagens(), completion: completion)
  }

  func fetchPacotesViagens(completion: @escaping ((Result<[PacoteViagem]>) -> Void)) {
    apiRequester.request(ViagensEndpoint.fetchPacotes(), completion: completion)
  }
  
  func requestImage(string url: String, completion: @escaping (UIImage?) -> Void) {
    let urlComponets = url.components(separatedBy: "/")
    guard let imagePath = urlComponets.last else { return }
    let fullImagePath = Constants.baseImageURL + imagePath

    Alamofire.request(fullImagePath).responseImage { response in
      if let image = response.result.value {
        completion(image)
      } else {
        completion(nil)
      }
    }
  }
}
