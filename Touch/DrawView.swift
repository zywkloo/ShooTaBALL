//
//  DrawView.swift
//  Touch
//
//  Created by 张一唯 on 2019-03-26.
//  Copyright © 2019 Yiwei. All rights reserved.
//

import Foundation
import UIKit

class DrawView: UIView {
    var currentLine: Line?
    var currentCircle: Circle?
    var finishedCircle = [Circle]()
    var finishedLines = [Line]()
    var initialized = false //variables not yet initialized
    var timer :Timer!
    var timerIsRunning = false
    let screenSize: CGRect = UIScreen.main.bounds
    let s: NSString = "Ball Location:"
    
    @IBInspectable var finishedLineColor: UIColor = UIColor.blue {
        didSet {
            //finishedLineColor = UIColor.green;
            setNeedsDisplay()
        }
    }
    @IBInspectable var currentLineColor: UIColor = UIColor.red {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var finishedCircleColor: UIColor = UIColor.orange {
        didSet {
            //finishedLineColor = UIColor.green;
            setNeedsDisplay()
        }
    }
    @IBInspectable var currentCircleColor: UIColor = UIColor.purple {
        didSet {
            //currentLineColor = UIColor(red: CGFloat.random(min: CGFloat(0.01), max: CGFloat(0.99)), green: 0.5, blue: CGFloat.random(in: 0..<1), alpha: 0.3);
            setNeedsDisplay()
        }
    }
    @IBInspectable var lineThickness: CGFloat = CGFloat.random(in: 5..<20) {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var circleThickness: CGFloat = CGFloat.random(in: 1..<3) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    func strokeCircle(circle: Circle){
        //Use BezierPath to draw circle
        let path = UIBezierPath(ovalIn: CGRect(x: circle.centre.x - circle.radius,
                                               y: circle.centre.y - circle.radius,
                                               width: circle.radius*2,
                                               height: circle.radius*2))
        path.lineWidth = 10;
        path.fill()
        path.stroke(); //actually draw the path
    }
    
    
    func strokeLine(line: Line){
        //Use BezierPath to draw lines
        let path = UIBezierPath();
        path.lineWidth = lineThickness;
        path.lineCapStyle = CGLineCap.round;
        
        path.move(to: line.begin);
        path.addLine(to: line.end);
        path.stroke(); //actually draw the path
    }

    func initialize(rect: CGRect){
        //Initialize variables based on dimensions
        //rect.width and rect.height
        currentCircle = Circle(centre: CGPoint(x:screenSize.width/2,y:screenSize.height/2), radius: CGFloat(screenSize.width/4))
        
        // set the text color to dark gray
        let fieldColor: UIColor = UIColor.darkGray
        // set the font to Helvetica Neue 18
        let fieldFont = UIFont(name: "Helvetica Neue", size: 18)
        // set the line spacing to 6
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.lineSpacing = CGFloat(6.0)
        // set the Obliqueness to 0.1
        let skew = 0.2
        let attributes: NSDictionary = [
            NSAttributedString.Key.foregroundColor: fieldColor,
            NSAttributedString.Key.paragraphStyle: paraStyle,
            NSAttributedString.Key.obliqueness: skew,
            NSAttributedString.Key.font: fieldFont!
        ]
        s.draw(in: CGRect(x: 20.0, y: 140.0, width: 300.0, height: 48.0), withAttributes: attributes as? [NSAttributedString.Key : Any])
        
        initialized = true
    }
    
    
    override func draw(_ rect:CGRect) {
        if !initialized {initialize(rect: rect)}
        //draw the finished lines
        finishedLineColor.setStroke() //finished lines in black
        for line in finishedLines{
            strokeLine(line: line);
        }
        //for debug
        //couple of lines and circles for debug
        let line1 = Line(begin: CGPoint(x:50,y:50), end: CGPoint(x:100,y:100));
        let line2 = Line(begin: CGPoint(x:50,y:100), end: CGPoint(x:100,y:300));
        let circle1 = Circle(centre: CGPoint(x:50,y:100), radius:CGFloat(20.0));
        strokeLine(line: line1);
        strokeLine(line: line2);
        strokeCircle(circle: circle1);
        //draw current line if it exists
        if let line = currentLine {
            currentLineColor.setStroke(); //current line in red
            strokeLine(line: line);
        }
        if let curCircleEntity = currentCircle {
            currentCircleColor.setStroke(); //current line in red
            strokeCircle(circle: curCircleEntity)
        }
    }
    
    //Override Touch Functions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function) //for debugging
        let touch = touches.first!; //get first touch event and unwrap optional
        let location = touch.location(in: self); //get location in view co-ordinate
        currentLine = Line(begin: location, end: location);
        setNeedsDisplay(); //this view needs to be updated
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function) //for debugging
        let touch = touches.first!; //get first touch event and unwrap optional
        let location = touch.location(in: self); //get location in view co-ordinate
        currentLine?.end = location;
        setNeedsDisplay(); //this view needs to be updated
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function) //for debugging
        let touch = touches.first!; //get first touch event and unwrap optional
        let location = touch.location(in: self); //get location in view co-ordinate
        currentLine?.end = location;
        strokeLine(line: currentLine!);
        finishedLines.append(currentLine!);
        setNeedsDisplay(); //this view needs to be updated
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
        print(#function) //for debugging
        currentLine = nil;
    }
}

public extension Float {
    /// Returns a random floating point number between 0.0 and 1.0, inclusive.
    public static var random: Float {
        return Float(arc4random()) / 0xFFFFFFFF
    }
    
    /// Random float between 0 and n-1.
    ///
    /// - Parameter n:  Interval max
    /// - Returns:      Returns a random float point number between 0 and n max
    public static func random(min: Float, max: Float) -> Float {
        return Float.random * (max - min) + min
    }
}

// MARK: Double Extension

public extension Double {
    /// Returns a random floating point number between 0.0 and 1.0, inclusive.
    public static var random: Double {
        return Double(arc4random()) / 0xFFFFFFFF
    }
    
    /// Random double between 0 and n-1.
    ///
    /// - Parameter n:  Interval max
    /// - Returns:      Returns a random double point number between 0 and n max
    public static func random(min: Double, max: Double) -> Double {
        return Double.random * (max - min) + min
    }
}

// MARK: CGFloat Extension

public extension CGFloat {
    /// Randomly returns either 1.0 or -1.0.
    public static var randomSign: CGFloat {
        return (arc4random_uniform(2) == 0) ? 1.0 : -1.0
    }
    
    /// Returns a random floating point number between 0.0 and 1.0, inclusive.
    public static var random: CGFloat {
        return CGFloat(Float.random)
    }
    
    /// Random CGFloat between 0 and n-1.
    ///
    /// - Parameter n:  Interval max
    /// - Returns:      Returns a random CGFloat point number between 0 and n max
    public static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat.random * (max - min) + min
    }
}