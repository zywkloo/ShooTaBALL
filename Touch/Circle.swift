//
//  Circle.swift
//  Touch
//
//  Created by 张一唯 on 2019-03-27.
//  Copyright © 2019 Yiwei. All rights reserved.
//

import Foundation
import CoreGraphics

struct Circle {
    var centre = CGPoint.zero
    var radius: CGFloat = 40.0
    
    func distanceToPoint(point: CGPoint) -> CGFloat {
        let xDist = centre.x - point.x
        let yDist = centre.y - point.y
        return CGFloat(sqrt((xDist * xDist) + (yDist * yDist)))
    }
    
    func containsPoint(point:CGPoint) -> Bool {
        return distanceToPoint(point: point) <= radius
    }
    mutating func advanceInArea(area: CGRect){
        //...
    }
    
}
