//
//  ATMModelMappable.swift
//  City ATMs
//
//  Created by admin on 8/19/19.
//  Copyright © 2019 Viacheslav Savitsky. All rights reserved.
//

import Foundation
import ObjectMapper

class ATMModelMappable: Mappable {
    
    var city: String?
    var address: String?
    var devices: [ATMModelDevicesMappable] = []
    
    required init?(map: Map) {
        do {
            self.city = try map.value("city")
        } catch {
            print("No city present")
        }
    }
    
    func mapping(map: Map) {
        address  <- map["address"]
        devices  <- map["devices"]
    }
}

class ATMModelDevicesMappable: Mappable {
    
    var fullAddress: String?
    var place: String?
    var lat: String?
    var long: String?
    var mon: String?
    var tue: String?
    var wed: String?
    var thu: String?
    var fri: String?
    var sat: String?
    var sun: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        fullAddress  <- map["fullAddressRu"]
        place        <- map["placeRu"]
        lat          <- map["latitude"]
        long         <- map["longitude"]
        mon          <- map["tw.mon"]
        tue          <- map["tw.tue"]
        wed          <- map["tw.wed"]
        thu          <- map["tw.thu"]
        fri          <- map["tw.fri"]
        sat          <- map["tw.sat"]
        sun          <- map["tw.sun"]
    }
}
