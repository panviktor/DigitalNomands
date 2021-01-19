//
//  ArticleCell.swift
//  DigitalNomands
//
//  Created by Viktor on 19.01.2021.
//

import UIKit

class ArticleCell: UITableViewCell {
    static var reuseID: String = "ArticleCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
