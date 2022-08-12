//
//  EditViewModel.swift
//  StorybordPost
//
//  Created by Abduqaxxor on 12/8/22.
//

import Foundation
import Bond

class EditViewModel{
    
    var controller: BaseViewController!
    var viewController: EditViewController!
    
    func apiSinglePost(id: String){
        
        self.controller?.showProgress()
        AFHttp.get(url: AFHttp.API_POST_SINGLE + id, params: AFHttp.paramsEmpty(), handler: {response in
            self.controller?.hideProgress()
            switch response.result{
            case .success:
                let posts = try! JSONDecoder().decode(Post.self, from: response.data!)
            case let .failure(error):
                print(error)
            }
        })
    }
    
    func apiPostUpdate(id: String, post: Post){
        self.controller?.showProgress()
        AFHttp.put(url: AFHttp.API_POST_UPDATE + id, params: AFHttp.paramsPostUpdate(post: post), handler: {response in
            self.controller?.hideProgress()
            switch response.result{
            case .success:
                print(response.result)
            case let .failure(error):
                print(error)
            }
        })
    }
}
