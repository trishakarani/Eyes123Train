//
//  HitMovingObjectViewController.swift
//  Train_Your_Eyes_iOS
//
//  Created by Trisha Karani on 10/29/18.
//  Copyright © 2018 Eyes123Train. All rights reserved.
//

import UIKit
import AVFoundation

class HitMovingObjectViewController: UIViewController {
    let fishView = UIView()
    var fish:UIImageView = UIImageView()
    var xpos: CGFloat = 100
    var scaleValue: CGFloat = 1
    var zoomfactor: CGFloat = 0.9
    var imageWidth:CGFloat = 125
    var countdownTimer: Timer!
    var totalTimeInSeconds = 5
    var isTimerRunning = false
    var successHitsCount:Int = 0
    var totalHits:Int = 15
    var fishCounter:Int = 0
    var timeToAnimateInSeconds = 5
    
    var Instructions: String = "\r\n\r\nIn this test we test how you distinguish between red, green and blue colors. Keep the device at a safe distance from your eyes. You should choose the figure that you see in the picture.\r\n\r\n"

    override func  viewWillAppear (_ animated: Bool) {
        self.view.addSubview(fishView)
        //fishView.setAnchorPoint(CGPoint(x: self.view.frame.width/2, y:self.view.frame.height/2))
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position:CGPoint = touch.location(in: view)
            print("position  \(position)")
            print("self.fish.frame.origin.x  \(self.fish.frame.origin.x)")
            print("fish width \(self.fish.frame.origin.x)  -  \(self.fish.frame.origin.x + fish.frame.width)")
            print("fish width \(self.fish.frame.origin.y) -  \(self.fish.frame.origin.y + fish.frame.height)")
            checkPrecision(position: position)
        }
    }
    func checkPrecision(position:CGPoint){
        let startX = self.fish.frame.origin.x
        let endX = self.fish.frame.origin.x + fish.frame.width
        let startY = self.fish.frame.origin.y
        let endY = self.fish.frame.origin.y + fish.frame.height
        if(position.x>=startX && position.x<=endX && position.y>=startY && position.y<=endY){
            successHitsCount += 1
            clickSuccess()
            removeFish()
            countdownTimer.invalidate()
            changeFish()
        }
    }
    func clickSuccess(){
        showToast(controller: self, message : "Score - \(successHitsCount) / \(totalHits)", seconds: 0.5)
    }
    
    func showToast(controller: UIViewController, message : String, seconds: Double) {
        self.view.showToast(message: message, duration: seconds)
        
        //        let alert = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
        //        alert.view.backgroundColor = UIColor.black
        //        alert.view.layer.cornerRadius = 15
        //        self.present(alert, animated: true) {
        //            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
        //            alert.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
        //        }
        //
        //        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
        //            alert.dismiss(animated: true)
        //        }
    }
    
    
    
    
    @objc func dismissAlertController(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // Do any additional setup after loading the view.
        if isTimerRunning == false {
            runTimer()
            //self.startButton.isEnabled = false
        }
        
        loadfish()
    }
    func runTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: TimeInterval(self.timeToAnimateInSeconds), target: self, selector: #selector(changeFish), userInfo: nil, repeats: true)
        isTimerRunning = true
        
    }
    func removeFish(){
        if fishView.subviews.count > 0 {
            fish.image = nil
            fish.removeFromSuperview()
        }
    }
    @objc func changeFish(){
        countdownTimer.invalidate()
        if(fishCounter >= totalHits){
            removeFish()
            showToast(controller: self, message : "Congratulations Score - Go Back \(successHitsCount) / \(totalHits)", seconds: 60.0)
            isTimerRunning = false
        }else {
            removeFish()
            loadfish()
            
            runTimer()
            /*if totalTimeInSeconds < 1 {
             countdownTimer.invalidate()
             //Send alert to indicate time's up.
             } else {
             totalTimeInSeconds -= 5
             print("TIME - \(timeString(time: TimeInterval(totalTimeInSeconds)))")
             removeFish()
             loadfish()
             }*/
        }
        
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AlertFunctions.showAlert(title: "Hit Moving Object", message: Instructions)        
    }
    
    let aquatics: [String] = ["blue_fish","crab","fish_yellow","octopus","prawns","seahorse"]
    func loadfish(){
        print("loadfish")
        fishCounter += 1
        fish = UIImageView()
        let randomPos:CGPoint = getRandomPosition ()
        fish.frame = CGRect(x: randomPos.x, y: randomPos.y, width: imageWidth, height: imageWidth)
        let fishImage = UIImage(named: aquatics.randomElement() ?? "fish_yellow")
        fish.image = fishImage?.scaled(to: CGSize(width: imageWidth, height: imageWidth), scalingMode: .aspectFit)
        
        fish.setAnchorPoint(CGPoint(x: 0.5, y:0.5))
        fish.frame = AVMakeRect(aspectRatio: (self.fish.image?.size)!, insideRect: self.fish.frame)
        fishView.addSubview(fish)
        self.xpos = -self.fish.frame.origin.x - 75
        UIView.animate(withDuration: 1, delay: 0.0, options:[.repeat,.autoreverse], animations: {
            self.fish.alpha = 0.2
            self.fish.transform  = CGAffineTransform( scaleX: 0.6, y: 0.6)
        }, completion: {_ in
            self.fish.alpha = 1.0
            self.fish.transform = .identity
            //self.shrinkTheFish(fish: self.fish)
        })
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    var count:CGFloat = 1
    func shrinkTheFish(fish : UIImageView) {
        print("shrinkTheFish y \(self.fishView.frame.origin.y)")
        let fishMovingSpeed = 60.0/view.frame.size.width
        let moveDuration = (view.frame.size.width - fish.frame.origin.x) * fishMovingSpeed
        
        let duration = 8
        let newX = self.fish.frame.origin.x - 20
        
        UIView.animate(withDuration: TimeInterval(duration), delay: 0.0, options: .curveEaseInOut, animations: {
            //self.fishViewc = self.view.frame.size.width
            //self.fishView.transform = CGAffineTransform( scaleX: 0.65, y: 0.65)
            self.fish.transform  = CGAffineTransform( scaleX: 0.1, y: 0.1)
            self.fish.frame.origin.x = self.xpos
            
        }, completion: {_ in
            
            /*  self.xpos = self.fish.frame.origin.x - CGFloat((50/self.count))
             self.scaleValue = self.scaleValue - 0.1
             self.shrinkTheFish(fish: self.fish)
             self.count = self.count + CGFloat(0.25)*/
        })
    }
    func growTheFish(fish : UIView) {
        let fishMovingSpeed = 100.0/view.frame.size.width
        let duration = (view.frame.size.width - fishView.frame.origin.x) * fishMovingSpeed
        let newX = self.fish.frame.origin.x - 20
        UIView.animate(withDuration: TimeInterval(2), delay: 0.0, options: .curveEaseInOut, animations: {
            //self.fishView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.fish.transform = .identity
            self.fish.frame.origin.x = newX
            self
            //self.fishView.frame.origin.x = self.view.frame.size.width
        }, completion: {_ in
            //self.fishView.frame.origin.x = -self.fishView.frame.size.width
            self.shrinkTheFish(fish: self.fish)
        })
    }
    func animateTheFish(fish : UIImageView) {
        let fishMovingSpeed = 60.0/view.frame.size.width
        let duration = (view.frame.size.width - fishView.frame.origin.x) * fishMovingSpeed
        UIView.animate(withDuration: TimeInterval(duration), delay: 0.0, options: .curveLinear, animations: {
            //self.fishView.frame.origin.x = self.view.frame.size.width
        }, completion: {_ in
            self.fishView.frame.origin.x = -self.fishView.frame.size.width
            self.animateTheFish(fish: self.fishView as! UIImageView)
        })
    }
    func animateFish() {
        // create and add blue-fish.png image to screen
        //        let fish = UIImageView()
        //        fish.image = UIImage(named: "blue-fish.png")
        //        fish.frame = CGRect(x: 50, y: 50, width: 50, height: 50)
        //        self.view.addSubview(fish)
        //
        // create an array of views to animate (in this case just one)
        //        let viewsToAnimate = [fish]
        
        // perform the system animation
        // as of iOS 8 UISystemAnimation.Delete is the only valid option
        //        UIView.performSystemAnimation(UIView.SystemAnimation.Delete, onViews: viewsToAnimate, options: nil, animations: {
        // any changes defined here will occur
        // in parallel with the system animation
        
        //        }, completion: { finished in
        // any code entered here will be applied
        // once the animation has completed
        
        //        })
    }
    func getRandomPosition () -> CGPoint{
        let imageWidth = self.imageWidth
        let imageHeight = self.imageWidth
        
        let screenSize: CGRect = UIScreen.main.bounds
        
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        // Find the width and height of the enclosing view
        let viewWidth = self.view.frame.width
        let viewHeight = self.view.frame.height
        
        // Compute width and height of the area to contain the button's center
        let xwidth = viewWidth - imageWidth
        let yheight = viewHeight - imageHeight
        
        // Generate a random x and y offset
        let xoffset = CGFloat(arc4random_uniform(UInt32(xwidth)))
        let yoffset = CGFloat(arc4random_uniform(UInt32(yheight)))
        
        
        return CGPoint(x: CGFloat(xoffset ), y: CGFloat(yoffset))
        
    }
}

