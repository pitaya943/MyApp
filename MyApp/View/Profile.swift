//
//  Profile.swift
//  MyApp
//
//  Created by 阿揆 on 2021/2/25.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI
import Combine

struct Profile: View {
    
    
    @ObservedObject var datas: SelfProfile
    // Imagepicker
    @State var showingImagePicker = false
    @State var showingNationalityPicker = false
    @State var showingAgePicker = false
    
    @State var imagedata : Data = .init(count: 0)
    // selected country
    @State var countryIndex = 0

    var body: some View {
        
        VStack(spacing: 0) {
            
            VStack(spacing: 15) {
                if datas.userDetail.pic != "" {
                    PicPresentation(url: datas.userDetail.pic, showingImagePicker: $showingImagePicker)
                }
                
                Text(datas.userDetail.name).fontWeight(.bold)
                Text(datas.userDetail.about!)
                
            }
            .padding()
        
            List {
                
                Section(header: Text("關於我")) {
                    NavigationLink(
                        destination: Modify(myInfo: datas.userDetail.name, target: "name").onDisappear(perform: {
                            UserDefaults.standard.setValue(datas.userDetail.name, forKey: "user")
                        }),
                        label: { NavigationLabel(tag: "我的名字", text: datas.userDetail.name) })
                    
                    NavigationLink(
                        destination: Modify(myInfo: datas.userDetail.about, target: "about"),
                        label: { NavigationLabel(tag: "我的狀態", text: datas.userDetail.about!) })
                    
                    NavigationLink(
                        destination: Modify(myInfo: datas.userDetail.email, target: "email"),
                        label: { NavigationLabel(tag: "E-mail", text: datas.userDetail.email!) })
                    
                    
                }
                
                Button(action: { withAnimation(.default) { showingNationalityPicker.toggle() } }, label: { NavigationLabel(tag: "國籍", text: datas.userDetail.nationality!) })
                    .foregroundColor(.black)
                
                Button(action: { withAnimation { showingAgePicker.toggle() } }, label: { NavigationLabel(tag: "年齡", text: datas.userDetail.age!) })
                    .foregroundColor(.black)
                
                NavigationLink(
                    destination: Modify(myInfo: datas.userDetail.address, target: "address"),
                    label: { NavigationLabel(tag: "住址", text: datas.userDetail.address!) })
                
                
                Section(header: Text("")) {
                    HStack {
                        Text("電話號碼")
                        Spacer()
                        Text(datas.userDetail.phoneNumber)
                    }
                }
                
            }
            .listStyle(GroupedListStyle())
            
            if showingAgePicker {
                Age(myAge: $datas.userDetail.age, present: $showingAgePicker)
                    .onDisappear(perform: datas.updateAge)
                    .transition(.move(edge: .bottom))
            }
            
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .sheet(isPresented: self.$showingImagePicker, onDismiss: { datas.setPicture(imagedata: imagedata) }, content: {
            ImagePicker(picker: self.$showingImagePicker, imagedata: $imagedata)
        })
        .sheet(isPresented: $showingNationalityPicker, content: {
            Nationality(myNationality: $datas.userDetail.nationality, present: $showingNationalityPicker)
                .transition(.slide)
                .onDisappear(perform: datas.updateNationaality)
        })
        
    }
}

struct NavigationLabel: View {
    
    var tag: String
    var text: String
    
    var body: some View {
        
        HStack {
            Text(tag).foregroundColor(.primary)
            Spacer()
            
            if tag != "E-mail" && text.count > 15 {
                
                let output = text.prefix(15) + "..."
                Text(output)
                    .foregroundColor(.primary)
                    .opacity(0.6)
            }
            else {
                Text(text)
                    .foregroundColor(.primary)
                    .opacity(0.6)
            }
            
        }
    }
}

struct PicPresentation: View {
    
    var url: String
    @Binding var showingImagePicker: Bool
    
