//
//  NotofocationLikeIventTableViewCell.swift
//  Instagram
//
//  Created by Артем Волков on 23.09.2021.
//

import UIKit
import  SDWebImage

protocol NotofocationLikeIventTableViewCellDelegate: AnyObject {
    func didTapRelatedPostButton(model: UserNotification)
}

class NotofocationLikeIventTableViewCell: UITableViewCell {

    static let identifier = "NotofocationLikeIventTableViewCell"
    
    weak var delegate: NotofocationLikeIventTableViewCellDelegate?
    
    private var model: UserNotification?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "@joe liked your photo"
        return label
    }()
    
    private let postButton: UIButton = {
       let button = UIButton()
        button.setBackgroundImage(UIImage(named: "test"), for: .normal)
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(label)
        contentView.addSubview(profileImageView)
        contentView.addSubview(postButton)
        postButton.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
        selectionStyle = .none
    }
    
    @objc private func didTapPostButton(){
        guard let model = model else { return }
        delegate?.didTapRelatedPostButton(model: model)
    }
    
 
     func configure(with model: UserNotification){
        self.model = model
        
        switch model.type {
        case .like(let post):
            let thumbnail = post.thumbnailImage
            guard !thumbnail.absoluteString.contains("google.com") else { return }
            postButton.sd_setImage(with: thumbnail, for: .normal, completed: nil)
        case .follow:
            break
        }
        label.text = model.text
        profileImageView.sd_setImage(with: model.user.profilePhoto, completed: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postButton.setBackgroundImage(nil, for: .normal)
        label.text = nil
        profileImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //photo, text, post button
        
        profileImageView.frame = CGRect(x: 3, y: 3, width: contentView.heigh - 6, height: contentView.heigh - 6)
        profileImageView.layer.cornerRadius = profileImageView.heigh / 2
        
        let size = contentView.heigh - 4
        postButton.frame = CGRect(x: contentView.width - 5 - size, y: 2, width: size, height: size)
        
        label.frame = CGRect(x: profileImageView.right + 5, y: 0, width: contentView.width - size - profileImageView.width - 16, height: contentView.heigh)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
