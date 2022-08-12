//
//  EditViewController.swift
//  StorybordPost
//
//  Created by Abduqaxxor on 18/7/22.
//

import UIKit

class EditViewController: BaseViewController {
    
    @IBOutlet weak var editTitle: UITextField!
    @IBOutlet weak var editBody: UITextField!
    var viewModel = EditViewModel()
    var POSTID: String = "1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }

    func initViews(){
            initNavigation()
        viewModel.apiSinglePost(id: POSTID)
        viewModel.controller = self
    }
    
    func initNavigation(){
        let back = UIImage(named: "ic_back")
        let add = UIImage(systemName: "square.and.arrow.down")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: back, style: .plain, target: self, action: #selector(leftTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: add, style: .plain, target: self, action: #selector(rightTapped))
        title = "Edit Post"
    }

    @objc func leftTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func rightTapped(){
        viewModel.apiPostUpdate(id: POSTID,post: Post(title: editTitle.text!, body: editBody.text!))
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "edit"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
