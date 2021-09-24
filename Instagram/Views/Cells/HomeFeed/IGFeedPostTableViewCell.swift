//
//  IGFeedPostTableViewCell.swift
//  Instagram
//
//  Created by Артем Волков on 20.09.2021.
//

import UIKit

final class IGFeedPostTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .secondarySystemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(){
        // configure the cell
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}
