//
//  ProfileTabsCollectionReusableView.swift
//  Instagram
//
//  Created by Артем Волков on 21.09.2021.
//

import UIKit

protocol ProfileTabsCollectionReusableViewDelegate: AnyObject{
    func didTapGridButton()
    func didTapTaggedButton()
}

class ProfileTabsCollectionReusableView: UICollectionReusableView {
        static let identifier = "ProfileTabsCollectionReusableView"
    
    public weak var delegate: ProfileTabsCollectionReusableViewDelegate?
    
    struct Constants {
        static let padding: CGFloat = 8
    }
    
    private let gridButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .systemBlue
        button.setBackgroundImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
        return button
    }()
    
    private let tagButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .lightGray
        
        button.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        addSubview(tagButton)
        addSubview(gridButton)
        gridButton.addTarget(self, action: #selector(didTapGridButton), for: .touchUpInside)
        tagButton.addTarget(self, action: #selector(didTapTagButton), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = heigh - (Constants.padding * 2)
        let gridButtonX = (width / 2 - size)/2
        gridButton.frame = CGRect(x: gridButtonX, y: Constants.padding, width: size, height: size)
        tagButton.frame = CGRect(x: gridButtonX + (width / 2), y: Constants.padding, width: size, height: size)
    }
    
    @objc private func didTapGridButton(){
        gridButton.tintColor = .systemBlue
        tagButton.tintColor = .lightGray
        delegate?.didTapGridButton()
    }
    @objc private func didTapTagButton(){
        gridButton.tintColor = .lightGray
        tagButton.tintColor = .systemBlue
        delegate?.didTapTaggedButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
