//
//  MapaViewController.swift
//  Alura Viagens
//
//  Created by Ivan De Martino on 3/8/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

  // MARK: - IBOutlets

  @IBOutlet weak var map: MKMapView!

  var selectedLocation: String?

  override func viewDidLoad() {
    super.viewDidLoad()
    configureLocation()
  }

  // MARK: - metodos

  private func configurePoint(address: String, location: CLPlacemark) -> MKPointAnnotation {
    let point = MKPointAnnotation()
    point.title = address
    point.coordinate = location.location!.coordinate
    return point
  }

  private func configureLocation() {

    if let location = selectedLocation {
      LocationService().fetchLocationByAddress(location) { (foundLocation) in

        guard let lat = foundLocation.location?.coordinate.latitude else { return }
        guard let long = foundLocation.location?.coordinate.longitude else { return }
        let point = self.configurePoint(address: location, location: foundLocation)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: long), latitudinalMeters: 5000, longitudinalMeters: 5000)
        self.map.setRegion(region, animated: true)
        self.map.addAnnotation(point)
      }
    }
  }

  //MARK: - IBActions

  @IBAction func botaoVoltar(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }
}
