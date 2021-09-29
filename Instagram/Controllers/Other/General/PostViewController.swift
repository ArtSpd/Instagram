//
//  PostViewController.swift
//  Instagram
//
//  Created by Артем Волков on 19.09.2021.
//

import UIKit
//States of render cell

enum PostRenderType {
    case header(provider: User)
    case primaruConten(provider: UserPost)
    case actions(provider: String) // like button, comment, share
    case comments(comments: [PostComment])
}
// Model of render post
struct PostRenderViewModel {
    let renderType: PostRenderType
}
class PostViewController: UIViewController {
    
    private let model: UserPost?
    private var renderModels = [PostRenderViewModel]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        
        //register cell
        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tableView.register(IGFeedPostHederTableViewCell.self, forCellReuseIdentifier: IGFeedPostHederTableViewCell.identifier)
        tableView.register(IGFeedPostActionsTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identifier)
        tableView.register(IGFeedPost_GeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPost_GeneralTableViewCell.identifier)
        
        return tableView
    }()
    
    init(model: UserPost  ){
        self.model = model
        super.init(nibName:  nil, bundle: nil)
        configureModels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureModels(){
        guard let userPostMode = self.model else { return }
        //Header
        renderModels.append(PostRenderViewModel(renderType: .header(provider: userPostMode.owner)))
        // Post
        renderModels.append(PostRenderViewModel(renderType: .primaruConten(provider: userPostMode)))
        // Actions
        renderModels.append(PostRenderViewModel(renderType: .actions(provider: "")))
        //Comments
        var comments = [PostComment]()
        for comment in 0..<4{
            comments.append(PostComment(identifier: "123", userName: "Antony", text: "Hi everyone", createdDate: Date.init(), postlike: [PostLike(userName: "Joe", commentIdentifier: "Cool")]))
        }
        renderModels.append(PostRenderViewModel(renderType: .comments(comments: comments)))
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Post"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
}

extension PostViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderModels.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch renderModels[section].renderType{
        case .actions(_): return 1
        case .header(_): return 1
        case .comments( let comments): return comments.count > 4 ? 4 : comments.count
        case .primaruConten(_): return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = renderModels[indexPath.section]
        switch model.renderType {
        case .actions(let actions):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier, for: indexPath) as! IGFeedPostActionsTableViewCell
            return cell
        case .header(let user):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHederTableViewCell.identifier, for: indexPath) as! IGFeedPostHederTableViewCell
            return cell
        case .comments( let comments):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPost_GeneralTableViewCell.identifier, for: indexPath) as! IGFeedPost_GeneralTableViewCell
            return cell
        case .primaruConten(let post):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = renderModels[indexPath.section]
        
        switch model.renderType{
        case .actions(_): return 60
        case .header(_): return 70
        case .comments(_): return 50
        case .primaruConten(_): return tableView.width
        }
    }
}
