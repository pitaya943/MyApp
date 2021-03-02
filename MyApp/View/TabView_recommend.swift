//
//  TabView_recommend.swift
//  MyApp
//
//  Created by 阿揆 on 2021/2/24.
//

import SwiftUI

struct TabView_recommend: View {
    var body: some View {
        
        VStack {
            
            outButton()
        }

    }
}

struct outButton: View {
    
    @AppStorage("log_Status") var status = false
    
    var body: some View {
        
        Button(action: { status.toggle()
                resetUserdefault()
                print("User logout!") }, label: {
            Text("登出")
                .foregroundColor(.red)
        })
    }
    
    func resetUserdefault() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        print("Userdefault clear")
    }
    
}

struct TabView_recommend_Previews: PreviewProvider {
    static var previews: some View {
        TabView_recommend()
    }
}
