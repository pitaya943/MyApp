//
//  ContentView.swift
//  MyApp
//
//  Created by 阿揆 on 2021/2/22.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("log_Status") var status = false
    @State var timeRemaining = 3
    @State var isStart = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        if isStart {
            if status {
                Home()
            }
            else {
                NavigationView { Login() }
            }
        }
        else {
            CoverView()
                .onReceive(timer) { _ in
                    if self.timeRemaining > 0 {
                        self.timeRemaining -= 1
                    }
                    if self.timeRemaining == 0 {
                        isStart.toggle()
                    }
                }
        }
    }
}

struct CoverView: View {
    
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
