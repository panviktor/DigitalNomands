//
//  UILabel+Extension.swift
//  DigitalNomands
//
//  Created by Viktor on 19.01.2021.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont? = .avenir20) {
        self.init()
        self.text = text
        self.font = font
    }
}
