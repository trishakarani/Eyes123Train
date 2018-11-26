//
//  MovingBallViewController.swift
//  Train_Your_Eyes_iOS
//
//  Created by Trisha Karani on 10/29/18.
//  Copyright © 2018 Eyes123Train. All rights reserved.
//

import UIKit

class MovingBallViewController: UIViewController {

    @IBOutlet weak var colorButton: UIBarButtonItem!
    
    var optoKColorStatus : Bool = false
    var bottomButtonArray: [UIButton] = [UIButton]()
    var topButtonArray: [UIButton] = [UIButton]()
    var leftButtonArray: [UIButton] = [UIButton]()
    var rightButtonArray: [UIButton] = [UIButton]()
    var angularViewArray: [UIView] = [UIView]()
    var numButtons: Int = 0
    var timer = Timer()
    var timerAnimationValue: Int = 0
    var timerActionCtr : Int = 0
    var isPortraitMode : Bool = true
    var squareView = UIView()
    var squareViewAnimationId: Int = 1
    var movingBarSpeed: Int = 23
    var animationDurationPortrait: Double = 20
    var animationDurationLandscape: Double = 30

    var Instructions: String = "\r\n\r\nFocus your eye on the moving ball. \r\nDoing this exercise for 5 minutes in a day helps improve focus.\r\n\r\n"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.red,
             NSAttributedString.Key.font: UIFont(name: "Verdana", size: 22)!]

        AlertFunctions.showAlert(title: "Moving Ball Exercise", message: Instructions)
        settingChanged()
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(OptokineticViewController.settingChanged), name: UserDefaults.didChangeNotification, object: nil)
    }
    
    @objc func settingChanged() {
        movingBarSpeed = UserDefaults.standard.integer(forKey: "speed_bars")
        if movingBarSpeed < 15 {
            movingBarSpeed = 15
        }
        else if (movingBarSpeed > 30) {
            movingBarSpeed = 30
        }
        animationDurationPortrait = Double((Int(self.view.frame.width) + 100) / movingBarSpeed)
        animationDurationLandscape = Double((Int (self.view.frame.height) + 100) / movingBarSpeed)
    }
    
    @objc func buttonAction(sender: UIButton!) {
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func colorButtonPressed(_ sender: UIBarButtonItem) {
        optoKColorStatus = !optoKColorStatus
        setupColorButton()
    }
    
    func setupView() {
        numButtons = Int((self.view.frame.height+100) / 50)
        numButtons = 30
        setupButtons(btnCount: numButtons)
        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft || UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
            setupLandscapeModeView()
            isPortraitMode = false
        }
        else {
            setupPortraitModeView()
            isPortraitMode = true
        }
        eyeExerciseMotion()
        animateMovingBall()
    }
    
    func setupPortraitModeView() {
        for _ in 0..<numButtons {
            let yBtmRightViewValue = Int(self.view.frame.height)
            let btmRightView = makeAngularButton(yValue: yBtmRightViewValue)
            angularViewArray.append(btmRightView)
            self.view.addSubview(btmRightView)
        }
    }
    
    func setupLandscapeModeView() {
        for _ in 0..<numButtons {
            let yBtmRightViewValue = Int(self.view.frame.height)
            let btmRightView = makeLandscapeAngularButton(yValue: yBtmRightViewValue)
            angularViewArray.append(btmRightView)
            self.view.addSubview(btmRightView)
        }
    }
    
    func setupButtons(btnCount: Int) {
        for _ in 0..<btnCount {
            let yDelayValue = Int(self.view.frame.height)
            let delayButton = makeButton(yValue: yDelayValue)
            bottomButtonArray.append(delayButton)
            self.view.addSubview(delayButton)
            
            let yTopButtonsValue = 0
            let topButton = makeButton(yValue: yTopButtonsValue)
            topButtonArray.append(topButton)
            self.view.addSubview(topButton)
            
            let xLeftButtonValue = -50
            let leftButton = makeVerticalButton(xValue: xLeftButtonValue)
            leftButtonArray.append(leftButton)
            self.view.addSubview(leftButton)
            
            let xRightButtonValue = Int(self.view.frame.width)
            let rightButton = makeVerticalButton(xValue: xRightButtonValue)
            rightButtonArray.append(rightButton)
            self.view.addSubview(rightButton)
        }
    }
    
    func clearView() {
        for subUIView in self.view.subviews as [UIView] {
            subUIView.removeFromSuperview()
        }
        self.view.removeFromSuperview()
        
        angularViewArray.removeAll()
        bottomButtonArray.removeAll()
        topButtonArray.removeAll()
        leftButtonArray.removeAll()
        rightButtonArray.removeAll()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        print("Will Transition to size \(size) from super view size \(self.view.frame.size)")
        
        var isModeChangedPortrait: Bool = true
        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft || UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
            isModeChangedPortrait = false
        }
        
        if isPortraitMode != isModeChangedPortrait {
            stopAnimations()
            clearView()
            setupView()
        }
    }
    
    func makeButton(yValue: Int) -> UIButton {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: Double(yValue), width: Double(self.view.frame.size.width), height: 25)
        button.backgroundColor = UIColor.black
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
    
    func makeVerticalButton(xValue: Int) -> UIButton {
        let button = UIButton()
        button.frame = CGRect(x: Double(xValue), y: 0, width: 25, height: Double(self.view.frame.size.height))
        button.backgroundColor = UIColor.black
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
    
    func makeAngularButton(yValue: Int) -> UIView {
        let square = UIView()
        square.frame = CGRect(x: Int(self.view.frame.width), y: Int(self.view.frame.height), width: 25, height: Int(self.view.frame.height))
        square.backgroundColor = UIColor.black
        
        return square
    }
    
    func makeLandscapeAngularButton(yValue: Int) -> UIView {
        let square = UIView()
        square.frame = CGRect(x: Int(self.view.frame.width), y: Int(self.view.frame.height), width: 25, height: Int(self.view.frame.width))
        square.backgroundColor = UIColor.black
        
        return square
    }
    
    func setupColorButton() {
        for btnIdx in 0..<numButtons {
            let btnColor: UIColor = optoKColorStatus ? UIColor.red : UIColor.black
            bottomButtonArray[btnIdx].backgroundColor = btnColor
            topButtonArray[btnIdx].backgroundColor = btnColor
            leftButtonArray[btnIdx].backgroundColor = btnColor
            rightButtonArray[btnIdx].backgroundColor = btnColor
            angularViewArray[btnIdx].backgroundColor = btnColor
        }
        colorButton.tintColor = optoKColorStatus ? UIColor.black : UIColor.red
        squareView.backgroundColor = optoKColorStatus ? UIColor.black : UIColor.red
    }
    
    @objc func timerAction() {
        print("Timer Action \(timerActionCtr)")
        eyeExerciseMotion()
    }
    
    func eyeExerciseMotion() {
        switch timerActionCtr {
        case 0:
            stopAnimations()
            animateButtonsRightOneAtTime()
            timerActionCtr += 1
        case 1:
            stopAnimations()
            animateButtons45DegOneAtTime(start: CGPoint(x: 0,y: Int(self.view.frame.height)), end: CGPoint(x: Int(self.view.frame.width), y: 0))
            timerActionCtr += 1
        case 2:
            stopAnimations()
            animateButtonsBottomOneAtTime()
            timerActionCtr += 1
        case 3:
            stopAnimations()
            animateButtons45DegOneAtTime(start: CGPoint(x: 0,y: 0), end: CGPoint(x: Int(self.view.frame.width), y: Int(self.view.frame.height)))
            timerActionCtr += 1
        case 4:
            stopAnimations()
            animateButtonsLeftOneAtTime()
            timerActionCtr += 1
        case 5:
            stopAnimations()
            animateButtons45DegOneAtTime(start: CGPoint(x: Int(self.view.frame.width),y: 0), end: CGPoint(x: 0, y: Int(self.view.frame.height)))
            timerActionCtr += 1
        case 6:
            stopAnimations()
            animateButtonsTopOneAtTime()
            timerActionCtr += 1
        case 7:
            stopAnimations()
            animateButtons45DegOneAtTime(start: CGPoint(x: Int(self.view.frame.width),y: Int(self.view.frame.height)), end: CGPoint(x: 0, y: 0))
            timerActionCtr = 0
        default:
            stopAnimations()
            animateButtonsRightOneAtTime()
            timerActionCtr = 0
        }
        startTimer()
    }
    
    // MARK: - Animate Motion Top and Bottom
    func moveToTop(view: UIView) {
        view.center.y = (0 - view.center.y - 50)
    }
    func startAtBottom(view: UIView) {
        view.center.y = self.view.frame.height + 50
    }
    
    func moveToBottom(view: UIView) {
        view.center.y = (self.view.frame.height - view.center.y + 50)
    }
    func startAtTop(view: UIView) {
        view.center.y = -50
    }
    
    func animateButtonsTopOneAtTime() {
        var duration: Double = animationDurationLandscape
        timerAnimationValue = 55
        for btnIdx in 0..<numButtons {
            let delayBtn : Double = 1.0 * Double(btnIdx)
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft || UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
                duration = 20.0
                timerAnimationValue = 50
            }
            
            UIView.animate(withDuration: Double(duration), delay: Double(delayBtn), options: [.curveLinear, .repeat] , animations: {
                UIView.setAnimationRepeatCount(2)
                self.moveToTop(view: self.bottomButtonArray[btnIdx])
            }) { (finished) in
                self.startAtBottom(view: self.bottomButtonArray[btnIdx])
            }
        }
    }
    
    func animateButtonsBottomOneAtTime() {
        var duration: Double = animationDurationLandscape
        for btnIdx in 0..<numButtons {
            let delayBtn : Double = 2.0 * Double(btnIdx)
            timerAnimationValue = 95
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft || UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
                duration = 20.0
                timerAnimationValue = 62
            }
            
            UIView.animate(withDuration: Double(duration), delay: Double(delayBtn), options: [.curveLinear, .repeat] , animations: {
                UIView.setAnimationRepeatCount(2)
                self.moveToBottom(view: self.topButtonArray[btnIdx])
            }) { (finished) in
                self.startAtTop(view: self.topButtonArray[btnIdx])
            }
        }
    }
    
    // MARK: - Animation Left and Right
    func moveToLeft(view: UIView) {
        view.center.x = (0 - view.center.x - 50)
    }
    func startAtRight(view: UIView) {
        view.center.x = self.view.frame.width + 50
    }
    
    func moveToRight(view: UIView) {
        view.center.x = (self.view.frame.width - view.center.x + 50)
    }
    func startAtLeft(view: UIView) {
        view.center.x = -50
    }
    
    func animateButtonsRightOneAtTime() {
        var duration: Double = animationDurationPortrait
        for btnIdx in 0..<numButtons {
            var delayBtn : Double = 2.0 * Double(btnIdx)
            timerAnimationValue = 75
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft || UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
                delayBtn = 2.0 * Double(btnIdx)
                timerAnimationValue = 75
                duration = 30.0
            }
            
            UIView.animate(withDuration: Double(duration), delay: Double(delayBtn), options: [.curveLinear, .repeat] , animations: {
                UIView.setAnimationRepeatCount(2)
                self.moveToRight(view: self.leftButtonArray[btnIdx])
            }) { (finished) in
                self.startAtLeft(view: self.leftButtonArray[btnIdx])
            }
        }
    }
    
    func animateButtonsLeftOneAtTime() {
        var duration: Double = animationDurationPortrait
        for btnIdx in 0..<numButtons {
            let delayBtn : Double = 1.0 * Double(btnIdx)
            timerAnimationValue = 45
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft || UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
                duration = 30.0
            }
            UIView.animate(withDuration: Double(duration), delay: Double(delayBtn), options: [.curveLinear, .repeat] , animations: {
                UIView.setAnimationRepeatCount(2)
                self.moveToLeft(view: self.rightButtonArray[btnIdx])
            }) { (finished) in
                self.startAtRight(view: self.rightButtonArray[btnIdx])
            }
        }
    }
    
    // MARK: - Animate Motion 45 degree
    func move45DegTop(view: UIView) {
        view.center.y = (0 - view.center.y - 50)
    }
    func start45DegBottom(view: UIView) {
        view.center.y = self.view.frame.height + 50
    }
    
    func move45DegBottom(view: UIView) {
        view.center.y = (self.view.frame.height - view.center.y + 50)
    }
    func start45DegTop(view: UIView) {
        view.center.y = -50
    }
    
    func animateButtons45DegOneAtTime(start: CGPoint, end: CGPoint) {
        let duration: Double = animationDurationLandscape
        for btnIdx in 0..<numButtons {
            let path = UIBezierPath()
            path.move(to: start)
            path.addLine(to: end)
            
            // create the animation
            let anim = CAKeyframeAnimation(keyPath: "position")
            anim.path = path.cgPath
            anim.rotationMode = CAAnimationRotationMode.rotateAuto
            anim.repeatCount = 2
            anim.duration = duration
            let delay = (btnIdx * 2)
            anim.beginTime = CACurrentMediaTime() + Double(delay)
            
            // add the animation
            angularViewArray[btnIdx].layer.add(anim, forKey: "animate position along path")
        }
        timerAnimationValue = 95
    }
    
    //MARK: Animate moving ball in the frame
    func animateMovingBall() {
        squareView.frame = CGRect(x: 55, y: 300, width: 20, height: 20)
        squareView.backgroundColor = UIColor.red
        
        // add the square to the screen
        self.view.addSubview(squareView)
        
        // now create a bezier path that defines our curve
        let sinePath = createSineWaveAnimationPath(startX: 20, startY: 20)
        let sineAnim = CAKeyframeAnimation(keyPath: "position")
        sineAnim.path = sinePath.cgPath
        sineAnim.rotationMode = CAAnimationRotationMode.rotateAuto
        sineAnim.repeatCount = 2
        sineAnim.delegate = self
        sineAnim.duration = 60.0

        // we add the animation to the squares 'layer' property
        squareView.layer.add(sineAnim, forKey: "animate position along path")
    }
    
    func circlePathWithCenter(center: CGPoint, radius: CGFloat) -> UIBezierPath {
        let circlePath = UIBezierPath()
        circlePath.addArc(withCenter: center, radius: radius, startAngle: -CGFloat(Double.pi), endAngle: -CGFloat(Double.pi/2), clockwise: true)
        circlePath.addArc(withCenter: center, radius: radius, startAngle: -CGFloat(Double.pi/2), endAngle: 0, clockwise: true)
        circlePath.addArc(withCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi/2), clockwise: true)
        circlePath.addArc(withCenter: center, radius: radius, startAngle: CGFloat(Double.pi/2), endAngle: CGFloat(Double.pi), clockwise: true)
        circlePath.close()

        return circlePath
    }


    func createRectangleAnimationPath(startX: Int, startY: Int) -> UIBezierPath {
        let path = UIBezierPath()
        
        let endX = Int(self.view.frame.width) - startX
        let topY = 100
        let bottomY = Int(self.view.frame.height) - topY
        
        path.move(to: CGPoint(x: startX, y: startY))
        
        path.addLine(to: CGPoint(x: startX, y: topY))
        path.addLine(to: CGPoint(x: (endX-startX)/2, y: topY))
        path.addLine(to: CGPoint(x: endX, y: topY))
        path.addLine(to: CGPoint(x: endX, y: (bottomY - topY)/2))
        path.addLine(to: CGPoint(x: startX, y: (bottomY - topY)/2))
        path.addLine(to: CGPoint(x: endX, y: bottomY))
        path.addLine(to: CGPoint(x: (endX-startX)/2, y: bottomY))
        path.addLine(to: CGPoint(x: startX, y: bottomY))
        path.addLine(to: CGPoint(x: (endX-startX)/2, y: (bottomY-topY)/2))
        path.addLine(to: CGPoint(x: endX, y: topY))
        path.addLine(to: CGPoint(x: endX, y: (bottomY-topY)/2))
        path.addLine(to: CGPoint(x: endX, y: bottomY))
        path.addLine(to: CGPoint(x: (endX-startX)/2, y: (bottomY-topY)/2))
        path.addLine(to: CGPoint(x: startX, y: topY))
        path.addLine(to: CGPoint(x: startX, y: (bottomY-topY)/2))
        path.addLine(to: CGPoint(x: startX, y: bottomY))
        path.addLine(to: CGPoint(x: startX, y: startY))
        path.addLine(to: CGPoint(x: endX, y: startY))

        return path
    }
    
    func createCircleAnimationPath(startX: Int, startY: Int) -> UIBezierPath {
        return UIBezierPath(ovalIn: circleFrame(startX: startX, startY: startY))
    }
    func circleFrame(startX: Int, startY: Int) -> CGRect {
        let circleRadius = (Int(self.view.frame.width) - (2 * startX)) / 2
        let circleFrame = CGRect(x: startX, y: startY, width: 2 * circleRadius, height: 2 * circleRadius)
        return circleFrame
    }
    
    func createSineWaveAnimationPath(startX: Int, startY: Int) -> UIBezierPath {
        let path = UIBezierPath()

        let graphWidth: CGFloat = 0.8   // Graph is 80% of the width of the view
        let amplitude: CGFloat = 0.3   // Amplitude of sine wave is 30% of view height
        
        let width: Double = Double(self.view.frame.width) - Double(2 * startX)
        let height: Double = Double(self.view.frame.height) - Double(2 * startY)
        let originX = width * (1 - Double(graphWidth)) / 2
        let origin = CGPoint(x: originX, y: Double(height) * 0.50)
        path.move(to: origin)
        
        for angle in stride(from: 5.0, through: 360.0, by: 5.0) {
            let x = origin.x + CGFloat(angle/360.0) * CGFloat(width) * graphWidth
            let y = origin.y - CGFloat(sin(angle/180.0 * Double.pi)) * CGFloat(height) * amplitude
            path.addLine(to: CGPoint(x: x, y: y))
        }
        let endX = origin.x + CGFloat(width) * graphWidth
        for angle in stride(from: 5.0, through: 360.0, by: 5.0) {
            let x = endX - CGFloat(angle/360.0) * CGFloat(width) * graphWidth
            let y = origin.y - CGFloat(sin(angle/180.0 * Double.pi)) * CGFloat(height) * amplitude
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        for angle in stride(from: 5.0, through: 360.0, by: 5.0) {
            let x = origin.x + CGFloat(angle/360.0) * CGFloat(width) * graphWidth
            let y = origin.y + CGFloat(sin(angle/180.0 * Double.pi)) * CGFloat(height) * amplitude
            path.addLine(to: CGPoint(x: x, y: y))
        }
        for angle in stride(from: 5.0, through: 360.0, by: 5.0) {
            let x = endX - CGFloat(angle/360.0) * CGFloat(width) * graphWidth
            let y = origin.y + CGFloat(sin(angle/180.0 * Double.pi)) * CGFloat(height) * amplitude
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        return path
    }

    func stopAnimations() {
        self.view.layer.removeAllAnimations()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: Double(timerAnimationValue), target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
    }
}

extension MovingBallViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        switch squareViewAnimationId {
        case 0:
            let sinePath = createSineWaveAnimationPath(startX: 20, startY: 20)
            let sineAnim = CAKeyframeAnimation(keyPath: "position")
            sineAnim.path = sinePath.cgPath
            sineAnim.rotationMode = CAAnimationRotationMode.rotateAuto
            sineAnim.repeatCount = 2
            sineAnim.delegate = self
            sineAnim.duration = 60.0
            squareView.layer.add(sineAnim, forKey: "animate position along path")
            squareViewAnimationId += 1
        case 1:
            let endPoint = CGPoint(x: 50, y: 200)
            let rectAnim = CAKeyframeAnimation(keyPath: "position")
            let rectPath = createRectangleAnimationPath(startX: Int(endPoint.x), startY: Int(endPoint.y))
            rectAnim.path = rectPath.cgPath
            rectAnim.rotationMode = CAAnimationRotationMode.rotateAuto
            rectAnim.repeatCount = 2
            rectAnim.delegate = self
            rectAnim.duration = 60.0
            squareView.layer.add(rectAnim, forKey: "animate position along path")
            squareViewAnimationId += 1
        case 2:
            let circleAnim = CAKeyframeAnimation(keyPath: "position")
            let endPoint = CGPoint(x: 50, y: 200)
            let circlePath = createCircleAnimationPath(startX: Int(endPoint.x), startY: Int(endPoint.y))
            circleAnim.path = circlePath.cgPath
            circleAnim.rotationMode = CAAnimationRotationMode.rotateAuto
            circleAnim.repeatCount = 2
            circleAnim.delegate = self
            circleAnim.duration = 20.0
            squareView.layer.add(circleAnim, forKey: "animate position along path")
            squareViewAnimationId = 0
        default:
            squareViewAnimationId = 0
        }
    }
}
