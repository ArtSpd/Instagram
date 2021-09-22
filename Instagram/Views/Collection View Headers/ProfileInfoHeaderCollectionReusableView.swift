//
//  ProfileInfoHeaderCollectionReusableView.swift
//  Instagram
//
//  Created by Артем Волков on 21.09.2021.
//

import UIKit

protocol ProfileInfoHeaderCollectionReusableViewDelegate: AnyObject {
   
    func profileHeaderDidTapPostsButton(_ headre: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowersButton(_ headre: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowingButton(_ headre: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidEditProfileButton(_ headre: ProfileInfoHeaderCollectionReusableView)
}

class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
    public weak var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?
    
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private let postsBitton: UIButton = {
        let button = UIButton()
        button.setTitle("Posts", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    private let followingBitton: UIButton = {
        let button = UIButton()
        button.setTitle("Following", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    private let followersBitton: UIButton = {
        let button = UIButton()
        button.setTitle("Followers", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    private let editProfileBitton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit your profile", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Artem Volkov"
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.text = "Something interesting"
        label.textColor = .label
        label.numberOfLines = 0 // line wrap
        return label
    }()
    
    
    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBlue
        clipsToBounds = true
        addSubviews()
        addButtonActions()
    }
    
    private func addSubviews(){
        addSubview(profilePhotoImageView)
        addSubview(followingBitton)
        addSubview(followersBitton)
        addSubview(postsBitton)
        addSubview(bioLabel)
        addSubview(nameLabel)
        addSubview(editProfileBitton)
    }
    private func addButtonActions(){
        followersBitton.addTarget(self, action: #selector(didTapFollowersButton), for: .touchUpInside)
        followingBitton.addTarget(self, action: #selector(didTapFollowingsButton), for: .touchUpInside)
        postsBitton.addTarget(self, action: #selector(didTapPostsBitton), for: .touchUpInside)
        editProfileBitton.addTarget(self, action: #selector(didTapFeditProfileBitton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let profilePhotoSize = width / 4
        profilePhotoImageView.frame = CGRect(x: 5, y: 5, width: profilePhotoSize, height: profilePhotoSize).integral
        profilePhotoImageView.layer.cornerRadius = profilePhotoSize / 2
        
        let buttonHeight = profilePhotoSize / 2
        let countBittonWidth = (width - 10 - profilePhotoSize) / 3
        
        postsBitton.frame = CGRect(x: profilePhotoImageView.right, y: 5, width: countBittonWidth, height: buttonHeight).integral
        followersBitton.frame = CGRect(x: postsBitton.right, y: 5, width: countBittonWidth, height: buttonHeight).integral
        followingBitton.frame = CGRect(x: followersBitton.right, y: 5, width: countBittonWidth, height: buttonHeight).integral
        editProfileBitton.frame = CGRect(x: profilePhotoImageView.right, y: 5 + buttonHeight, width: countBittonWidth * 3, height: buttonHeight).integral
        nameLabel.frame = CGRect(x: 5, y: 5 + profilePhotoImageView.bottom, width: width - 10, height: 50).integral
        let bioLabelSize = bioLabel.sizeThatFits(frame.size)
        bioLabel.frame = CGRect(x: 5, y: 5 + nameLabel.bottom, width: width - 10, height: bioLabelSize.height).integral
    }
    
    // MARK: - ACTIONS
    
    @objc private func didTapFollowersButton(){
        delegate?.profileHeaderDidTapFollowersButton(self)
    }
    @objc private func didTapFollowingsButton(){
        delegate?.profileHeaderDidTapFollowingButton(self)
    }
    @objc private func didTapPostsBitton(){
        delegate?.profileHeaderDidTapPostsButton(self)
    }
    @objc private func didTapFeditProfileBitton(){
        delegate?.profileHeaderDidEditProfileButton(self)
    }
}
