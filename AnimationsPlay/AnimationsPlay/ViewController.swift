//
//  ViewController.swift
//  AnimationsPlay
//
//  Created by Diwakar Kamboj on 23/04/16.
//
//

import UIKit

class ViewController: UIViewController {
    
    var updateTimer: NSTimer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        drawCircularLoader()
        updateTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "updateProgress", userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        circlePathLayer.frame = view.bounds
        circlePathLayer.path = circlePath().CGPath
    }

    func drawRoundedRect() {
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: CGRect(x: 64, y: 64, width: 160, height: 160), cornerRadius: 50).CGPath
        layer.fillColor = UIColor.redColor().CGColor
        view.layer.addSublayer(layer)
    }
    
    let circlePathLayer = CAShapeLayer()
    let circleRadius: CGFloat = 20.0
    
    func drawCircularLoader() {
        circlePathLayer.frame = view.bounds
        circlePathLayer.lineWidth = 2
        circlePathLayer.fillColor = UIColor.grayColor().CGColor
        circlePathLayer.strokeColor = UIColor.redColor().CGColor
        view.layer.addSublayer(circlePathLayer)
        view.backgroundColor = UIColor.whiteColor()
        progress = 0
    }
    
    func circleFrame() -> CGRect {
        var circleFrame = CGRect(x: 0, y: 0, width: 2*circleRadius, height: 2*circleRadius)
        circleFrame.origin.x = CGRectGetMidX(circlePathLayer.bounds) - CGRectGetMidX(circleFrame)
        circleFrame.origin.y = CGRectGetMidY(circlePathLayer.bounds) - CGRectGetMidY(circleFrame)
        return circleFrame
    }
    
    func circlePath() -> UIBezierPath {
        return UIBezierPath(ovalInRect: circleFrame())
    }
    
    var progress: CGFloat {
        get {
            return circlePathLayer.strokeEnd
        }
        set {
//            if (newValue > 1) {
//                circlePathLayer.strokeEnd = 1
//            } else if (newValue < 0) {
//                circlePathLayer.strokeEnd = 0
//            } else {
                circlePathLayer.strokeEnd = newValue
            circlePathLayer.strokeStart = newValue - 0.25
//            }
        }
    }
    
    var i = 0
    
    func updateProgress() {
        progress += 0.01
//        print(circlePathLayer.strokeEnd)
//        if ++i == 10 {
//            switchColors()
//            i = 0
//        }
        if progress == 1 {
            
        }
        
        if progress > 1.1 {
            progress = 1
            switchColors()
            updateTimer.invalidate()
            
            updateTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "reverseProgress", userInfo: nil, repeats: true)
        }
    }
    
    func reverseProgress() {
        progress -= 0.01
        
        if progress < -0.1 {
            progress = 0
            switchColors()
            updateTimer.invalidate()
            
            updateTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "updateProgress", userInfo: nil, repeats: true)
        }
    }
    
    var switchVal = false
    
    func switchColors() {
        circlePathLayer.fillColor = switchVal ? UIColor.grayColor().CGColor : UIColor.redColor().CGColor
        circlePathLayer.strokeColor = switchVal ? UIColor.redColor().CGColor : UIColor.grayColor().CGColor
        switchVal = !switchVal
    }

}

