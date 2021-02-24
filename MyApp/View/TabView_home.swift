//
//  TabView_home.swift
//  MyApp
//
//  Created by 阿揆 on 2021/2/24.
//

import SwiftUI

struct TabView_home: View {
    
    @AppStorage("user") var user = ""
    @AppStorage("uid") var uid = ""
    @AppStorage("phone") var phone = ""
    @AppStorage("newMember") var newMember = false
    @AppStorage("newMemberPage") var page = 1
    @AppStorage("log_Status") var status = false
    @AppStorage("pic") var pic = ""

    var body: some View {
        
        VStack(spacing: 15) {
         
            Text("Hello \(user)!")
            Text("newMember = \(String(newMember))")
            Text("newMemberPage = \(String(page))")
            Text("log_Status = \(String(status))")
            Text("uid = \(uid)")
            Text("phone = \(phone)")
            Text("pic = \(pic)")
        }
        
    }
}

struct TabView_home_Previews: PreviewProvider {
    static var previews: some View {
        TabView_home()
    }
}
