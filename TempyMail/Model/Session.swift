//
//  Session.swift
//  TempyMail
//
//  Created by Abraham Estrada on 1/11/22.
//

import UIKit
import SwiftyJSON

struct Session {
    var sidToken: String
    var emailAddress: String
    var timestamp: Int
    
    init(data: JSON) {
        sidToken = data["sid_token"].stringValue
        emailAddress = data["email_addr"].stringValue
        timestamp = data["email_timestamp"].intValue
    }
}
