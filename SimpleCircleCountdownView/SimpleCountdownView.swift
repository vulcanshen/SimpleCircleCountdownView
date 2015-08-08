//
//  MovieCountdownTimerView.swift
//  MovieCountdownTimer
//
//  Created by shenyun on 2015/8/7.
//  Copyright (c) 2015年 shenyun. All rights reserved.
//

import UIKit

protocol SimpleCircleCountdownViewEvent {
    func countDownEnd()
}

@IBDesignable class SimpleCircleCountdownView: UIView {
    @IBInspectable var fullColor: UIColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
    @IBInspectable var progressColor:UIColor = UIColor.lightGrayColor()
    @IBInspectable var textColor: UIColor = UIColor.blackColor()
    @IBInspectable var centerColor: UIColor = UIColor.whiteColor()
    @IBInspectable var bandPercent:CGFloat = 0
    
    @IBInspectable var totalSeconds:Int = 0 {
        didSet {
            self.totalTime =  totalSeconds
        }
    }
    
    var delegate:SimpleCircleCountdownViewEvent?
    private var isOver:Bool = false
    private let beginProgress:Int = 270
    
    private var progress:Int = 270 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    private var timeInterval:Double = 0.01
    var totalTime:Int = 0 {
        didSet {
            leftTime = totalTime
        }
    }
    private var leftTime:Int = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
    func startCountDown(){
        isOver = false
        leftTime = totalTime
        self.progress = beginProgress
        timeInterval = Double(totalTime)/360
        actionCountdown()
       NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "actionSetCounterText", userInfo: nil, repeats: false)
        
    }
    
    func actionSetCounterText(){
        if self.leftTime == 0 {
//            self.leftTime = totalTime
        } else {
            leftTime--
            NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "actionSetCounterText", userInfo: nil, repeats: false)
        }
    }
    
    func actionCountdown(){
        if self.progress == beginProgress + 360 {
            self.progress = beginProgress
            self.isOver = true
        } else {
            self.progress++
            NSTimer.scheduledTimerWithTimeInterval(timeInterval, target: self, selector: "actionCountdown", userInfo: nil, repeats: false)
        }
    }
    
    override func drawRect(rect: CGRect) {

        if bandPercent == 0 {
            bandPercent = 0.25
        }
        
        var center = CGPointMake(self.bounds.width/2, self.bounds.height/2)
        var lineWidth:CGFloat = self.bounds.width * bandPercent
        var radius = self.bounds.width/2 - lineWidth/2
        
        var centerPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(M_PI*2), clockwise: true)
        centerColor.setFill()
        centerPath.fill()
        
        
        if self.isOver == false {
            var roundPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(M_PI*2), clockwise: true)
            roundPath.lineWidth = lineWidth
            fullColor.setStroke()
            roundPath.stroke()
            var progressPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: getRadianFromDegree(270), endAngle: getRadianFromDegree(self.progress), clockwise: true)
            progressPath.lineWidth = lineWidth
            progressColor.setStroke()
            progressPath.stroke()
        } else {
            var progressPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(M_PI*2), clockwise: true)
            
            progressPath.lineWidth = lineWidth
            progressColor.setStroke()
            progressPath.stroke()
            delegate?.countDownEnd()
        }
        
        
        
        
        
        
        var counter: NSString = self.leftTime.description
        
        // set the text color to dark gray
        let fieldColor: UIColor = textColor
        

        let fieldFont = UIFont.boldSystemFontOfSize(self.bounds.width/CGFloat(count(self.leftTime.description)+2))
        
        var paraStyle = NSMutableParagraphStyle()
        paraStyle.alignment = .Center

        paraStyle.paragraphSpacing = 0
//        paraStyle.lineSpacing = 6.0
        
        // set the Obliqueness to 0.1
        var skew = 0
        
        var attributes: NSDictionary = [
            NSForegroundColorAttributeName: fieldColor,
            NSParagraphStyleAttributeName: paraStyle,
            NSObliquenessAttributeName: skew,
            NSFontAttributeName: fieldFont
        ]
        
        var size = counter.sizeWithAttributes(attributes as [NSObject : AnyObject])
        
        var textRect = CGRectMake((self.bounds.width-size.width)/2, (self.bounds.height-size.height)/2, size.width, size.height)
        counter.drawInRect(textRect, withAttributes: attributes as [NSObject : AnyObject])
        
    }
    
    
    private func getRadianFromDegree(degree:Int) -> CGFloat {
        return CGFloat(Double(degree)*M_PI/180)
    }
    
}
