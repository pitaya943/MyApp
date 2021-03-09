//
//  GetAllUser.swift
//  MyApp
//
//  Created by 阿揆 on 2021/2/25.
//

import SwiftUI
import Firebase

class getAllOwners : ObservableObject {
    
    @Published var owners = [Owner]()
    @Published var empty = false
    
    init() {
        
        let db = Firestore.firestore()
        
        
        db.collection("Owner").getDocuments { (snap, err) in

            if err != nil{
                
                print((err?.localizedDescription)!)
                self.empty = true
                return
            }
            
            if (snap?.documents.isEmpty)! {
                
                self.empty = true
                return
            }
            
            for i in snap!.documents {
                
                let id = i.documentID
                let name = i.get("name") as! String
                let pic = i.get("pic") as? [String] ?? [String]()
                let phoneNumber = i.get("phoneNumber") as! String
                let about = i.get("about") as! String
                
                if id != UserDefaults.standard.value(forKey: "uid") as! String {
                    
                    self.owners.append(Owner(id: id, name: name, phoneNumber: phoneNumber, pic: pic[0], about: about))
                    
                }
                
            }
            
            if self.owners.isEmpty {
                
                self.empty = true
            }
        }
    }
}
