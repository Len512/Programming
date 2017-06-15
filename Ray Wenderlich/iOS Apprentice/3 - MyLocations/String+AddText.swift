//
//  String+AddText.swift
//  MyLocations
//
//  Created by Len512 on 15/06/2017.
//  Copyright © 2017 Len512. All rights reserved.
//

import UIKit

extension String {
    mutating func add(text: String?, seperatedBy separator: String = "") {
        if let text = text {
            if !isEmpty {
                self += separator
            }
            self += text
        }
    }
}
