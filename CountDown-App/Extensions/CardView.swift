
//  CardView.swift
//  Yummie
//
//  Created by Amin  Bagheri  on 2022-06-08.
//

import Foundation
import UIKit

class CardView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }
    
    private func initialSetup() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.cornerRadius = 10
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10
        cornerRadius = 10
    }
    
    
}

