//
//  Register.swift
//  MyApp
//
//  Created by 阿揆 on 2021/2/22.
//

import SwiftUI

struct Register: View {
    @EnvironmentObject var accountCreation: AccountCreationModel
    var body: some View {
        
        VStack {
            
            Text("註冊")
                .fontWeight(.heavy)
                .font(.largeTitle)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 25)
            
            HStack(spacing: 15) {
                HStack(spacing: 15) {
                    
                    Image(systemName: "person.fill")
                        .foregroundColor(.gray)
                    
                    TextField("姓名", text: $accountCreation.name)
                }
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)
                .padding(.vertical)
                
                TextField("年齡", text: $accountCreation.age)
                .padding(.vertical, 12)
                .padding(.horizontal)
                .frame(width: 80)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)
                .padding(.vertical)
            }
                
            HStack(spacing: 15) {
                
                TextField("地址", text: $accountCreation.location)
                
                Button(action: {}, label: {
                    
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(.gray)
                })
            }
            .padding(.vertical, 12)
            .padding(.horizontal)
            .background(Color.white)
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)
            .padding(.vertical)
                
            TextEditor(text: $accountCreation.bio)
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)
                .padding(.vertical)
                    
            Button(action: {}, label: {
                
                HStack {
                    Spacer(minLength: 0)
                    Text("註冊")
                    Spacer(minLength: 0)
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(Color.blue)
                .cornerRadius(30)
            })
            
        }
        .frame(width: UIScreen.main.bounds.width*4/5)
        .padding()
        
    }
}

struct Register_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
