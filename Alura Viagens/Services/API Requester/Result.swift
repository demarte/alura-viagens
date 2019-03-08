//
//  Result.swift
//  Alura Viagens
//
//  Created by Ivan De Martino on 3/6/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import Foundation

enum Result<Value> {
  case success(Value)
  case failure(Error)
}
