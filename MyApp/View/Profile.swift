//
//  Profile.swift
//  MyApp
//
//  Created by 阿揆 on 2021/2/25.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct Profile: View {
    
    @ObservedObject var datas: SelfProfile
    @State var picker = false
    @State var imagedata : Data = .init(count: 0)

    var body: some View {
        
        VStack {
            
            VStack {
                if datas.userDetail.pic != "" {
                    AnimatedImage(url: URL(string: datas.userDetail.pic)!)
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3)
                        .clipShape(Circle())
                    
                    Text(datas.userDetail.name)
                }
                
            }
            .padding()
        
            List {
                
                Section(header: Text("關於我")) {
                    NavigationLink(
                        destination: Text(datas.userDetail.name),
                        label: { NavigationLabel(tag: "我的名字", text: datas.userDetail.name) })
                    
                    NavigationLink(
                        destination: Text(datas.userDetail.about!),
                        label: { NavigationLabel(tag: "我的狀態", text: datas.userDetail.about!) })
                    
                    NavigationLink(
                        destination: Text(datas.userDetail.email!),
                        label: { NavigationLabel(tag: "E-mail", text: datas.userDetail.email!) })
                    
                    
                }
                
                NavigationLink(
                    destination: Text(datas.userDetail.nationality!),
                    label: { NavigationLabel(tag: "國籍", text: datas.userDetail.nationality!) })
                
                NavigationLink(
                    destination: Text(datas.userDetail.age!),
                    label: { NavigationLabel(tag: "年齡", text: datas.userDetail.age!) })
                
                NavigationLink(
                    destination: Text(datas.userDetail.address!),
                    label: { NavigationLabel(tag: "住址", text: datas.userDetail.address!) })
                
                
                Section(header: Text("")) {
                    NavigationLink(
                        destination: Text(datas.userDetail.phoneNumber),
                        label: { NavigationLabel(tag: "電話號碼", text: datas.userDetail.phoneNumber) })
                }
                
            }
            .listStyle(GroupedListStyle())
            
        }
        .sheet(isPresented: self.$picker, content: {
            ImagePicker(picker: self.$picker, imagedata: $imagedata)
        })
        
        
    }
}

struct NavigationLabel: View {
    // Text all details
    var textAll = ["E-mail", "電話號碼"]
    var tag: String
    var text: String
    
    var body: some View {
        
        HStack {
            Text(tag)
            Spacer()
            
            if tag != textAll[0] && tag != textAll[1] && text.count > 6 {
                
                let output = text.prefix(6) + "..."
                Text(output)
                    .foregroundColor(.black)
                    .opacity(0.6)
            }
            else {
                Text(text)
                    .foregroundColor(.black)
                    .opacity(0.6)
            }
            
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile(datas: SelfProfile())
    }
}
