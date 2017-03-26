//
//  PlannedParenthood.swift
//  HacktheTrico
//
//  Created by Cassandra Stone on 3/25/17.
//  Copyright © 2017 Cassandra Stone. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class PlannedParenthood: Object{
    dynamic var provider_name: String = ""
    dynamic var provider_street_address: String = ""
    dynamic var provider_zip_code: String = ""
    dynamic var telephone: String = ""
    
    convenience init(json:JSON){
        self.init()
        self.provider_name = json["provider_name"].stringValue
        self.provider_street_address = json["provider_street_address"].stringValue
        self.provider_zip_code = json["provider_zip_code"].stringValue
        self.telephone = json["services"]["providers"]["telephone"].stringValue
        
    }
}
