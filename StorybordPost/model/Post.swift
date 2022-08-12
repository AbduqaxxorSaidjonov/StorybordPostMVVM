//
//  Post.swift
//  StorybordPost
//
//  Created by Abduqaxxor on 18/7/22.
//

import Foundation
import UIKit

struct Post: Decodable{
    var id: String? = ""
    var title: String? = ""
    var body: String? = ""
    
    init(){
        
    }
    
    init(title: String, body: String){
        self.title = title
        self.body = body
    }
}
