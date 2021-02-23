//
//  ImageRegister.swift
//  MyApp
//
//  Created by 阿揆 on 2021/2/22.
//

import SwiftUI

struct ImageRegister: View {
    
    @EnvironmentObject var accountCreation: AccountCreationModel
    @State var currentImage = 0
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                Text("關於你")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                
                Spacer()
                
                if check() {
                    
                    Button(action: {}, label: {
                        Text("新增")
                            .fontWeight(.heavy)
                            .foregroundColor(.blue)
                    })
                }
            }
            .padding(.top, 30)
            .padding(.horizontal)
            
            GeometryReader { reader in
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 15), count: 2), spacing: 20, content: {
                    
                    ForEach(accountCreation.images.indices, id: \.self) { index in
                        
                        ZStack {
                            
                            if accountCreation.images[index].count == 0 {
                                Image(systemName: "person.badge.plus")
                                    .font(.system(size: 45))
                                    .foregroundColor(.gray)
                            }
                            else {
                                Image(uiImage: UIImage(data: accountCreation.images[index])!)
                                    .resizable()
                            }
                        }
                        .frame(width: (reader.frame(in: .global).width - 15) / 2, height: (reader.frame(in: .global).height - 20) / 2)
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)
                        .onTapGesture {
                            
                            // Image picker
                            currentImage = index
                            accountCreation.picker.toggle()
                        }
                    }
                })
            }
            .padding(.top)
            .padding(.bottom, 30)
        }
        .padding(.horizontal)
        .sheet(isPresented: $accountCreation.picker, content: {
            
            ImagePicker(show: $accountCreation.picker, ImageData: $accountCreation.images[currentImage])
        })
    }
    
    func check() -> Bool {
        
        for data in accountCreation.images {
            if data.count >= 1 {
                return true
            }
        }
        
        return false
    }
}

struct ImageRegister_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
