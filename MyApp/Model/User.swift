//
//  User.swift
//  MyApp
//
//  Created by 阿揆 on 2021/2/23.
//

import Foundation

struct User : Identifiable, Codable {
    
    var id : String
    var name : String
    var phoneNumber : String
    var pic : String
}

struct Owner : Identifiable, Codable {
    
    var id : String
    var name : String
    var phoneNumber : String
    var pic : String
    var about: String
}
