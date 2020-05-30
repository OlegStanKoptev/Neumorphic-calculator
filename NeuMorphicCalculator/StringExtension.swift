//
//  StringExtension.swift
//  NeuMorphicCalculator
//
//  Created by Oleg Koptev on 30.05.2020.
//  Copyright © 2020 Oleg Koptev. All rights reserved.
//

import Foundation

extension String {
    func countNumbers() -> Int {
        var counter = 0
        for letter in self {
            if letter.isNumber {
                counter += 1
            }
        }
        return counter
    }
}

extension Double {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
