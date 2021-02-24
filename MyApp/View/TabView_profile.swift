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
import SDWebImageSwiftUI

struct TabView_profile: View {
    
    @AppStorage("pic") var pic = ""
    @AppStorage("user") var user = ""
    
    var pic2 = "https://kb.rspca.org.au/wp-content/uploads/2018/11/golder-retriever-puppy.jpeg"
        
    var body: some View {
            
        VStack {
            
            VStack {
                AnimatedImage(url: URL(string: pic2)!)
                    .resizable()
                    .renderingMode(.original)
                    .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3)
                    .clipShape(Circle())
                
                Text("user")
                
            }.padding()
                
            
            List {
                NavigationLink(destination: Profile()){
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(.blue)
                        Text("基本資料設定").offset(x: 5, y: 0)
                    }
                }
                // .environmentObject(ChatObservable())
                NavigationLink(destination: MassageBox()){
                    HStack {
                        Image(systemName: "tray")
                            .foregroundColor(.blue)
                        Text("訊息箱").offset(x: 5, y: 0)
                    }
                }
                
                NavigationLink(destination: Collection()){
                    HStack {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.blue)
                        Text("已收藏").offset(x: 5, y: 0)
                    }
                }
                
                NavigationLink(destination: Record()){
                    HStack {
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(.blue)
                        Text("換宿紀錄").offset(x: 5, y: 0)
                    }
                }
                
                NavigationLink(destination: Setting()){
                    HStack {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.blue)
                        Text("設定").offset(x: 5, y: 0)
                    }
                }
                
                HStack { logoutButton() }
                .frame(width: UIScreen.main.bounds.width - 40)
                
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("我的帳戶", displayMode: .inline)
            
            
        }

    }
    
}

struct Profile: View {
    var body: some View {
        Text("profile view")
    }
}

struct Record: View {
    var body: some View {
        Text("record view")
    }
}

struct Setting: View {
    var body: some View {
        Text("setting view")
    }
}

struct Collection: View {
    var body: some View {
        Text("collection view")
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
                .foregroundColor(.red)
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
        TabView_profile()
    }
}
