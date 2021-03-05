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
    
    @StateObject var datas = SelfProfile()
    @AppStorage("pic") var pic = ""
    @AppStorage("user") var user = ""
    @AppStorage("log_Status") var status = false
    
    @State private var showingAlert = false
    @State private var tabBar: UITabBar! = nil
    
    var pic2 = "https://kb.rspca.org.au/wp-content/uploads/2018/11/golder-retriever-puppy.jpeg"
    var title = ["基本資料設定", "訊息箱", "已收藏", "換宿紀錄", "設定"]
        
    var body: some View {
            
        NavigationView {
            VStack {
                
                VStack(spacing: 10) {
                    if datas.userDetail.pic != "" {
                        AnimatedImage(url: URL(string: datas.userDetail.pic)!)
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3)
                            .clipShape(Circle())
                        
                        Text(datas.userDetail.name).fontWeight(.bold)
                        Text(datas.userDetail.about!)
                    }
                    
                }.padding(.top, 15)
                                
                List {
                    NavigationLink(destination: Profile(datas: datas)
                                    .navigationBarTitle(title[0], displayMode: .inline)
                                    .onAppear { self.tabBar.isHidden = true }
                                    .onDisappear { self.tabBar.isHidden = false }){
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(.blue)
                            Text(title[0]).offset(x: 5, y: 0)
                        }
                    }
                    
                    // MARK: - .environmentObject(ChatObservable())
//                    NavigationLink(destination: MessageBox().environmentObject(ChatObservable())
//                                    .navigationBarTitle(title[1], displayMode: .inline)){
//                        HStack {
//                            Image(systemName: "tray")
//                                .foregroundColor(.blue)
//                            Text(title[1]).offset(x: 5, y: 0)
//                        }
//                    }
                    
                    
                    NavigationLink(destination: Collection()
                                    .navigationBarTitle(title[2], displayMode: .inline)
                                    .onAppear { self.tabBar.isHidden = true }
                                    .onDisappear { self.tabBar.isHidden = false }){
                        HStack {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.blue)
                            Text(title[2]).offset(x: 5, y: 0)
                        }
                    }

                    
                    NavigationLink(destination: Record()
                                    .navigationBarTitle(title[3], displayMode: .inline)
                                    .onAppear { self.tabBar.isHidden = true }
                                    .onDisappear { self.tabBar.isHidden = false }){
                        HStack {
                            Image(systemName: "square.and.pencil")
                                .foregroundColor(.blue)
                            Text(title[3]).offset(x: 5, y: 0)
                        }
                    }

                    
                    NavigationLink(destination: Setting()
                                    .navigationBarTitle(title[4], displayMode: .inline)
                                    .onAppear { self.tabBar.isHidden = true }
                                    .onDisappear { self.tabBar.isHidden = false }){
                        HStack {
                            Image(systemName: "gearshape.fill")
                                .foregroundColor(.blue)
                            Text(title[4]).offset(x: 5, y: 0)
                        }
                    }

                    
                    HStack { logoutButton(showingAlert: $showingAlert) }
                    .frame(width: UIScreen.main.bounds.width - 40)
                    
                }
                .listStyle(GroupedListStyle())
                
            }
            .navigationBarTitle("個人資料", displayMode: .inline)
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(""), message: Text("確定要登出嗎？"), primaryButton: .destructive(Text("確定"), action: {
                logoutRequest()
            }), secondaryButton: .cancel(Text("取消"), action: { print("Logout alert cancel") }))
        }
        .background(TabBarAccessor { tabbar in
                    self.tabBar = tabbar })

    }
    
    
    
    func logoutRequest() {
        status.toggle()
        resetUserdefault()
        print("User logout!")
    }
    
    func resetUserdefault() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        print("Userdefault clear")
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
    
    @Binding var showingAlert: Bool
    
    var body: some View {
        
        Button(action: { showingAlert.toggle() }, label: {
            Text("登出")
                .foregroundColor(.red)
        })
    }
    
}



struct TabView_profile_Previews: PreviewProvider {
    static var previews: some View {
        TabView_profile()
    }
}
