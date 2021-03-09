//
//  ViewRouter.swift
//  MyApp
//
//  Created by 阿揆 on 2021/3/5.
//

import Foundation

class ViewRouter: ObservableObject{
    
    @Published var currentPage: Page = .cover
    
}

enum Page {
    
    case cover
    case main
    case newMember
}
