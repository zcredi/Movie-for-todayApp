//
//  UILabel+App.swift
//  Movie for todayApp
//
//  Created by Владислав on 25.12.2023.
//

import UIKit

extension UILabel {
    convenience init(text: String = "") {
        self.init()
        self.text = text
        self.font = .montserratRegular14()
        self.textColor = .primaryDark
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.5
    }
    
    convenience init(text: String = "", font: UIFont?, textColor: UIColor) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
    }
}
