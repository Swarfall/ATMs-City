//
//  DetailViewController.swift
//  City ATMs
//
//  Created by admin on 8/21/19.
//  Copyright © 2019 Viacheslav Savitsky. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class DetailViewController: UIViewController {

    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var fullAddressLabel: UILabel!
    @IBOutlet weak var monLabel: UILabel!
    @IBOutlet weak var tueLabel: UILabel!
    @IBOutlet weak var wedLabel: UILabel!
    @IBOutlet weak var thuLabel: UILabel!
    @IBOutlet weak var friLabel: UILabel!
    @IBOutlet weak var satLabel: UILabel!
    @IBOutlet weak var sunLabel: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    
    var locationManager = CLLocationManager()
    var atmModel = ATMModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.round(corners: [.topLeft, .topRight], radius: 25)
        updateDataMarkerLocation(lat: (atmModel.lat as! NSString).doubleValue, long: (atmModel.long as! NSString).doubleValue)
        putDataLabels()
    }
    
    func putDataLabels() {
        placeLabel.text = atmModel.place
        fullAddressLabel.text = atmModel.fullAddress
        monLabel.text = "Пн: \(atmModel.mon ?? "")"
        tueLabel.text = "Вт: \(atmModel.tue ?? "")"
        wedLabel.text = "Ср: \(atmModel.wed ?? "")"
        thuLabel.text = "Чт: \(atmModel.thu ?? "")"
        friLabel.text = "Пт: \(atmModel.fri ?? "")"
        satLabel.text = "Сб: \(atmModel.sat ?? "")"
        sunLabel.text = "Вс: \(atmModel.sun ?? "")"
    }
    
    @IBAction func didTapGoToPopVC(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension DetailViewController: GMSMapViewDelegate, CLLocationManagerDelegate {
    
    func setCurrentLocation() {
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func setMarker(long: CLLocationDegrees, lat: CLLocationDegrees) {
        let marker = GMSMarker()
        marker.icon = UIImage(named: "marker")
        marker.position.latitude = lat
        marker.position.longitude = long
        marker.map = mapView
    }
    
    func updateDataMarkerLocation(lat: Double, long: Double) {
        setMarker(long: long, lat: lat)
        setCurrentLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let camera = GMSCameraPosition.camera(withLatitude:(atmModel.lat as! NSString).doubleValue, longitude: (atmModel.long as! NSString).doubleValue, zoom: 17)
        self.mapView.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
    }
}
