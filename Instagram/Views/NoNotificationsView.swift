//
//  NoNotificationsView.swift
//  Instagram
//
//  Created by Артем Волков on 22.09.2021.
//

import UIKit

class NoNotificationsView: UIView {
    private let label: UILabel = {
       let label = UILabel()
        label.text = "No notification yet"
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .secondaryLabel
        imageView.image = UIImage(systemName: "bell")
        return imageView
    }()
    
    override func layoutSubviews() {
        superview?.layoutSubviews()
        imageView.frame = CGRect(x: (width - 50 ) / 2, y: 0, width: 50, height: 50).integral
        label.frame = CGRect(x: 0, y: imageView.bottom, width: width, height: heigh - 50).integral
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
