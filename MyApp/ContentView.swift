//
//  ContentView.swift
//  MyApp
//
//  Created by 阿揆 on 2021/2/22.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("log_Status") var status = false
    var body: some View {
        
        ZStack {
            if status {
                Home()
            }
            else {
                NavigationView { Login() }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
