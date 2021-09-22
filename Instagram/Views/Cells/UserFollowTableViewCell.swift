//
//  UserFollowTableViewCell.swift
//  Instagram
//
//  Created by Артем Волков on 22.09.2021.
//

import UIKit

protocol UserFollowTableViewCellDelegate: AnyObject {
    func didTapFollowButton(model: String)
}

class UserFollowTableViewCell: UITableViewCell {

    static let identifier = "UserFollowTableViewCell"
    
    weak var delegate: UserFollowTableViewCellDelegate?
    
    private let profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    private let usernameLAbel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let followButton : UIButton = {
        let button = UIButton()
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(usernameLAbel)
        contentView.addSubview(followButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    public func configure(with model: String){
        
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