extension UIView {
    func fadeIn() {
        // Move our fade out code from earlier
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0 // Instead of a specific instance of, say, birdTypeLabel, we simply set [thisInstance] (ie, self)'s alpha
        }, completion: nil)
    }
    
    func fadeOut() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.alpha = 0.0
        }, completion: nil)
    }
    func setAnchorPoint(_ point: CGPoint) {
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y);
        
        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)
        
        var position = layer.position
        
        position.x -= oldPoint.x
        position.x += newPoint.x
        
        position.y -= oldPoint.y
        position.y += newPoint.y
        
        layer.position = position
        layer.anchorPoint = point
    }
    
    var showToastTag :Int {return 999}
    
    //Generic Show toast
    func showToast(message : String, duration:TimeInterval) {
        
        let toastLabel = UILabel(frame: CGRect(x:0, y:self.frame.size.height - 100, width: (self.frame.size.width)-60, height:64))
        
        toastLabel.backgroundColor = UIColor.gray
        toastLabel.textColor = UIColor.black
        toastLabel.numberOfLines = 0
        toastLabel.layer.borderColor = UIColor.lightGray.cgColor
        toastLabel.layer.borderWidth = 1.0
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "HelveticaNeue", size: 17.0)
        toastLabel.text = message
        toastLabel.center = self.center
        toastLabel.isEnabled = true
        toastLabel.alpha = 0.99
        toastLabel.tag = showToastTag
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.addSubview(toastLabel)
        
        UIView.animate(withDuration: duration, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.95
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    //Generic Hide toast
    func hideToast(){
        if let view = self.viewWithTag(self.showToastTag){
            view.removeFromSuperview()
        }
    }
    
}

