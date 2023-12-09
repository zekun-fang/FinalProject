//
//  Contact.swift
//  APP12
//
//  Created by 方泽堃 on 11/20/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Contact: Codable{
    @DocumentID var id: String?
    var name: String
    var email: String
    var phone: Int
    
    init(name: String, email: String, phone: Int) {
        self.name = name
        self.email = email
        self.phone = phone
    }
}
