//
//  UIViewExtensions.swift
//  Yummie
//
//  Created by Amin  Bagheri  on 2022-06-06.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.cornerRadius
        }
        set{
            self.layer.cornerRadius = newValue
        }
    }
}
