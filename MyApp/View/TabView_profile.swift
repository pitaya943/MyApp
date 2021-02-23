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

var userdefaultKeys = ["newMemberPage", "uid", "user", "phone"]

struct TabView_profile: View {
    
    @AppStorage("log_Status") var status = false
    
    var body: some View {
        
        VStack(spacing: 15) {
            
            Button(action: {
                withAnimation(.easeInOut) {
                    status.toggle()
                    resetUserdefault()
                }
            }, label: {
                Text("登出")
            })
            
            
        }
    }
    
    func resetUserdefault() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
}

struct TabView_profile_Previews: PreviewProvider {
    static var previews: some View {
        TabView_profile()
    }
}
