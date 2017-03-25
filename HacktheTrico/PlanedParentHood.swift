//
//  PlanedParentHood.swift
//  HacktheTrico
//
//  Created by Gabriel Quartey  on 3/25/17.
//  Copyright © 2017 Cassandra Stone. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class PlannedParenthood: Object{
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
    
    
}
