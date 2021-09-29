//
//  ViewController.swift
//  Instagram
//
//  Created by Артем Волков on 19.09.2021.
//

import UIKit
import FirebaseAuth

struct HomeFeedRenderViewModel {
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let actions: PostRenderViewModel
    let comments: PostRenderViewModel
}

class HomeViewController: UIViewController {
    
    private var feedRenderModels = [HomeFeedRenderViewModel]()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        //register cell
        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tableView.register(IGFeedPostHederTableViewCell.self, forCellReuseIdentifier: IGFeedPostHederTableViewCell.identifier)
        tableView.register(IGFeedPostActionsTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identifier)
        tableView.register(IGFeedPost_GeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPost_GeneralTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        createMockModels()
    }
    
    private func createMockModels(){
        let user = User(userName: "joe", bio: "", name: (first: "", second: ""), birthDate: Date(), gender: .female, counts: UserCount(followers: 12, following: 32, post: 321), joinDate: Date(), profilePhoto: URL(string: "https://www.google.com")!)
        let post = UserPost(identifier: "", postType: .photo, thumbnailImage: URL(string: "https://www.google.com")!, postURL: URL(string: "https://www.google.com")!, caption: nil, likeCount: [], comments: [], postedDate: Date(), taggedUsers: [],
                            owner: user)
        var commentsz = [PostComment]()
        
        for x in 0..<2{
            commentsz.append(PostComment(identifier: "123", userName: "Antony", text: "Hi everyone", createdDate: Date.init(), postlike: [PostLike(userName: "Joe", commentIdentifier: "Cool")]))
        }
        for x in 0..<5{
            let viewModel = HomeFeedRenderViewModel(header: PostRenderViewModel(renderType: .header(provider: user)),
                                                    post: PostRenderViewModel(renderType: .primaruConten(provider: post)),
                                                    actions: PostRenderViewModel(renderType: .actions(provider: "123")),
                                                    comments: PostRenderViewModel(renderType: .comments(comments: commentsz)))
            feedRenderModels.append(viewModel)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNotAuth()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    private func handleNotAuth(){
        //check auth status
        if Auth.auth().currentUser == nil{
            //Showe login
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedRenderModels.count * 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        switch renderModels[section].renderType{
        //        case .actions(_): return 1
        //        case .header(_): return 1
        //        case .comments( let comments): return comments.count > 4 ? 4 : comments.count
        //        case .primaruConten(_): return 1
        //        }
        
        let x = section
        let model: HomeFeedRenderViewModel
        if x == 0{
            model = feedRenderModels[0]
        } else {
            let position = x % 4 == 0 ? x/4 : ((x - (x/4)) / 4)
            model = feedRenderModels[position]
        }
        
        let subSection = x % 4
        
        if subSection == 0{
            // header
            return 1
        } else if subSection == 1{
            //post
            return 1
        } else if subSection == 2{
            //actions
            return 1
        } else if subSection == 3{
            //comments
            let commentsModel = model.comments
            switch commentsModel.renderType {
            case .comments(let comment):
                return comment.count > 2 ? 2 : comment.count
            case .header, .actions, .primaruConten: return 0
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let x = indexPath.section
        let model: HomeFeedRenderViewModel
        if x == 0{
            model = feedRenderModels[0]
        } else {
            let position = x % 4 == 0 ? x/4 : ((x - (x/4)) / 4)
            model = feedRenderModels[position]
        }
        
        
        let subSection = x % 4
        
        if subSection == 0{
            // header
            let headerModel = model.header
            
            switch headerModel.renderType {
            case .header(let user):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHederTableViewCell.identifier, for: indexPath) as! IGFeedPostHederTableViewCell
                cell.configure(with: user)
                cell.delegate = self
                return cell
            case .actions, .comments, .primaruConten: return UITableViewCell()
            }
        } else if subSection == 1{
            //post
            let postModel = model.post
            
            switch postModel.renderType {
            case .primaruConten(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
                cell.configure(with: post)
                return cell
            case .actions, .comments, .header: return UITableViewCell()
            }
        } else if subSection == 2{
            //actions
            let actionModel = model.actions
            
            switch actionModel.renderType {
            case .actions(let provider):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier, for: indexPath) as! IGFeedPostActionsTableViewCell
                
                cell.deleagte = self
                return cell
            case .primaruConten, .comments, .header: return UITableViewCell()
            }
            
        } else if subSection == 3{
            //comments
            let commentModel = model.comments
            
            
            switch commentModel.renderType {
            case .comments(let comment):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPost_GeneralTableViewCell.identifier, for: indexPath) as! IGFeedPost_GeneralTableViewCell
                return cell
            case .actions, .primaruConten, .header: return UITableViewCell()
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let subSection = indexPath.section % 4
        
        if subSection == 0{
            // header
            return 70
        } else if subSection == 1{
            //post
            return tableView.width
        } else if subSection == 2{
            //actions
            return 60
        } else if subSection == 3{
            return 50
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let subSection = section % 4
        return subSection == 3 ? 70 : 0
    }
}

extension HomeViewController: IGFeedPostHederTableViewCellDelegate{
    func didTapMoreButton() {
        let actionSheet = UIAlertController(title: "Post options", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Report Post", style: .destructive, handler: { [weak self] _ in
            self?.reportPost()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "cancel", style: .cancel))
        
        present(actionSheet, animated: true)
    }
    
    func reportPost(){
        
    }
    
    
}


extension HomeViewController: IGFeedPostActionsTableViewCellDelegate{
    func didTapLikeButton() {
        print("like")
    }
    
    func didTapCommentButton() {
        print("comment")
    }
    
    func didTapSendButton() {
        print("send")
    }
    
    
}
