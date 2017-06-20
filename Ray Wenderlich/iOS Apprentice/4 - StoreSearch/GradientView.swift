//
//  GradientView.swift
//  StoreSearch
//
//  Created by Len512 on 19/06/2017.
//  Copyright © 2017 Len512. All rights reserved.
//

import UIKit

class GradientView: UIView {
    // Set the background colour to fully transparent
    // and autoresize when the superview it belongs to resizes
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    // Set the background colour to fully transparent
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.clear
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    override func draw(_ rect: CGRect) {
        
        let components: [CGFloat] = [0, 0, 0, 0.3, 0, 0, 0, 0.7]
        let locations: [CGFloat] = [0, 1]
        
        let colourSpace = CGColorSpaceCreateDeviceRGB()
        let gradient  = CGGradient(colorSpace: colourSpace, colorComponents: components, locations: locations, count: 2)
        
        let x = bounds.midX
        let y = bounds.midY
        let centrePoint = CGPoint(x: x, y: y)
        let radius = max(x, y)
        
        let context = UIGraphicsGetCurrentContext()
        context?.drawRadialGradient(gradient!, startCenter: centrePoint, startRadius: 0, endCenter: centrePoint, endRadius: radius, options: .drawsAfterEndLocation)
    }
}
