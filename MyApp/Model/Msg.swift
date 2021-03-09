//
//  Msg.swift
//  MyApp
//
//  Created by 阿揆 on 2021/2/25.
//

import Foundation
import FirebaseFirestoreSwift

struct Msg : Identifiable, Hashable {
    
    @DocumentID var id: String?
    var msg : String
    var user : String
}
