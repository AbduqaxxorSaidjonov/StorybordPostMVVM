//
//  HomeViewController.swift
//  StorybordPost
//
//  Created by Abduqaxxor on 18/7/22.
//

import UIKit

class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var TableView: UITableView!
    var postId: String = ""
    var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
    }
    
    func initViews(){
        TableView.dataSource = self
        TableView.delegate = self
        initNavigation()
        bindViewModel()
        viewModel.apiPostList()
        refreshView()
    }

    func bindViewModel(){
        viewModel.controller = self
        viewModel.items.bind(to: self){ strongSelf, _ in
            strongSelf.TableView.reloadData()
            
        }
    }
    
    func initNavigation(){
        let refresh = UIImage(named: "ic_refresh")
        let add = UIImage(named: "ic_add")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: refresh, style: .plain, target: self, action: #selector(leftTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: add, style: .plain, target: self, action: #selector(rightTapped))
        title = "Storyboard MVVM"
    }
    
    func callCreateViewController(){
    let vc = CreateViewController(nibName: "CreateViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func callEditViewController(id: String){
        let vc = EditViewController(nibName: "EditViewController", bundle: nil)
        vc.POSTID = id
        let navigationController = UINavigationController(rootViewController: vc)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func refreshView(){
        NotificationCenter.default.addObserver(self, selector: #selector(doThisWhenNotifyLoad(notification: )), name: NSNotification.Name(rawValue: "load"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(doThisWhenNotifyEdit(notification: )), name: NSNotification.Name(rawValue: "edit"), object: nil)
    }
    
    // MARK: - Action
    
    @objc func leftTapped(){
        viewModel.apiPostList()
    }
    
    @objc func rightTapped(){
        callCreateViewController()
    }
    
    @objc func doThisWhenNotifyLoad(notification : NSNotification) {
            //update tableview
        self.viewModel.apiPostList()
    }
    
    @objc func doThisWhenNotifyEdit(notification : NSNotification) {
            //update tableview
        self.viewModel.apiPostList()
    }
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return viewModel.items.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let item = viewModel.items.value[indexPath.row]
        
        let cell = Bundle.main.loadNibNamed("PostTableViewCell", owner: self,options: nil)?.first as! PostTableViewCell
        cell.titleLabel.text = item.title
        cell.bodylabel.text = item.body
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [makeCompleteContextualAction(forRowAt: indexPath, post: viewModel.items.value[indexPath.row])
        ])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [makeDeleteContextualAction(forRowAt: indexPath, post: viewModel.items.value[indexPath.row])
        ])
    }
    
    func makeDeleteContextualAction(forRowAt indexPath: IndexPath, post: Post) -> UIContextualAction{
        return UIContextualAction(style: .destructive, title: "Delete"){ (action, swipeButtonView, completion) in
            print("Delete Here")
            completion(true)
            self.viewModel.apiPostDelete(post: post, handler: { isDeleted in
                if isDeleted{
                    self.viewModel.apiPostList()
                }
                
            })
        }
    }
    
    func makeCompleteContextualAction(forRowAt indexPath: IndexPath, post: Post) -> UIContextualAction{
        return UIContextualAction(style: .normal, title: "Edit"){ (action, swipeButtonView, completion) in
            print("Complete Here")
            completion(true)
            self.callEditViewController(id: post.id!)
        }
    }
}
