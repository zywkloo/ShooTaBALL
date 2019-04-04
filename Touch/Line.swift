//
//  Line.swift
//  Touch
//
//  Created by 张一唯 on 2019-03-26.
//  Copyright © 2019 Yiwei. All rights reserved.
//


import Foundation
import CoreGraphics

class Line {
    var begin = CGPoint.zero
    var len:CGFloat = 0
    @IBInspectable var end = CGPoint.zero{
        didSet {
            self.len = distance(self.begin, self.end)
        }
    }
    init () {}
    init(begin b: CGPoint, end e:CGPoint){
        self.begin = b
        self.end = e
        self.len = distance(begin, end)
    }
    
    func distance(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
        let xDist = a.x - b.x
        let yDist = a.y - b.y
        return CGFloat(sqrt(xDist * xDist + yDist * yDist))
    }

}
