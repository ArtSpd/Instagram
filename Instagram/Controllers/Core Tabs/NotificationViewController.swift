//
//  NotificationViewController.swift
//  Instagram
//
//  Created by Артем Волков on 19.09.2021.
//

import UIKit

enum UserNotificationType {
    case like(post: UserPost), follow(state: FollowState)
}

struct UserNotification {
    let type: UserNotificationType
    let text: String
    let user: User
}

class NotificationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
      
    private var tableview: UITableView = {
        let tableView = UITableView()
//        tableView.isHidden = true
        tableView.register(NotofocationLikeIventTableViewCell.self, forCellReuseIdentifier: NotofocationLikeIventTableViewCell.identifier)
        tableView.register(NotificationFollowInventTableViewCell.self, forCellReuseIdentifier: NotificationFollowInventTableViewCell.identifier)
        return tableView
    }()
    
    private lazy var noNotificationsView = NoNotificationsView()
    private var models = [UserNotification]()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        return spinner
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNotifications()
        navigationItem.title = "Notification"
        view.backgroundColor = .systemBackground
        view.addSubview(tableview)
        view.addSubview(spinner)
//        spinner.startAnimating()
        tableview.delegate = self
        tableview.dataSource = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = view.bounds
//        addnoNotificationsViewLayout()
        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spinner.center = view.center
    }
    
    private func fetchNotifications(){
        for x in 0..<100{
            let user = User(userName: "joe", bio: "", name: (first: "", second: ""), birthDate: Date(), gender: .female, counts: UserCount(followers: 12, following: 32, post: 321), joinDate: Date(), profilePhoto: URL(string: "https://www.google.com")!)
            let post = UserPost(identifier: "", postType: .photo, thumbnailImage: URL(string: "https://www.google.com")!, postURL: URL(string: "https://www.google.com")!, caption: nil, likeCount: [], comments: [], postedDate: Date(), taggedUsers: [],
                                owner: user)
            let model = UserNotification(type: x % 2 == 0 ? .like(post: post) : .follow(state: .following) , text: "Hello world", user: user)
            models.append(model)
        }
        
    }
    
    private func addnoNotificationsViewLayout(){
        tableview.isHidden = true
        view.addSubview(tableview)
        noNotificationsView.frame = CGRect(x: 0, y: 0, width: view.width / 2, height: view.width / 4)
        noNotificationsView.center = view.center
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        switch model.type {
        case .like(_):
            //like cell
            let cell = tableview.dequeueReusableCell(withIdentifier: NotofocationLikeIventTableViewCell.identifier, for: indexPath) as! NotofocationLikeIventTableViewCell
            cell.configure(with: model)
            cell.delegate = self
            return cell
        case .follow(_):
            //follow cell
            let cell = tableview.dequeueReusableCell(withIdentifier: NotificationFollowInventTableViewCell.identifier, for: indexPath) as! NotificationFollowInventTableViewCell
            cell.configure(with: model)
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
}

extension NotificationViewController: NotofocationLikeIventTableViewCellDelegate{
    func didTapRelatedPostButton(model: UserNotification) {
        print("tapped post")
        switch model.type {
        case .like(let post):
            let vc = PostViewController(model: post)
            vc.title = post.postType.rawValue
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        case .follow(_):
            fatalError("Dev issue should never get called")
        }
        
    
        
    }
  
}
extension NotificationViewController: NotificationFollowInventTableViewCellDElegate{
    func didTapFollowButton(model: UserNotification) {
        print("tapped button")
    }
    
}


