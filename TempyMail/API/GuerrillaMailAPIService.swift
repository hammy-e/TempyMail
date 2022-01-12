//
//  GuerrillaMailAPIService.swift
//  TempyMail
//
//  Created by Abraham Estrada on 12/31/21.
//

import Foundation
import SwiftyJSON

protocol GuerrillaMailAPIServiceDelegate {
    func didStartSession(data: JSON)
}

struct GuerrillaMailAPIService {
    
    var delegate: GuerrillaMailAPIServiceDelegate?
    
    let url = "https://api.guerrillamail.com/ajax.php"
    
    func startSession() {
        
        guard let url = URL(string: "\(url)?f=get_email_address") else {return}
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, _, _ in
            guard let data = data else {return}
            do {
                let data = try JSON(data: data)
                delegate?.didStartSession(data: data)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func fetchInbox() {
        
    }
}
