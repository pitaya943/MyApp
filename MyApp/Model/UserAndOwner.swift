//
//  User.swift
//  MyApp
//
//  Created by 阿揆 on 2021/2/23.
//

import Foundation

struct User: Identifiable, Codable {
    
    var id : String
    var name : String
    var email: String?
    var phoneNumber : String
    var pic : String
    var age: String?
    var address: String?
    var about: String?
    var nationality: String?
    
    init(id: String = "", name: String = "", email: String? = "", phoneNumber: String = "", pic: String = "", age: String? = "", address: String? = "", about: String? = "", nationality: String? = "") {
        
        self.id = id
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
        self.pic = pic
        self.age = age
        self.address = address
        self.about = about
        self.nationality = nationality

    }
    
}

struct Owner: Identifiable, Codable {
    
    var id: String
    var name: String
    var phoneNumber: String
    var pic: String
    var about: String
}
