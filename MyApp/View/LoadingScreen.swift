//
//  LoadingScreen.swift
//  MyApp
//
//  Created by 阿揆 on 2021/2/22.
//

import SwiftUI

struct LoadingScreen: View {
    
    var body: some View {
        
        ZStack {
            
            Color.black.opacity(0.2).ignoresSafeArea(.all, edges: .all)
            
            ProgressView()
                .padding(20)
                .background(Color.gray)
                .cornerRadius(10)
        }
    }
}

struct LoadingScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoadingScreen()
    }
}
