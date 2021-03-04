//
//  ChatView.swift
//  MyApp
//
//  Created by 阿揆 on 2021/2/25.
//

import SwiftUI
import Firebase

struct ChatView : View {
    
    var name : String
    var pic : String
    var uid : String
    @Binding var chat : Bool
    @State var msgs = [Msg]()
    @State var txt = ""
    @State var nomsgs = false
    
    var body : some View {
        
        VStack {
            
            if msgs.count == 0 {
                if self.nomsgs {
                    
                    Text("開始聊天吧")
                        .foregroundColor(Color.black.opacity(0.5))
                        .padding(.top)
                    Spacer()
                }
                else {
                    Spacer()
                    Indicator()
                    Spacer()
                }
            }
            else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 8) {
                        
                        ForEach(self.msgs) { i in
                            
                            HStack {
                                if i.user == UserDefaults.standard.value(forKey: "uid") as! String {
                                    
                                    Spacer()
                                    
                                    Text(i.msg)
                                        .padding()
                                        .background(Color.blue)
                                        .clipShape(ChatBubble(mymsg: true))
                                        .foregroundColor(.white)
                                }
                                else {
                                    Text(i.msg)
                                        .padding()
                                        .background(Color.green)
                                        .clipShape(ChatBubble(mymsg: false))
                                        .foregroundColor(.white)
                                    
                                    Spacer()
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            
            VStack {
                HStack {
                    
                    Button(action: {
                        // toggling image picker
                        
                    }, label: {
                        Image(systemName: "paperclip")
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                            .frame(width: 35, height: 35)
                            .background(Color.blue)
                            .clipShape(Circle())
                    })
                    
                    TextField("訊息", text: self.$txt)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    if self.txt != "" {
                        Button(action: {
                            withAnimation {
                                sendMsg(user: self.name, uid: self.uid, pic: self.pic, date: Date(), msg: self.txt)
                            }
                            self.txt = ""
                            
                        }) {
                            Image(systemName: "paperplane.fill")
                                .font(.system(size: 18))
                                .foregroundColor(.white)
                                .frame(width: 35, height: 35)
                                .background(Color.blue)
                                .clipShape(Circle())
                        }
                    }
                    
                }
                .padding(.horizontal)
                .frame(height: 60)
                .clipShape(Capsule())
                .animation(.default)
                
            }
            .background(Color.primary.opacity(0.06))
        }
        .navigationBarTitle("\(name)",displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: { self.chat.toggle() }, label: {
                Spacer(minLength: 20)
                Image(systemName: "arrow.left").resizable().frame(width: 20, height: 15)
                
            }))
        .background(Color.primary.opacity(0.06))
        .onAppear { self.getMsgs() }
        .padding(.top, 40)
    }
    
    func getMsgs(){
        
        let db = Firestore.firestore()
        
        let myuid = Auth.auth().currentUser?.uid
        
        db.collection("msgs").document(myuid!).collection(self.uid).order(by: "date", descending: false).addSnapshotListener { (snap, err) in
            
            if err != nil {
                
                print((err?.localizedDescription)!)
                self.nomsgs = true
                return
            }
            
            if snap!.isEmpty {
                
                self.nomsgs = true
            }
            
            for i in snap!.documentChanges {
                
                if i.type == .added {
                    
                    
                    let id = i.document.documentID
                    let msg = i.document.get("msg") as! String
                    let user = i.document.get("user") as! String
                    
                    self.msgs.append(Msg(id: id, msg: msg, user: user))
                }

            }
            print("Load new message")
        }
    }
}

struct ChatBubble : Shape {
    
    var mymsg : Bool
    
    func path(in rect: CGRect) -> Path {
            
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight, mymsg ? .bottomLeft : .bottomRight],  cornerRadii: CGSize(width: 16, height: 16))
        
        return Path(path.cgPath)
    }
}

func sendMsg(user: String,uid: String,pic: String,date: Date,msg: String) {
    
    let db = Firestore.firestore()
    
    let myuid = Auth.auth().currentUser?.uid
    
    db.collection("Owner").document(uid).collection("recents").document(myuid!).getDocument { (snap, err) in
        
        if err != nil {
            
            print((err?.localizedDescription)!)
            // if there is no recents records....
            
            setRecents(user: user, uid: uid, pic: pic, msg: msg, date: date)
            return
        }
        
        if !snap!.exists {
            
            setRecents(user: user, uid: uid, pic: pic, msg: msg, date: date)
            print("Set new chat to recents")
        }
        else {
            
            updateRecents(user: user, uid: uid, pic: pic, msg: msg, date: date)
            print("Update new message to recents")
        }
    }
    
    updateDB(uid: uid, msg: msg, date: date)
    print("Update to each user's database")
}

func setRecents(user: String,uid: String,pic: String,msg: String,date: Date) {
    
    let db = Firestore.firestore()
    
    let myuid = Auth.auth().currentUser?.uid
    
    let myname = UserDefaults.standard.value(forKey: "user") as! String
    
    let mypic = UserDefaults.standard.value(forKey: "pic") as! String
    
    db.collection("Owner").document(uid).collection("recents").document(myuid!).setData(["name": myname, "pic": mypic, "lastmsg": msg, "date": date]) { (err) in
        
        if err != nil {
            
            print((err?.localizedDescription)!)
            return
        }
    }
    
    db.collection("User").document(myuid!).collection("recents").document(uid).setData(["name": user, "pic": pic, "lastmsg": msg, "date": date]) { (err) in
        
        if err != nil {
            
            print((err?.localizedDescription)!)
            return
        }
    }
}

func updateRecents(user: String,uid: String,pic: String,msg: String,date: Date) {
    
    let db = Firestore.firestore()
    
    let myuid = Auth.auth().currentUser?.uid
    
    let myname = UserDefaults.standard.value(forKey: "user") as! String
    
    let mypic = UserDefaults.standard.value(forKey: "pic") as! String
    
    db.collection("Owner").document(uid).collection("recents").document(myuid!).updateData(["name": myname, "pic": mypic, "lastmsg": msg, "date": date])
    
    db.collection("User").document(myuid!).collection("recents").document(uid).updateData(["name": user, "pic": pic, "lastmsg": msg, "date": date])
}

func updateDB(uid: String,msg: String,date: Date) {
    
    let db = Firestore.firestore()
    
    let myuid = Auth.auth().currentUser?.uid
    
    db.collection("msgs").document(uid).collection(myuid!).document().setData(["msg": msg, "user": myuid!, "date": date]) { (err) in
        
        if err != nil{
            
            print((err?.localizedDescription)!)
            return
        }
    }
    
    db.collection("msgs").document(myuid!).collection(uid).document().setData(["msg": msg, "user": myuid!, "date": date]) { (err) in
        
        if err != nil{
            
            print((err?.localizedDescription)!)
            return
        }
    }
}
