//
//  CreateViewModel.swift
//  StorybordPost
//
//  Created by Abduqaxxor on 12/8/22.
//

import Foundation
import Bond

class CreateViewModel{
    var controller: BaseViewController!
    
    func apiPostCreate(post: Post, handler: @escaping (Bool) -> (Void)){
        self.controller?.showProgress()
        AFHttp.post(url: AFHttp.API_POST_CREATE, params: AFHttp.paramsPostCreate(post: post), handler: {response in
            self.controller?.hideProgress()
            switch response.result{
            case .success:
                print(response.result)
                handler(true)
            case let .failure(error):
                print(error)
                handler(false)
            }
        })
    }
}
