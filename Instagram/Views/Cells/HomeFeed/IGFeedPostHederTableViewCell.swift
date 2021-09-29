//
//  IGFeedPostHederTableViewCell.swift
//  Instagram
//
//  Created by Артем Волков on 20.09.2021.
//

import UIKit
import  SDWebImage

protocol IGFeedPostHederTableViewCellDelegate: AnyObject{
    func didTapMoreButton()
    
}

class IGFeedPostHederTableViewCell: UITableViewCell {

    static let identifier = "IGFeedPostHederTableViewCell"
    
    weak var delegate: IGFeedPostHederTableViewCellDelegate?
    
    private let profileImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private let userNameLabel: UILabel = {
       let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let moreButton: UIButton = {
       let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemGray
        contentView.addSubview(moreButton)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(profileImageView)
        moreButton.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
        
    }
    @objc func didTapMoreButton(){
        delegate?.didTapMoreButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: User){
        // configure the cell
        userNameLabel.text = model.userName
        profileImageView.image = UIImage(systemName: "person.circle")
//        profileImageView.sd_setImage(with: model.profilePhoto)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = contentView.heigh - 4
        profileImageView.frame = CGRect(x: 2, y: 2, width: size, height: size)
        profileImageView.layer.cornerRadius = size / 2
        
        moreButton.frame = CGRect(x: contentView.width - size, y: 2, width: size, height: size)
        
        userNameLabel.frame = CGRect(x: profileImageView.right + 10, y: 2, width: contentView.width - (size * 2 ) - 15, height: contentView.heigh)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userNameLabel.text = nil
        profileImageView.image = nil
    }

}
