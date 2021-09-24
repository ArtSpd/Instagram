//
//  NotificationFollowInventTableViewCell.swift
//  Instagram
//
//  Created by Артем Волков on 23.09.2021.
//

import UIKit

protocol NotificationFollowInventTableViewCellDElegate: AnyObject {
    func didTapFollowButton(model: UserNotification)
}

class NotificationFollowInventTableViewCell: UITableViewCell {

    static let identifier = "NotificationFollowInventTableViewCell"
    
    private var model: UserNotification?
    
    weak var delegate: NotificationFollowInventTableViewCellDElegate?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .systemBackground
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "@kanywest followed to you "
        return label
    }()
    
    private let followButton: UIButton = {
       let button = UIButton()
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(label)
        contentView.addSubview(profileImageView)
        contentView.addSubview(followButton)
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
        configureForFollow()
        
        selectionStyle = .none
    }
    
    @objc private func didTapFollowButton(){
        guard let model = model  else {
            return
        }
        delegate?.didTapFollowButton(model: model)
    }
    
    func configure(with model: UserNotification){
       self.model = model
       
       
       switch model.type {
       case .like(_):
           break
       case .follow(let state):
        //config button
        switch state {
        case .following:
            //show unfollow button
            configureForFollow()
        case .notFollowing:
            //show follow button
            followButton.setTitle("Follow", for: .normal)
            followButton.setTitleColor(.white, for: .normal)
            followButton.backgroundColor = .link
        }
           break
       }
       label.text = model.text
       profileImageView.sd_setImage(with: model.user.profilePhoto, completed: nil)
   }
    
    private func configureForFollow(){
        followButton.setTitle("Unfollow", for: .normal)
        followButton.setTitleColor(.label, for: .normal)
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
        label.text = nil
        profileImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //photo, text, post button
        
        profileImageView.frame = CGRect(x: 3, y: 3, width: contentView.heigh - 6, height: contentView.heigh - 6)
        profileImageView.layer.cornerRadius = profileImageView.heigh / 2
        
        let size: CGFloat = 100
        let buttonHeight: CGFloat = 40
        followButton.frame = CGRect(x: contentView.width - 5 - size, y: (contentView.heigh - buttonHeight) / 2, width: 100, height: buttonHeight)
        
        label.frame = CGRect(x: profileImageView.right + 5, y: 0, width: contentView.width - size - profileImageView.width - 16, height: contentView.heigh) 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
