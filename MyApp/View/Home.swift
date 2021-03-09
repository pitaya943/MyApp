//
//  Home.swift
//  MyApp
//
//  Created by 阿揆 on 2021/2/23.
//

import SwiftUI
import Firebase

var tabs = ["mainView", "messageBox"]

struct Home: View {
    
//    @State var tabSelectedIndex = 0
    @State var offset: CGFloat = 0
    
//    let numTabs = 2
//    let minDragTranslationForSwipe: CGFloat = 50
    
    var body: some View {
        
        GeometryReader { proxy in
            
            let rect = proxy.frame(in: .global)
            ScrollableTabBar(tabs: tabs, rect: rect, offset: $offset) {
                
                HStack(spacing: 0) {
                    
                    MainView()
                        .cornerRadius(0)

                    MessageBox()
                        .environmentObject(ChatObservable())
                        .cornerRadius(0)
                    
                }
                .ignoresSafeArea()
            }
        }
        .ignoresSafeArea()


//        TabView(selection: $tabSelectedIndex) {
//
//            MainView()
//                .tag(0)
//                        .highPriorityGesture(DragGesture().onEnded({ self.handleSwipe(translation: $0.translation.width) }))

//            MessageBox().environmentObject(ChatObservable())
//                .tag(1)
//                        .highPriorityGesture(DragGesture().onEnded({ self.handleSwipe(translation: $0.translation.width) }))
//        }
//        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        //.ignoresSafeArea(.all, edges: .bottom)
        
    }
            // MARK: - Swipe gesture
    
//    private func handleSwipe(translation: CGFloat) {
//            if translation > minDragTranslationForSwipe && tabSelectedIndex > 0 {
//                withAnimation { tabSelectedIndex -= 1 }
//            } else  if translation < -minDragTranslationForSwipe && tabSelectedIndex < numTabs - 1 {
//                withAnimation { tabSelectedIndex += 1 }
//            }
//    }
    
}

enum Tab {
    case home, recommend, notification, profile
}

struct MainView: View {
    
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            
            TabView_home()
                .tabItem { Label("首頁", systemImage: selectedTab == Tab.home ? "house.fill" : "house") }
                .tag(Tab.home)
                .navigationBarHidden(true)
            
            TabView_recommend()
                .tabItem { Label("推薦", systemImage: selectedTab == Tab.recommend ? "flame.fill" : "flame") }
                .tag(Tab.recommend)
                .navigationBarHidden(true)
            
            TabView_notification()
                .tabItem { Label("通知", systemImage: selectedTab == Tab.notification ? "bell.fill" : "bell") }
                .tag(Tab.notification)
                .navigationBarHidden(true)
            
            TabView_profile()
                .tabItem { Label("個人資料", systemImage: selectedTab == Tab.profile ? "person.crop.circle.fill" : "person.crop.circle") }
                .tag(Tab.profile)
            
        }
        //.tabViewStyle(DefaultTabViewStyle())
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
