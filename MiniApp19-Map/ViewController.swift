//
//  ViewController.swift
//  MiniApp19-Map
//
//  Created by 前田航汰 on 2022/02/28.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    var addressString = ""
    @IBOutlet weak var addressTextLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!

    @IBAction func tappedGesture(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            let location = mapView.convert(sender.location(in: view), toCoordinateFrom: mapView)
            convert(lat: location.latitude, log: location.longitude)
        }
    }

    func convert(lat: CLLocationDegrees, log: CLLocationDegrees){
        let geocorder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: log)

        geocorder.reverseGeocodeLocation(location) { (placeMarks, error) in
            if let placeMark = placeMarks?.first {
                self.addressString = """
                郵便番号：\(placeMark.postalCode ?? "検出不可")
                名前：\(placeMark.name ?? "検出不可")
                都道府県：\(placeMark.administrativeArea ?? "検出不可")
                市区町村：\(placeMark.locality ?? "検出不可")
            """
                self.addressTextLabel.text = self.addressString
            }
        }
    }

}

