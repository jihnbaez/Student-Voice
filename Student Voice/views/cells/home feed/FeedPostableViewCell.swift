//
//  FeedPostableViewCell.swift
//  Student Voice
//
//  Created by 6f on 4/27/23.
//

import UIKit

final class FeedPostableViewCell: UITableViewCell {
    
    static let identifier = "FeedPostableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func configure() {
        // configure the cell
    }
}