    var body: some View {
            
        ZStack(alignment: .bottomTrailing) {
            AnimatedImage(url: URL(string: url)!)
                .resizable()
                .renderingMode(.original)
                .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3)
                .clipShape(Circle())
            
            
            Button(action: { showingImagePicker.toggle() }, label: {
                
                Image(systemName: "camera.fill")
                    .foregroundColor(.white)
                    .font(Font.system(size: 20))
                    .frame(width: 35, height: 35)
                    .background(Color.black.opacity(0.5))
                    .clipShape(Circle())
            })
        }
    
    }
}

struct Age: View {
    
    @Binding var myAge: String?
    @Binding var present: Bool
    @State private var ageIndex = 20
    
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                Button(action: { withAnimation { present.toggle() } }, label: {
                    Text("確定")
                })
            }
            .padding()
            .background(Color.gray.opacity(0.15))
            
            Picker(selection: $ageIndex, label: Text("Age").hidden(), content: {
                
                ForEach(0..<81) { index in
                    Text(String(index))
                        .tag(index)
                }
                
            })
            .onAppear(perform: getAgeIndex)
            .onDisappear(perform: setAge)
        }
    }
    
    func getAgeIndex() {
        ageIndex = Int(myAge!) ?? 20
    }
    
    func setAge() {
        myAge = String(ageIndex)
    }
}


struct Nationality: View {
    
    @State private var countryIndex = 0
    @State var text = ""
    @Binding var myNationality: String?
    @Binding var present: Bool
    
    var array = [Countries]()
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            Text("請選擇你的國家")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.primary)
            
            SearchBar(text: $text)
            
            List {
                ForEach(fetch().filter { text.isEmpty ? true : $0.en.contains(text) }, id: \.self) { index in

                    Button(action: {

                        present.toggle()
                        myNationality = index.tw

                    }) {

                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(index.tw)")
                                Text("\(index.en)")
                                    .font(.caption)
                                    .foregroundColor(Color.primary.opacity(0.5))
                            }

                            Spacer()

                            if myNationality == index.tw {
                                Image(systemName: "checkmark").foregroundColor(.blue)
                            }
                        }
                        .padding(5)
                    }
                }
            }
            
        }
        .padding()
        
    }
    
    func fetch() -> [Countries] {
        let url = Bundle.main.url(forResource: "countryData", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        let countryArray = try? decoder.decode([Countries].self, from: data)
        
        // Sorted array
        return countryArray!.sorted() { $1.tw.count > $0.tw.count }
        
    }
    
}

struct Modify: View {
    
    @Environment(\.presentationMode) var present
    @State var myInfo: String?
    @State var content = ""
    @State var textLimit = 30
    var target: String
    var targetTw = ["name": "我的名字", "about": "我的狀態", "email": "E-mail", "address": "我的住址"]
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 15) {
            
            VStack(alignment: .trailing, spacing: 0) {
                
                if target != "email" {
                    Text("\(content.count)/\(textLimit)").foregroundColor(Color.black.opacity(0.4))
                }
                TextField("", text: $content)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(target == "email" ? .emailAddress : .default)
                    .onReceive(Just(content), perform: { _ in
                        if target != "email" { limitText(textLimit) }
                    })
            }
                        
            Button(action: {
                updateContent(target: target)
                present.wrappedValue.dismiss()
                
            }, label: {
                Text("儲存")
                    .font(.system(size: 15))
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding(.vertical, 8)
                    .frame(width: UIScreen.main.bounds.width / 1.5)
                    .background(Color.blue)
                    .cornerRadius(10)
            })
            
        }
        .frame(width: UIScreen.main.bounds.width / 1.5)
        .padding(20)
        .padding(.horizontal, 25)
        .onAppear(perform: fetch)
        .navigationTitle(targetTw[target]!)
    }
    
    func limitText(_ upper: Int) {
        if content.count > upper {
            content = String(content.prefix(upper))
        }
    }
    
    func fetch() {
        if myInfo != nil { content = myInfo! }
        if target == "about" { textLimit = 50 }
    }
    
    func updateContent(target: String) {
        
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        
        let userRef = db.collection("User").document(uid!)
        if myInfo != nil {
            userRef.updateData([target : content]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
            print("Content setting")
        }
    }
}

//struct H_Previews: PreviewProvider {
//    static var previews: some View {
//        Modify()
//    }
//}
