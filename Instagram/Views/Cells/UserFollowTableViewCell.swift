//
//  UserFollowTableViewCell.swift
//  Instagram
//
//  Created by Артем Волков on 22.09.2021.
//

import UIKit

protocol UserFollowTableViewCellDelegate: AnyObject {
    func didTapFollowButton(model: UserRealtionship)
}

enum FollowState {
    case following, notFollowing
}
struct UserRealtionship {
    let userName: String
    let name: String
    let type: FollowState
}

class UserFollowTableViewCell: UITableViewCell {

    static let identifier = "UserFollowTableViewCell"
    
    private var model: UserRealtionship?
    
    weak var delegate: UserFollowTableViewCellDelegate?
    
    private let profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Joe"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    private let usernameLAbel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "@Joe"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let followButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .link
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(usernameLAbel)
        contentView.addSubview(followButton)
        selectionStyle = .none
        followButton.addTarget(self, action: #selector(didTApFollowButton), for: .touchUpInside)
    }
    
    @objc private func didTApFollowButton(){
        guard let model = model else { return }
        delegate?.didTapFollowButton(model: model)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.frame = CGRect(x: 3, y: 3, width: contentView.heigh - 6, height: contentView.heigh - 6)
        profileImageView.layer.cornerRadius = profileImageView.heigh / 2
        
        let buttonWidth = contentView.width > 500 ? 220 : contentView.width / 3
        
        followButton.frame = CGRect(x: contentView.width - 5 - buttonWidth, y: (contentView.heigh - 40)/2, width: buttonWidth, height: 40)
        
        let labelHeight = contentView.heigh / 2
        
        nameLabel.frame = CGRect(x: profileImageView.right + 5, y: 0, width: contentView.width - 8 - profileImageView.width - buttonWidth, height: labelHeight)
        usernameLAbel.frame = CGRect(x: profileImageView.right + 5, y: nameLabel.bottom, width: contentView.width - 8 - profileImageView.width - buttonWidth, height: labelHeight)
        
    }
    
    public func configure(with model: UserRealtionship){
        self.model = model
        nameLabel.text = model.name
        usernameLAbel.text = model.userName
        switch model.type {
        case .following:
            //show unfol button
            followButton.setTitle("Unfollow", for: .normal)
            followButton.backgroundColor = .systemBackground
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.label.cgColor
            followButton.setTitleColor(.label, for: .normal)
        case .notFollowing:
        //show follow button
            followButton.setTitle("Follow", for: .normal)
            followButton.backgroundColor = .link
            followButton.layer.borderWidth = 0
            followButton.setTitleColor(.white, for: .normal)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        nameLabel.text = nil
        usernameLAbel.text = nil
        followButton.setTitle(nil, for: .normal)
        followButton.layer.borderWidth = 0
        followButton.backgroundColor = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
