//
//  BloodType.swift
//  CS342-Assignment1
//
//  Created by Merve Cerit on 1/9/25.
//

import SwiftUI
import Foundation
enum BloodType: String, CaseIterable{
    case aplus="A+"
    case aminus="A-"
    case bplus="B+"
    case bminus="B-"
    case abplus="AB+"
    case abminus="AB-"
    case zeroplus="O+"
    case zerominus="O-"
}
extension BloodType:CustomStringConvertible{
    var description: String {
        return rawValue //rawvalue means it will return the strings, right?
    }
}
