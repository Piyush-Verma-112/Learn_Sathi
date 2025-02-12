//
//  UserAuth.swift
//  LearnSathi
//
//  Created by Shahma Ansari on 10/01/25.
//

import Foundation

struct UserAuth {
    var id: UUID
    var firstName: String
    var lastName: String
    var standard: String
    var email: String
    var number: String
    var profileImage: String?

}

var users : [UserAuth] = [
    
    UserAuth(id: UUID(), firstName: "Ayush", lastName: "Singh", standard: "7", email: "axcy121@gmail.com", number: "203232302039", profileImage: "profileImage"),
    UserAuth(id: UUID(), firstName: "Abu", lastName: "Shahma", standard: "8", email: "fuzail211@gmail.com", number: "203232302039", profileImage: "user2"),
]
