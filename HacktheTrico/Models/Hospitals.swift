//
//  Hospitals.swift
//  HacktheTrico
//
//  Created by Cassandra Stone on 3/25/17.
//  Copyright © 2017 Cassandra Stone. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Hospitals: Object{
    dynamic var drg_definition = ""
    dynamic var provider_id: String = ""
    dynamic var provider_name: String = ""
    dynamic var provider_street_address: String = ""
    dynamic var provider_city: String = ""
    dynamic var provider_zip_code: String = ""
    dynamic var hospital_referral_region_description: String = ""
    dynamic var total_discharger: String = ""
    dynamic var average_covered_charges: String = ""
    dynamic var average_medicare_payment: String = ""
    dynamic var average_medicare_payments_2: String = ""
    
    convenience init(json:JSON){
        self.init()
        self.drg_definition = json["drg_definition"].stringValue
        self.provider_id = json["provider_id"].stringValue
        self.provider_name = json["provider_name"].stringValue
        self.provider_street_address = json["provider_street_address"].stringValue
        self.provider_city = json["provider_city"].stringValue
        self.provider_zip_code = json["provider_zip_code"].stringValue
        self.hospital_referral_region_description = json["hospital_referral_region_description"].stringValue
        self.average_covered_charges = json["average_covered_charges"].stringValue
        self.average_medicare_payment = json["average_medicare_payment"].stringValue
        self.average_medicare_payments_2 = json["average_medicare_payments_2"].stringValue
    }
}
