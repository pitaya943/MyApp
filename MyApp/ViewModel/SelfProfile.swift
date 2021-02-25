//
//  SelfProfile.swift
//  MyApp
//
//  Created by 阿揆 on 2021/2/26.
//

import SwiftUI
import Firebase

class SelfProfile: ObservableObject {
    
    @Published var userDetail = User()
    
    init() {
        
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid

        db.collection("User").document(uid!).addSnapshotListener(includeMetadataChanges: true) { (snap, err) in
            
            
            if let snap = snap, snap.exists {
                
                let dataDescription = snap.data().map(String.init(describing:)) ?? "nil"
                print("Catch user data: \(dataDescription)")
                
                let id = snap.documentID
                let name = snap.get("name") as! String
                let email = snap.get("email") as! String
                let phoneNumber = snap.get("phoneNumber") as! String
                let pic = snap.get("pic") as! String
                let age = snap.get("age") as! String
                let about = snap.get("about") as! String
                let address = snap.get("address") as! String
                let nationality = snap.get("nationality") as! String

                self.userDetail.id = id
                self.userDetail.name = name
                self.userDetail.email = email
                self.userDetail.phoneNumber = phoneNumber
                self.userDetail.pic = pic
                self.userDetail.age = age
                self.userDetail.about = about
                self.userDetail.address = address
                self.userDetail.nationality = nationality
                
                UserDefaults.standard.setValue(name, forKey: "user")
                UserDefaults.standard.setValue(pic, forKey: "pic")
                UserDefaults.standard.setValue(phoneNumber, forKey: "phoneNumber")
                
            }
        }
        
        
    }
    
}
