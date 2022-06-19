//
//  Double Formatter.swift
//  CountDown-App
//
//  Created by Amin  Bagheri  on 2022-06-15.
//

import Foundation

extension Double {
    var stringWithoutZeroFraction: String {
        return truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
