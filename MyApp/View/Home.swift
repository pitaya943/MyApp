//
//  Home.swift
//  MyApp
//
//  Created by 阿揆 on 2021/2/23.
//

import SwiftUI
import Firebase

struct Home: View {
    
    @AppStorage("newMember") var newMember = false
    
    var body: some View {
        
        ZStack {
            if newMember {
                withAnimation { NewMember() }
            }
            else {
                CustomTabBar()
            }
        }
    }
    
}

var tabItems = ["home", "recommend", "notification", "profile"]
var tabTitles = ["home": "首頁", "notification": "通知", "recommend": "推薦", "profile": "個人資料"]

struct CustomTabBar: View {
    
    @State var selectedTab = "home"
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            
            TabView(selection: $selectedTab) {
                
                TabView_home()
                    .tag(tabItems[0])
                Text("2")
                    .tag(tabItems[1])
                Text("3")
                    .tag(tabItems[2])
                TabView_profile()
                    .tag(tabItems[3])
                
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .ignoresSafeArea(.all, edges: .bottom)
            
            HStack(spacing: 0) {
                
                ForEach(tabItems, id: \.self) { image in
                    CustomTabButton(image: image,title: tabTitles[image] ?? "" ,selectedTab: $selectedTab)
                    
                    if image != tabItems.last { Spacer(minLength: 0) }
                }
            }
            .padding(.horizontal, 25)
            .padding(.vertical, 5)
            .background(Color.white)
            .clipShape(Capsule())
            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 5, y: 5)
            .shadow(color: Color.black.opacity(0.15), radius: 5, x: -5, y: -5)
            .padding(.horizontal)
        }
    }
}

struct CustomTabButton: View {
    
    var image: String
    var title: String
    @Binding var selectedTab: String
    
    var body: some View {
        
        Button(action: { selectedTab = image }, label: {
            
            VStack(spacing: 6) {
                
                if selectedTab == image {
                    
                    let imageFill = image + "+"
                    Image(imageFill)
                        .renderingMode(.template)
                        .resizable()
                        .foregroundColor(Color.blue)
                        .frame(width: 20, height: 20)
                }
                else {
                    
                    Image(image)
                        .renderingMode(.template)
                        .resizable()
                        .foregroundColor(Color.black.opacity(0.4))
                        .frame(width: 20, height: 20)
                }
                
                Text(title)
                    .font(.caption)
                    .foregroundColor(selectedTab == image ? Color.blue : Color.black.opacity(0.4))
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
        })
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
