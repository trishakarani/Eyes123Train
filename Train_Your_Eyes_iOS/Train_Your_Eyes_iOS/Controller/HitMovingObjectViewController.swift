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
    let MAX_HITS_LEVEL_RETRIES:Int = 12

    var fish = UIImageView()
    var xpos: CGFloat = 100
    var scaleValue: CGFloat = 1
    var zoomfactor: CGFloat = 0.9
    var imageWidth:CGFloat = 125
    var countdownTimer: Timer!
    var totalTimeInSeconds = 5
    var successHitsCount:Int = 0
    var totalDisplayedCount: Int = 0
    var timeFishDisplayInSeconds = 30
    let aquatics: [String] = ["octopus", "crab", "fish_yellow", "prawns", "seahorse", "whale", "turtle", "goldfish2", "multiColorFish", "lobster", "dolphin", "orangeFish", "goldfish"]
    
    var gameLevel: Int = 1
    
    enum HitGameState {
        case gameNone
        case gameStart
        case gameInProgress
        case nextLevel
        case gameEnd
    }
    var currGameState = HitGameState.gameNone

    @IBOutlet var screenView: UIView!
    var bkgdView : UIImageView!
    
    var Instructions: String = "\r\n\r\nHit the flashing object. \r\n\r\nIf the accuracy of the flashing object recognition is above 90%, the game would automatically move to next level. \r\n Enjoy the Game ...\r\n\r\n"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showAlert(title: "Hit Flashing Object", message: Instructions)
        
        bkgdView = UIImageView(image: UIImage(named: "deepocean")!)//Your image name here
        bkgdView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        self.view.insertSubview(bkgdView, at: 0)//To set first of all views in VC
    }

    func startHitGame() {
        updateGameLevels()
        currGameState = HitGameState.gameStart
    }
    
    func endHitGame() {
        performSegue(withIdentifier: "endHitGame", sender: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position:CGPoint = touch.location(in: view)
            checkPrecision(position: position)
        }
    }
    
    func loadFish() {
        let randomPos = getRandomPosition ()
        fish.frame = CGRect(x: randomPos.x, y: randomPos.y, width: imageWidth, height: imageWidth)
        let fishImage = UIImage(named: getRandomFish())
        fish.image = fishImage!.scaled(to: CGSize(width: imageWidth, height: imageWidth), scalingMode: .aspectFit)
        
        fish.setAnchorPoint(CGPoint(x: 0.5, y:0.5))
        //fish.frame = AVMakeRect(aspectRatio: (self.fish.image?.size)!, insideRect: self.fish.frame)
        self.xpos = -self.fish.frame.origin.x - 75
//        UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseIn, .repeat, .autoreverse], animations: {
//            self.fish.alpha = 0.2
//            self.fish.transform  = CGAffineTransform( scaleX: 0.6, y: 0.6)
//        }) { _ in
//            self.fish.image = nil
//            self.fish.removeFromSuperview()
//        }
        
//        UIView.animate(withDuration: 1, delay: 0.0, options:[.repeat,.autoreverse], animations: {
//            self.fish.alpha = 0.2
//            self.fish.transform  = CGAffineTransform( scaleX: 0.6, y: 0.6)
//        }, completion: {_ in
//            self.fish.alpha = 1.0
//            self.fish.transform = .identity
//            //self.shrinkTheFish(fish: self.fish)
//        })
        bkgdView.addSubview(fish)

        totalDisplayedCount += 1
    }
    
    func removeFish() {
        fish.image = nil
        fish.removeFromSuperview()
    }
    
    func changeFish() {
        countdownTimer.invalidate()
        if totalDisplayedCount > MAX_HITS_LEVEL_RETRIES {
            removeFish()
            let successPercent = (successHitsCount * 100) / totalDisplayedCount
            if gameLevel >= 5 {
                currGameState = HitGameState.gameEnd
                let msgResult = "\r\nYou have exceeded all levels designed for this game. \r\nWe are working on advanced functionality for the game.\r\nThanks for Playing...\r\n"
                showAlert(title: "* Congratulations *", message: msgResult)
            }
            else if successPercent > 80 {
                gameLevel += 1
                let msgResult = "\r\nYou have moved to Level \(gameLevel). The next challenge will test you on your speed and recognition of smaller fishes.\r\n"
                AlertFunctions.showAlert(title: "Congratulations", message: msgResult)
                updateGameLevels()
            }
            else {
                let retryMsg = "\r\nYour accuracy is \(successPercent)%.\r\nWe recommend retrying the Level \(gameLevel) till you achieve 90% accuracy.\r\nThis will help you improve your vision and focus.\r\n"
                AlertFunctions.showAlert(title: "Re-Start Level \(gameLevel)", message: retryMsg)
                totalDisplayedCount = 0
                successHitsCount = 0
                loadFish()
                startTimer()
            }
        }
        else {
            loadFish()
            startTimer()
        }
    }
    
    func checkPrecision(position:CGPoint) {
        let startX = self.fish.frame.origin.x
        let endX = self.fish.frame.origin.x + fish.frame.width
        let startY = self.fish.frame.origin.y
        let endY = self.fish.frame.origin.y + fish.frame.height
        
        if(position.x >= startX && position.x <= endX && position.y >= startY && position.y <= endY){
            successHitsCount += 1
            updateScore()
        }
        countdownTimer.invalidate()
        removeFish()
        changeFish()
    }

    func updateScore() {
        print("Score - \(successHitsCount) / \(totalDisplayedCount)")
    }
    
    @objc func dismissAlertController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: TimeInterval(self.timeFishDisplayInSeconds), target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
    }

    @objc func timerAction() {
        removeFish()
        changeFish()
    }

    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
     // MARK: - Navigation
    var count:CGFloat = 1
    func shrinkTheFish(fish : UIImageView) {
//        print("shrinkTheFish y \(self.fishView.frame.origin.y)")
//        let fishMovingSpeed = 60.0/view.frame.size.width
//        let moveDuration = (view.frame.size.width - fish.frame.origin.x) * fishMovingSpeed
//
//        let duration = 8
//        let newX = self.fish.frame.origin.x - 20
//
//        UIView.animate(withDuration: TimeInterval(duration), delay: 0.0, options: .curveEaseInOut, animations: {
//            //self.fishViewc = self.view.frame.size.width
//            //self.fishView.transform = CGAffineTransform( scaleX: 0.65, y: 0.65)
//            self.fish.transform  = CGAffineTransform( scaleX: 0.1, y: 0.1)
//            self.fish.frame.origin.x = self.xpos
//
//        }, completion: {_ in
//
//            /*  self.xpos = self.fish.frame.origin.x - CGFloat((50/self.count))
//             self.scaleValue = self.scaleValue - 0.1
//             self.shrinkTheFish(fish: self.fish)
//             self.count = self.count + CGFloat(0.25)*/
//        })
    }

    func growTheFish(fish : UIView) {
//        let fishMovingSpeed = 100.0/view.frame.size.width
//        let duration = (view.frame.size.width - fishView.frame.origin.x) * fishMovingSpeed
//        let newX = self.fish.frame.origin.x - 20
//        UIView.animate(withDuration: TimeInterval(2), delay: 0.0, options: .curveEaseInOut, animations: {
//            //self.fishView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//            self.fish.transform = .identity
//            self.fish.frame.origin.x = newX
//            self
//            //self.fishView.frame.origin.x = self.view.frame.size.width
//        }, completion: {_ in
//            //self.fishView.frame.origin.x = -self.fishView.frame.size.width
//            self.shrinkTheFish(fish: self.fish)
//        })
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
    
    func getRandomFish() -> String {
        let randomIdx = Int.random(in: 0 ..< aquatics.count)
        return aquatics[randomIdx]
    }
    
    func getRandomPosition() -> CGPoint {
        let imageWidth = self.imageWidth

        // Find the width and height of the enclosing view
        let viewWidth = self.view.frame.width
        let viewHeight = self.view.frame.height

        let topbarHeight : CGFloat = 0
        // Compute width and height of the area to contain the button's center
        // Subtract the navigation height for y position
        let xwidth = viewWidth - imageWidth
        let yheight = viewHeight - imageWidth - topbarHeight

        // Generate a random x and y offset
        // add the navigation height for offset
        let xoffset = CGFloat(arc4random_uniform(UInt32(xwidth)))
        let yoffset = CGFloat(arc4random_uniform(UInt32(yheight)) + UInt32(topbarHeight))
        
        print("y=\(yoffset), yHeight=\(yheight), topBar=\(topbarHeight), imgwidth=\(imageWidth)")
        
        return CGPoint(x: CGFloat(xoffset ), y: CGFloat(yoffset))
    }
    
    func updateGameLevels() {
        switch gameLevel {
        case 1:
            imageWidth = 100
            timeFishDisplayInSeconds = 25
        case 2:
            imageWidth = 75
            timeFishDisplayInSeconds = 18
        case 3:
            imageWidth = 55
            timeFishDisplayInSeconds = 12
        case 4:
            imageWidth = 40
            timeFishDisplayInSeconds = 7
        case 5:
            imageWidth = 20
            timeFishDisplayInSeconds = 4
        default:
            imageWidth = 125
            timeFishDisplayInSeconds = 30
        }
        successHitsCount = 0
        totalDisplayedCount = 0
        loadFish()
        startTimer()
    }
}

extension HitMovingObjectViewController {
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: { action in
            if self.currGameState == HitGameState.gameNone {
                self.startHitGame()
            }
            else if self.currGameState == HitGameState.gameEnd {
                self.endHitGame()
            }
        })
        alertController.addAction(OKAction)
        
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: title as String, attributes: [NSAttributedString.Key.font:UIFont(name: "Verdana", size: 22.0)!])
        alertController.setValue(myMutableString, forKey: "attributedTitle")
        
        var messageMutableString = NSMutableAttributedString()
        messageMutableString = NSMutableAttributedString(string: message as String, attributes: [NSAttributedString.Key.font:UIFont(name: "Verdana", size: 18.0)!])
        alertController.setValue(messageMutableString, forKey: "attributedMessage")
        
        var alertWindow : UIWindow!
        alertWindow = UIWindow.init(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController.init()
        alertWindow.windowLevel = UIWindow.Level.alert + 1
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(alertController, animated: true)
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
    func hideToast() {
        if let view = self.viewWithTag(self.showToastTag) {
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

    /// Scales an image to fit within a bounds with a size. Also keeps the aspect ratio.
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

extension UIViewController {
    /**
     *  Height of status bar + navigation bar (if navigation bar exist)
     */
    var topbarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}