// MARK: - Image Scaling.
extension UIImage {
    
    /// Represents a scaling mode
    enum ScalingMode {
        case aspectFill
        case aspectFit
        
        /// Calculates the aspect ratio between two sizes
        ///
        /// - parameters:
        ///     - size:      the first size used to calculate the ratio
        ///     - otherSize: the second size used to calculate the ratio
        ///
        /// - return: the aspect ratio between the two sizes
        func aspectRatio(between size: CGSize, and otherSize: CGSize) -> CGFloat {
            let aspectWidth  = size.width/otherSize.width
            let aspectHeight = size.height/otherSize.height
            
            switch self {
            case .aspectFill:
                return max(aspectWidth, aspectHeight)
            case .aspectFit:
                return min(aspectWidth, aspectHeight)
            }
        }
    }
    
    /// Scales an image to fit within a bounds with a size governed by the passed size. Also keeps the aspect ratio.
    ///
    /// - parameter:
    ///     - newSize:     the size of the bounds the image must fit within.
    ///     - scalingMode: the desired scaling mode
    ///
    /// - returns: a new scaled image.
    func scaled(to newSize: CGSize, scalingMode: UIImage.ScalingMode = .aspectFit) -> UIImage {
        
        let aspectRatio = scalingMode.aspectRatio(between: newSize, and: size)
        
        /* Build the rectangle representing the area to be drawn */
        var scaledImageRect = CGRect.zero
        
        scaledImageRect.size.width  = size.width * aspectRatio
        scaledImageRect.size.height = size.height * aspectRatio
        scaledImageRect.origin.x    = (newSize.width - size.width * aspectRatio) / 2.0
        scaledImageRect.origin.y    = (newSize.height - size.height * aspectRatio) / 2.0
        
        /* Draw and retrieve the scaled image */
        UIGraphicsBeginImageContext(newSize)
        
        draw(in: scaledImageRect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
}
