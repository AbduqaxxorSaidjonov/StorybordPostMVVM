//
//  CreateViewController.swift
//  StorybordPost
//
//  Created by Abduqaxxor on 18/7/22.
//

import UIKit

class CreateViewController: BaseViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextField!
    var viewModel = CreateViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }

    func initViews(){
        viewModel.controller = self
        initNavigation()
    }
    
    func initNavigation(){
        let back = UIImage(named: "ic_back")
        let add = UIImage(systemName: "square.and.arrow.up")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: back, style: .plain, target: self, action: #selector(leftTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: add, style: .plain, target: self, action: #selector(rightTapped))
        title = "Create Post"
    }

    @objc func leftTapped(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func rightTapped(){
        viewModel.apiPostCreate(post: Post(title: titleTextField.text!, body: bodyTextField.text!), handler: { isCreated in
            if isCreated{
                self.navigationController?.popViewController(animated: true)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
            }
        })
    }

}
