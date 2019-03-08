//
//  LocationService.swift
//  Alura Viagens
//
//  Created by Ivan De Martino on 3/8/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import Foundation
import CoreLocation

final class LocationService {

  func fetchLocationByAddress(_ address: String, completion: @escaping (CLPlacemark) -> Void) {
    let converter = CLGeocoder()
    converter.geocodeAddressString(address) { (locations, _) in
      if let location = locations?.first {
        completion(location)
      }
    }
  }
}
