//
//  MotherView.swift
//  MyApp
//
//  Created by 阿揆 on 2021/3/5.
//

import SwiftUI

struct MotherView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        
        switch viewRouter.currentPage {
        
        case .cover:
            CoverView()
            
        case .main:
            ContentView()

        case .newMember:
            NewMember()
        }
        
    }
}

struct CoverView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State var timeRemaining = 3
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        ZStack {
            
            Image("cover")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all, edges: .all)
            
            ZStack {
                Color.white
                    .opacity(0.7)
                    .frame(width: 500, height: 50, alignment: .center)
                Text("Welcome")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                
            }
            
        }.onReceive(timer) { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            }
            if self.timeRemaining == 0 {
                withAnimation { viewRouter.currentPage = .main }
            }
        }
    }
}
