//
//  MessageBox.swift
//  MyApp
//
//  Created by 阿揆 on 2021/2/24.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct MessageBox: View {
    
    @EnvironmentObject var datas: ChatObservable
    @State var show = false
    @State var chat = false
    @State var id = ""
    @State var name = ""
    @State var pic = ""
    
    var body: some View {
        
        NavigationView {
        
            ZStack {
                
                NavigationLink(destination: ChatView(name: self.name, pic: self.pic, uid: self.id, chat: self.$chat).transition(.scale), isActive: self.$chat) { Text("") }
                
                VStack{
                    if self.datas.recents.count == 0 {
                        
                        if self.datas.norecetns {
                            Text("沒有聊天記錄")
                        }
                        else { Indicator() }
                    }
                    else {
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            
                            VStack(spacing: 12) {
                                
                                ForEach(datas.recents.sorted(by: {$0.stamp > $1.stamp})) { i in
                                    
                                    Button(action: {
                                            self.id = i.id
                                            self.name = i.name
                                            self.pic = i.pic
                                            self.chat.toggle()
                                        
                                    }) {
                                        RecentCellView(url: i.pic, name: i.name, time: i.time, date: i.date, lastmsg: i.lastmsg)
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                }
                .navigationBarTitle("訊息箱", displayMode: .inline)
                .navigationBarItems(trailing: Button(action: { self.show.toggle() }, label: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 20, height: 20)
                }))
                .sheet(isPresented: self.$show) {
                    newChatView(name: self.$name, uid: self.$id, pic: self.$pic, show: self.$show, chat: self.$chat)
                }
            }
        }
    }
}

struct RecentCellView : View {
    
    var url : String
    var name : String
    var time : String
    var date : String
    var lastmsg : String
    
    var body : some View {
        
        HStack {
            
            AnimatedImage(url: URL(string: url)!)
                .resizable()
                .renderingMode(.original)
                .frame(width: 55, height: 55)
                .clipShape(Circle())
            
            VStack {
                
                HStack {
                    
                    VStack(alignment: .leading, spacing: 6) {
                        
                        Text(name).foregroundColor(.primary)
                        Text(lastmsg).foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .center, spacing: 6) {
                        
                         Text(time).foregroundColor(.gray)
                         Text(date).foregroundColor(.gray)
                    }
                }
                .padding(.horizontal)
                
                Divider()
            }
        }
    }
}

struct newChatView : View {
    
    @ObservedObject var datas = getAllOwners()
    @Binding var name : String
    @Binding var uid : String
    @Binding var pic : String
    @Binding var show : Bool
    @Binding var chat : Bool
    
    
    var body : some View{
        
        VStack(alignment: .leading) {

                if self.datas.owners.count == 0 {
                    
                    if self.datas.empty {
                        
                        Text("沒有用戶")
                    }
                    else {
                        
                        Indicator()
                    }
                    
                }
                else {
                    
                    VStack {
                        Text("與業者聊天").font(.title).foregroundColor(Color.black)
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            
                            VStack(spacing: 12){
                                
                                ForEach(datas.owners) { i in
                                    
                                    Button(action: {
                                        
                                        self.uid = i.id
                                        self.name = i.name
                                        self.pic = i.pic
                                        self.show.toggle()
                                        self.chat.toggle()
                                        
                                    }) {
                                        OwnerCellView(url: i.pic, name: i.name, about: i.about)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
              }
        }
        .padding()
    }
}

struct OwnerCellView : View {
    
    var url : String
    var name : String
    var about : String
    
    var body : some View{
        
        HStack{
            
            AnimatedImage(url: URL(string: url)!)
                .resizable()
                .renderingMode(.original)
                .frame(width: 55, height: 55)
                .clipShape(Circle())
            
            VStack{
                
                HStack{
                    
                    VStack(alignment: .leading, spacing: 6) {
                        
                        Text(name).foregroundColor(.black)
                        Text(about).foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                }
                
                Divider()
            }
        }
    }
}
