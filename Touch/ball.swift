//
//  ball.swift
//  Recursion
//
//  Created by 张一唯 on 2019-03-14.
//  Copyright © 2019 Yiwei. All rights reserved.
//

import Foundation

class Ball {
    private var color:String = "red"
    
    private var Inix:Float  //initial X, Y , vertical and horizontal vecolity
    private var Iniy:Float
    private var IniVx:Float
    private var IniVy:Float
    
    private var Ex:Float       //Euler X, Y , vertical and horizontal  vecolity
    private var Ey:Float
    private var EVx:Float
    private var EVy:Float
    
    private var Cx:Float       //Theoretical X, Y ,vertical and horizontal vecolity
    private var Cy:Float
    private var CVx:Float
    private var CVy:Float

    private static let GRAVITY_g:Float = -9.88
    
    private var Ax:Float    // vertical and horizontal Acceleration
    private var Ay:Float
    
    private var lastTime:Float  //the last time stamp. Provided for caculating fragmental time, which is the remainder when devided by delta
    
    
    init (height:Float, angle:Float, velocity:Float){
        let h = height , a = angle, v = velocity  // abbrev for the input para
        self.IniVx = v * cos(a * Float.pi / 180)
        self.IniVy = v * sin(a * Float.pi / 180)
        self.Inix = 0.0
        self.Iniy = h
        self.Ex = 0.0
        self.Ey = h
        self.Cx = 0
        self.Cy = h
        self.EVx = v * cos(a * Float.pi / 180)
        self.EVy = v * sin(a * Float.pi / 180)
        self.CVx = v * cos(a * Float.pi / 180)
        self.CVy = v * sin(a * Float.pi / 180)
        self.Ax = 0
        self.Ay = Ball.GRAVITY_g  // Ay = gravity by default
        self.lastTime = 0.0
    }
    
    func getColor()->String{
        return color
    }
    
    func updateEulerPos(time:Float) {
        let delta = time - self.lastTime
        self.EVx += delta * self.Ax
        self.EVy += delta * self.Ay
        self.Ex += delta * self.EVx
        self.Ey += delta * self.EVy
        self.lastTime = time  // update the previous timestamp.
        //the current time stamp will be updated outside in while loop
    }
    
    func updateCalPos(time:Float) {  //update the theoretical x y coordinates
        self.Cx = time * self.IniVx + 0.5 * self.Ax * time * time + self.Inix
        self.Cy =  0.5 * self.Ay * time * time +  self.IniVy * time  + self.Iniy
    }
    
   
    
    func advance(division:Float){  //850 30 70 50 by default
        var time:Float = 0.0
        let delta:Float = 1.0/division
        let numerator:Float =  -self.IniVy - (self.IniVy * self.IniVy - 2 * self.Iniy * self.Ay).squareRoot()
        let denominator:Float =  self.Ay  //2a
        let groundTime:Float = numerator/denominator  // ( -b + squreRoot( squre(b) -4ac ) ) /2a 。 this is one of the solution, when Cy = 0
        //print(groundTime)
        print("  Time   Theoretical_X    Theoretical_Y           Euler_X    Euler_Y  ") //header
        while (time < groundTime ) {
            updateEulerPos(time:time)
            updateCalPos(time:time)
            print("\(time.format(f: "6.3"))   \(self.Cx.format(f: "8.2"))        \(self.Cy.format(f: "8.2"))          🥚   \(self.Ex.format(f: "8.2"))  \(self.Ey.format(f: "8.2"))  ")
            time += delta //update the current time
        }
        time = groundTime
        updateEulerPos(time:time) //print the situation when the ball is on the gound
        updateCalPos(time:time)
        print("\(time.format(f: "6.3"))   \(self.Cx.format(f: "8.2"))       \(self.Cy.format(f: "8.2"))           🐔   \(self.Ex.format(f: "8.2"))  \(self.Ey.format(f: "8.2"))  ")
    }
}

extension Float {  //conform with the Float protocol, and then rewrite a formatter
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}

