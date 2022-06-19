//
//  Int Extension.swift
//  CountDown-App
//
//  Created by Amin  Bagheri  on 2022-06-15.
//

import Foundation

public extension Int {
/// returns number of digits in Int number
public var digitCount: Int {
    get {
        return numberOfDigits(in: self)
    }
}
/// returns number of useful digits in Int number
public var usefulDigitCount: Int {
    get {
        var count = 0
        for digitOrder in 0..<self.digitCount {
            /// get each order digit from self
            let digit = self % (Int(truncating: pow(10, digitOrder + 1) as NSDecimalNumber))
                / Int(truncating: pow(10, digitOrder) as NSDecimalNumber)
            if isUseful(digit) { count += 1 }
        }
        return count
    }
}
// private recursive method for counting digits
private func numberOfDigits(in number: Int) -> Int {
    if number < 10 && number >= 0 || number > -10 && number < 0 {
        return 1
    } else {
        return 1 + numberOfDigits(in: number/10)
    }
}
// returns true if digit is useful in respect to self
private func isUseful(_ digit: Int) -> Bool {
    return (digit != 0) && (self % digit == 0)
}
}
