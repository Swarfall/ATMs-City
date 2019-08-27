//
//  ATMsViewController.swift
//  City ATMs
//
//  Created by admin on 8/19/19.
//  Copyright © 2019 Viacheslav Savitsky. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import RealmSwift

class ATMsViewController: UIViewController {
    
    @IBOutlet weak var countFavoritesATMsLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var atmModel: [ATMModel] = []
    var atmModelMappable: [ATMModelMappable] = []
    var atmModelDevicesMappable: [ATMModelDevicesMappable] = []
    var atmFavorites: [ATMModel] = []
    var atmFavotitesRealm: [ATMModelRealm] = []
    let requestModel = AlamofireURLRequestParameters()
    var atmModelFiltered: [ATMModel] = []
    var filtered: Bool = false
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        tableView.register(UINib(nibName: "ATMsCell", bundle: nil), forCellReuseIdentifier: "ATMsCell")
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        getDataATMs()
        countFavoritesATMsLabel.text = "\(atmFavorites.count)"
        countFavoritesATMsLabel.layer.cornerRadius = 10
        countFavoritesATMsLabel.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        readWithRealm()
        countFavoritesATMsLabel.text = "\(atmFavorites.count)"

    }
    
    @IBAction func didTapGoToPopVC(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapGoToFavoriteVC(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FavoritesViewController") as! FavoritesViewController
        vc.atmsList = atmFavorites
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func saveToRealm() {
        try! realm.write {
            realm.deleteAll()
        }
        for atm in atmFavorites {
            let realmModel = ATMModelRealm()
            realmModel.place = atm.place
            realmModel.fullAddress = atm.fullAddress
            realmModel.lat = atm.lat
            realmModel.long = atm.long
            realmModel.mon = atm.mon
            realmModel.tue = atm.tue
            realmModel.wed = atm.wed
            realmModel.thu = atm.thu
            realmModel.fri = atm.fri
            realmModel.sat = atm.sat
            realmModel.sun = atm.sun
            atmFavotitesRealm.append(realmModel)
        }
        try! self.realm.write {
            self.realm.create(ATMModelRealm.self)
        }
    }
    
    func readWithRealm() {
        let atmsRealm = self.realm.objects(ATMModelRealm.self)
        for realm in atmsRealm {
            let atm = ATMModel()
            atm.place = realm.place
            atm.fullAddress = realm.fullAddress
            atm.lat = realm.lat
            atm.long = realm.long
            atm.mon = realm.mon
            atm.tue = realm.tue
            atm.wed = realm.wed
            atm.thu = realm.thu
            atm.fri = realm.fri
            atm.sat = realm.sat
            atm.sun = realm.sun
            atmFavorites.append(atm)
        }
        tableView.reloadData()
    }
    
    func clearRealm() {
        try! realm.write {
        realm.deleteAll()
        }
    }
    
    func getDataATMs() {
        var parameters: [String: Any] = [:]
        parameters["city"] = requestModel.city
        Alamofire.request(requestModel.url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            let atm = Mapper<ATMModelMappable>().map(JSONObject: response.result.value)
            if let devices = atm?.devices {
                
                self.atmModelDevicesMappable = devices
                for ATMs in self.atmModelDevicesMappable {
                    let atmData = ATMModel()
                    atmData.fullAddress = ATMs.fullAddress
                    atmData.place = ATMs.place
                    atmData.lat = ATMs.lat
                    atmData.long = ATMs.long
                    atmData.mon = ATMs.mon
                    atmData.tue = ATMs.tue
                    atmData.wed = ATMs.wed
                    atmData.thu = ATMs.thu
                    atmData.fri = ATMs.fri
                    atmData.sat = ATMs.sat
                    atmData.sun = ATMs.sun
                    self.atmModel.append(atmData)
                }
                self.tableView.reloadData()
            }
        }
    }
}

extension ATMsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filtered {
            return atmModelFiltered.count
        } else {
            return atmModel.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ATMsCell", for: indexPath) as! ATMsCell
        cell.index = indexPath.row
        cell.delegate = self
        
        if filtered {
            cell.update(type: atmModelFiltered[indexPath.row])
        } else {
            cell.update(type: atmModel[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.atmModel = atmModel[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ATMsViewController: ATMsCellDelegate {
    
    func toFavouriteList(index: Int) {
        if filtered {
            atmFavorites.append(atmModelFiltered[index])
            saveToRealm()
            countFavoritesATMsLabel.text = "\(atmFavorites.count)"
        } else {
            atmFavorites.append(atmModel[index])
            saveToRealm()
            countFavoritesATMsLabel.text = "\(atmFavorites.count)"
        }
    }
}

extension ATMsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 1 {
            filtered = true
            atmModelFiltered = atmModel.filter({$0.fullAddress?.lowercased().contains(searchText.lowercased()) ?? false})
            tableView.reloadData()
        } else {
            filtered = false
            tableView.reloadData()
        }
    }
}
