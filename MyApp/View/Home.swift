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
    @State var tabSelectedIndex = 0
    
    let numTabs = 2
    let minDragTranslationForSwipe: CGFloat = 50
    
    var body: some View {
        
        ZStack {
            if newMember {
                NewMember()
            }
            else {
                TabView(selection: $tabSelectedIndex) {
                    MainView()
                        .tag(0)
                    NavigationView { MessageBox().environmentObject(ChatObservable()) }
                        .navigationViewStyle(StackNavigationViewStyle())
                        .tag(1)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
        }
    }
            // MARK: - Swipe gesture
//    private func handleSwipe(translation: CGFloat) {
//            if translation > minDragTranslationForSwipe && tabSelectedIndex > 0 {
//                tabSelectedIndex -= 1
//            } else  if translation < -minDragTranslationForSwipe && tabSelectedIndex < numTabs - 1 {
//                tabSelectedIndex += 1
//            }
//    }
    
}

var tabItems = ["home", "recommend", "notification", "profile"]
var tabTitles = ["home": "首頁", "notification": "通知", "recommend": "推薦", "profile": "我的帳戶"]

enum Tab {
    case home, recommend, notification, profile
}

struct MainView: View {
    
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            
            TabView_home()
                .tabItem { TabButton(image: "home", title: "首頁") }
                .tag(Tab.home)
                .navigationBarHidden(true)
            TabView_recommend()
                .tabItem { TabButton(image: "recommend", title: "推薦") }
                .tag(Tab.recommend)
                .navigationBarHidden(true)
            TabView_notification()
                .tabItem { TabButton(image: "notification", title: "通知") }
                .tag(Tab.notification)
                .navigationBarHidden(true)
            TabView_profile()
                .tabItem { TabButton(image: "profile", title: "個人資料") }
                .tag(Tab.profile)
            
        }
        .tabViewStyle(DefaultTabViewStyle())
        
    }
}

struct TabButton: View {
    
    var image: String
    var title: String
    
    var body: some View {
        
        VStack(spacing: 6) {
            Image(image)
                .renderingMode(.template)
                .resizable()
                .foregroundColor(Color.black.opacity(0.4))
            Text(title)
                .font(.caption)
                .foregroundColor(Color.black)
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
