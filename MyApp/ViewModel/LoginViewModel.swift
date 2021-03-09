//
//  LoginViewModel.swift
//  MyApp
//
//  Created by 阿揆 on 2021/2/22.
//

//  @AppStorage("newMemberPage")
//  @AppStorage("newMember")
//  @AppStorage("log_Status")
//  @AppStorage("uid")
//  @AppStorage("user")
//  @AppStorage("phone")

import SwiftUI
import Firebase
import FirebaseFirestoreSwift


class LoginViewModel: ObservableObject {
    
    // Login details
    @Published var phNumber = ""
    @Published var code = ""
    
    // DataModdel for error view
    @Published var errorMsg = ""
    @Published var error = false
    
    // OTP Credentials
    @Published var CODE = ""
    
    // Go to verify screen
    @Published var goToVerify = false
    
    // User logged status
    @AppStorage("log_Status") var status = false
    @AppStorage("newMember") var newMember = false
    
    // Loading view
    @Published var loading = false
    
    // UserDefault Informations
    @AppStorage("uid") var uid = ""
    @AppStorage("user") var user = ""
    @AppStorage("phone") var phone = ""
    @AppStorage("pic") var pic = ""
    
    // Storage in firebase
    let storage = Storage.storage().reference()
    // Firebase
    let db = Firestore.firestore()
    
    func getCountryCode() -> String {
        
        let regionCode = Locale.current.regionCode ?? ""
        
        return countries_code[regionCode] ?? ""
    }
    
    func getUserData() {
        
        
        uid = Auth.auth().currentUser?.uid ?? ""
        phone = Auth.auth().currentUser?.phoneNumber ?? ""
        let userRef = db.collection("User").document(uid)
        
        // If user exist, read Data else write new one
        userRef.getDocument { (document, err) in
            // If exist
            if let document = document, document.exists {
                
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                
                // Getting user name for userdefault from firebase
                UserDefaults.standard.set(document.get("name") as! String, forKey: "user")
                UserDefaults.standard.set(document.get("pic") as! String, forKey: "pic")
                
                print("Logging user data: \(dataDescription)")
                
            // New member
            }
            else {
                do {
                    // Get default image from firebase
                    self.getImageFromFirebase()
                    
                    // initialize user data
                    try userRef.setData(from: User(id: self.uid, phoneNumber: self.phone, pic: self.pic))
                    print("New user logged!!!")
                    
                    // If user not exist then toggle newMember
                    self.newMember = true
                    
                } catch {
                    print("Error \(error)")
                }
            }
        }

    }
    
    // Sending code to user
    func sendCode() {
        
        // Disabling App Verification...
        // Undo it while testing with live Phone....
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        
        loading = true
        let number = "+\(getCountryCode())\(phNumber)"
        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { (CODE, err) in

            if let error = err {
                
                self.errorMsg = error.localizedDescription
                withAnimation{ self.error.toggle() }
                self.loading.toggle()
                return
            }
            self.CODE = CODE ?? ""
            self.goToVerify = true
            self.loading = false
        }
    }
    
    func verifyCode() {
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.CODE, verificationCode: code)
        
        loading = true
        
        Auth.auth().signIn(with: credential) { (res, err) in
            
            self.loading = false
            
            if err != nil {
                self.errorMsg = err!.localizedDescription
                withAnimation{ self.error.toggle() }
                return
            }
            
            // Else user logged in Successfully
            self.getUserData()
            withAnimation { self.status = true }
            
            print("Userdefault: --------")
            print("Hello \(self.user)!")
            print("log_Status = \(String(self.status))")
            print("newMember = \(String(self.newMember))")
            print("uid = \(self.uid)")
            print("phone = \(self.phone)")
            print("pic = \(self.pic)")
            
        }
    }
    
    func requestCode() {
        
        sendCode()
        withAnimation {
            self.errorMsg = "驗證碼已傳送"
            self.error.toggle()
        }
    }
    
    func getImageFromFirebase() {

        let storage = Storage.storage().reference()
        let userRef = db.collection("User").document(uid)

        storage.child("defaultPic/pig.jpg").downloadURL { (url, err) in

            if err != nil {

                print((err?.localizedDescription)!)
                return
            }
            
            UserDefaults.standard.set("\(url!)", forKey: "pic")
            userRef.setData(["pic" :self.pic], merge: true)
            print("url default set")
        }
    }
    
    
    
}
