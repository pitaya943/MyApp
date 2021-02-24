//
//  TabView_profile.swift
//  MyApp
//
//  Created by 阿揆 on 2021/2/24.
//

//  @AppStorage("newMemberPage")
//  @AppStorage("newMember")
//  @AppStorage("log_Status")
//  @AppStorage("uid")
//  @AppStorage("user")
//  @AppStorage("phone")

import SwiftUI
import Firebase

struct TabView_profile: View {
        
    var body: some View {
        
        NavigationView {
            
            VStack {
                NavigationLink(destination: MassageBox().environmentObject(ChatObservable())){ Text("MessageBox") }
            }
            .navigationBarTitle("個人資料設定", displayMode: .inline)

        }
        
    }
    
}

struct logoutButton: View {
    
    @AppStorage("log_Status") var status = false
    
    var body: some View {
        
        Button(action: {
            withAnimation(.easeInOut) {
                status.toggle()
                resetUserdefault()
            }
        }, label: {
            Text("登出")
        })
    }
    
    func resetUserdefault() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
}



struct TabView_profile_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
