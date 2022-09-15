//
//  ArrayExtentions.swift
//  Pokedex
//
//  Created by Sem Koliesnikov on 15/09/2022.
//

import Foundation

extension Array {
    subscript (randomPick n: Int) -> [Element] {
        var copy = self
        for i in stride(from: count - 1, to: count - n - 1, by: -1) {
            copy.swapAt(i, Int(arc4random_uniform(UInt32(i + 1))))
        }
        return Array(copy.suffix(n))
    }
}
