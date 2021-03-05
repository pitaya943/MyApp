//
//  NewMember.swift
//  MyApp
//
//  Created by 阿揆 on 2021/2/23.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct NewMember: View {
    
    var body: some View {
        WalkthroughScreen()
    }
    
}

var totalPages = 3

struct WalkthroughScreen: View {
    
    @AppStorage("user") var user = ""
    @AppStorage("uid") var uid = ""
    @AppStorage("newMemberPage") var page = 1
    @AppStorage("newMember") var newMember = false
    
    var body: some View {
        
        ZStack {
            
            if page == 1 {
                
                FirstView(user: $user)
                    .transition(.scale)
            }
            if page == 2 {
                
                ScreenView(image: "image2", title: "工作、壓力", detail: "走出繁忙都市生活\n 享受慢步調的鄉村生活\n 認識來自各個地方的人們", bgColor: "secondBack")
                    .transition(.scale)
            }
            if page == 3 {
                
                ScreenView(image: "image3", title: "挑戰自我", detail: "開始尋找快樂吧\n 開始在臺灣四處旅行吧 \n Live a live you will remember !", bgColor: "thirdBack")
                    .transition(.scale)
            }
        }
        .overlay(
            Button(action: { withAnimation(.easeInOut) {
                    if page < totalPages {
                        page += 1
                    }
                    else {
                        newMember.toggle()
                        updateNewMemberName()
                    }
                }
            }, label: {
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(width: 60, height: 60)
                    .background(Color.white)
                    .clipShape(Circle())
                
                    .overlay(
                        ZStack {
                            
                            Circle()
                                .stroke(Color.black.opacity(0.04), lineWidth: 4)
                            
                            Circle()
                                .trim(from: 0, to: CGFloat(page) / CGFloat(totalPages))
                                .stroke(Color.white, lineWidth: 4)
                                .rotationEffect(.init(degrees: -90))
                        }
                        .padding(-10)
                    )
            })
            .disabled(user == "" ? true : false)
            .padding(.bottom, 20)
            , alignment: .bottom
                
        )
    }
    
    func updateNewMemberName() {
        let db = Firestore.firestore()
        let userRef = db.collection("User").document(uid)
        
        if user != "" {
            userRef.setData(["name" : user ], merge: true)
            print("update succeed")
        }
        else {
            print("user is Empty")
        }
    }
}

struct FirstView: View {
    
    @Binding var user: String
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            HStack(spacing: 15) {
                Text("歡迎加入!")
                    .fontWeight(.heavy)
                    .font(.title)
                    .kerning(2)
                
                Spacer()
                
            }
            .foregroundColor(.black)
            .padding(.vertical, 30)
            .padding(.horizontal)
            .padding()
            
            Spacer(minLength: 0)
            
            VStack(spacing: 10) {
                Image("image1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .padding(.horizontal)
                
                Text("首先")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Text("您希望業主或是其他朋友們如何稱呼您呢？")
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black).opacity(0.7)
                
                // MARK: - Dark mode textfeild text color is white
                VStack {
                    TextField("  請輸入", text: $user)
                        .frame(width: UIScreen.main.bounds.width / 2, height: 35, alignment: .center)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(8)
            }
            
            Spacer(minLength: 120)
            
        }
        .background(Color("firstBack").cornerRadius(10).ignoresSafeArea())
    }
}

struct ScreenView: View {
        
    var image: String
    var title: String
    var detail: String
    var bgColor: String
    
    @AppStorage("user") var user = ""
    @AppStorage("uid") var uid = ""
    @AppStorage("newMemberPage") var page = 1
    @AppStorage("newMember") var newMember = false
    
    var body: some View {
        
        VStack(spacing: 20) {
                
            HStack {
                Button(action: { page -= 1 }, label: {
                    
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .padding(.vertical, 15)
                        .padding(.horizontal)
                        .background(Color.black.opacity(0.4))
                        .cornerRadius(15)
                })
                
                Spacer()
                
                Button(action: { withAnimation(.easeInOut) {
                    newMember.toggle()
                    updateNewMemberName()
                } }, label: {
                    Text("跳過")
                        .fontWeight(.semibold)
                        .kerning(1.2)
                        .foregroundColor(.black)
                })
                .padding(.vertical, 15)
                .padding(.horizontal)
                .cornerRadius(15)
                
            }
            .foregroundColor(.black)
            .padding(.horizontal, 15)
            .padding()
            
            Spacer(minLength: 0)
            
            VStack(spacing: 15) {
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .padding(.horizontal)
                
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Text(detail)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black).opacity(0.7)
                
            }
            
            Spacer(minLength: 120)
            
        }
        .background(Color(bgColor).cornerRadius(10).ignoresSafeArea())
    }
    
    func updateNewMemberName() {
        let db = Firestore.firestore()
        let userRef = db.collection("User").document(uid)
        
        if user != "" {
            userRef.setData(["name" : user ], merge: true)
            print("update succeed")
        }
        else {
            print("user is Empty")
        }
    }
}

struct NewMember_Previews: PreviewProvider {
    static var previews: some View {
        
        NewMember()
        
    }
}
