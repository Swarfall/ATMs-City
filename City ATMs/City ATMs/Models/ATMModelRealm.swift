//
//  ATMModelRealm.swift
//  City ATMs
//
//  Created by admin on 8/21/19.
//  Copyright © 2019 Viacheslav Savitsky. All rights reserved.
//

import Foundation
import RealmSwift

class ATMModelRealm: Object {
    
    @objc dynamic var place: String?
    @objc dynamic var fullAddress: String?
    @objc dynamic var lat: String?
    @objc dynamic var long: String?
    @objc dynamic var mon: String?
    @objc dynamic var tue: String?
    @objc dynamic var wed: String?
    @objc dynamic var thu: String?
    @objc dynamic var fri: String?
    @objc dynamic var sat: String?
    @objc dynamic var sun: String?
}
