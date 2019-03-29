//
//  Circle.swift
//  Touch
//
//  Created by 张一唯 on 2019-03-27.
//  Copyright © 2019 Yiwei. All rights reserved.
//

import Foundation
import CoreGraphics

class Circle {
    var centre = CGPoint.zero
    var radius: CGFloat = 40.0
    var EVx :CGFloat = 0.0
    var EVy :CGFloat = 0.0
    var Ax:CGFloat = 0.0
    var Ay:CGFloat = 0.0

    init () {}
    init  (centre c:CGPoint,radius r:CGFloat){
        self.centre = c
        self.radius = r
    }
    init  (centre c:CGPoint,radius r:CGFloat,
           velocityX Vx:CGFloat,velocityY Vy:CGFloat,
           accelerationX Ax:CGFloat,accelerationY Ay:CGFloat ){
        self.centre = c
        self.radius = r
        self.EVx = Vx
        self.EVy = Vy
        
        self.Ax = Ax
        self.Ay = Ay
    }
    
    func distanceToPoint(point: CGPoint) -> CGFloat {
        let xDist = centre.x - point.x
        let yDist = centre.y - point.y
        return CGFloat(sqrt((xDist * xDist) + (yDist * yDist)))
    }
    
    func containsPoint(point:CGPoint) -> Bool {
        return distanceToPoint(point: point) <= radius
    }
    func advanceInArea(area: CGRect){
        if (centre.x-radius < 0) || (centre.x+radius > area.width){
            self.EVx = -self.EVx
        }
        if (centre.y-radius < 0) || (centre.y+radius > area.height){
            self.EVy = -self.EVy
        }
      
        if pow(EVx,2)+pow(EVy,2) < 0.5*pow(2,0.5) {
            self.EVx = 0
            self.EVy = 0
            return
        } else {
           
        }
        if self.EVx < -0.5 {
            self.Ax = 0.5
        } else if self.EVx > 0.5 {
            self.Ax = -0.5
        }
        
        if self.EVy < -0.5 {
            self.Ay = 0.5
        } else if self.EVy > 0.5 {
            self.Ay = -0.5
        }
        let delta:CGFloat = 1
        self.EVx += self.Ax
        self.EVy += self.Ay
        self.centre.x += delta * self.EVx
        self.centre.y += delta * self.EVy
    
    }

}
