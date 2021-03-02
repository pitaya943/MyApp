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
    
    func updateAge() {
        
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        
        let userRef = db.collection("User").document(uid!)
        if userDetail.nationality != nil {
            userRef.updateData(["age" : userDetail.age!]){ err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
            print("Age setting")
        }
    }
    
    func updateNationaality() {
        
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        
        let userRef = db.collection("User").document(uid!)
        if userDetail.nationality != nil {
            userRef.updateData(["nationality" : userDetail.nationality!]){ err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
            print("Nationality setting")
        }
    }
    
    func setPicture(imagedata: Data) {
        
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        let storage = Storage.storage().reference()
        
        // Put imagedata to firebase
        storage.child("profilePics").child(uid!).putData(imagedata, metadata: nil) { (_, err) in
            
            if err != nil {
                
                print((err?.localizedDescription)!)
                return
            }
            // Download back to store
            storage.child("profilePics").child(uid!).downloadURL { (url, err) in
                
                if err != nil {
                    
                    print((err?.localizedDescription)!)
                    return
                }
                // Update user pic url
                db.collection("User").document(uid!).setData(["pic" :"\(url!)"], merge: true) { (err) in
                    if err != nil{
                        
                        print((err?.localizedDescription)!)
                        return
                    }
                }
            }
        }
    }
    
}
