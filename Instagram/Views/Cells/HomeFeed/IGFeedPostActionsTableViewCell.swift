//
//  IGFeedPostActionsTableViewCell.swift
//  Instagram
//
//  Created by Артем Волков on 20.09.2021.
//

import UIKit

protocol IGFeedPostActionsTableViewCellDelegate: AnyObject{
    func didTapLikeButton()
    func didTapCommentButton()
    func didTapSendButton()
}

class IGFeedPostActionsTableViewCell: UITableViewCell {

    
    static let identifier = "IGFeedPostActionsTableViewCell"
    
    private let likeButton: UIButton = {
       let button = UIButton()
        let congig = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        let image = UIImage(systemName: "heart", withConfiguration: congig)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    weak var deleagte: IGFeedPostActionsTableViewCellDelegate?
    
    private let commentButton: UIButton = {
       let button = UIButton()
        let congig = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        button.setImage(UIImage(systemName: "message", withConfiguration: congig), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let sendButton: UIButton = {
       let button = UIButton()
        let congig = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        button.setImage(UIImage(systemName: "paperplane", withConfiguration: congig), for: .normal)
        button.tintColor = .label
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(sendButton)
        
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(didTapCommentButton), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)

    }
    
    @objc private func didTapLikeButton(){
        deleagte?.didTapLikeButton()
    }
    
    @objc private func didTapCommentButton(){
        deleagte?.didTapCommentButton()
    }
    
    @objc private func didTapSendButton(){
        deleagte?.didTapSendButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func configure(with post: UserPost){
        // configure the cell
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let buttonSize = contentView.heigh - 10
        
        //like, comment and send
        
        let buttons = [likeButton, commentButton, sendButton]
        
        for x in 0..<buttons.count{
            let button = buttons[x]
            button.frame = CGRect(x: CGFloat(x)*buttonSize, y: 5, width: buttonSize, height: buttonSize)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
}
