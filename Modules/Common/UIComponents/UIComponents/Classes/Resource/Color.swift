//
//  Color.swift
//  PGFoundation
//
//  Created by 方昱恒 on 2022/2/26.
//

import UIKit

public enum ColorName: String {
    case backgroundColor        = "#dddddd"
    case textColor              = "#333333"
}

public extension UIColor {
    
    static func color(for name: ColorName) -> UIColor {
        .init(hexString: name.rawValue)
    }
    
    convenience init(hexString: String) {
        let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
         
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
         
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
         
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
         
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
         
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
}
