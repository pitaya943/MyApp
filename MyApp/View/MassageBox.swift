//
//  MassageBox.swift
//  MyApp
//
//  Created by 阿揆 on 2021/2/24.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct MassageBox: View {
    
    @EnvironmentObject var datas: ChatObservable
    
    var body: some View {
        
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing: 12) {
                    
                    ForEach(datas.recents) { item in
                        RecentCellView(url: item.pic, name: item.name, time: item.time, date: item.date, lastmsg: item.lastmsg)
                    }
                    .padding()
                    
                }
            }
        }
        
    }
}

struct RecentCellView : View {
    
    var url : String
    var name : String
    var time : String
    var date : String
    var lastmsg : String
    
    var body : some View{
        
        HStack{
            
            AnimatedImage(url: URL(string: url)!)
                .resizable()
                .renderingMode(.original)
                .frame(width: 55, height: 55)
                .clipShape(Circle())
            
            VStack{
                
                HStack{
                    
                    VStack(alignment: .leading, spacing: 6) {
                        
                        Text(name).foregroundColor(.black)
                        Text(lastmsg).foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .center, spacing: 6) {
                        
                         Text(time).foregroundColor(.gray)
                         Text(date).foregroundColor(.gray)
                    }
                }
                
                Divider()
            }
        }
    }
}

struct MassageBox_Previews: PreviewProvider {
    static var previews: some View {
        MassageBox()
    }
}
