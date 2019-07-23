//
//  OptokineticViewController.swift
//  Train_Your_Eyes_iOS
//
//  Created by Trisha Karani on 10/29/18.
//  Copyright © 2018 Eyes123Train. All rights reserved.
//

import UIKit
import PopMenu


class OptokineticViewController: UIViewController {
    
    @IBOutlet weak var colorButton: UIBarButtonItem!
    var optoKColorStatus : Bool = false
    var bottomButtonArray: [UIButton] = [UIButton]()
    var topButtonArray: [UIButton] = [UIButton]()
    var leftButtonArray: [UIButton] = [UIButton]()
    var rightButtonArray: [UIButton] = [UIButton]()
    var angularViewArray: [UIView] = [UIView]()
    var leftRightBtnCount: Int = 0
    var topBottomBtnCount: Int = 0
    var timer = Timer()
    var timerAnimationValue: Int = 0
    var timerActionCtr : Int = 0
    var isPortraitMode : Bool = true
    var movingBarSpeed: Int = 23
    var animationDurationPortrait: Double = 2
    var animationDurationLandscape: Double = 4
    
    enum OptoDirections {
        case none, right, left, top, bottom
    }
    var menuOptoDirectionList = [OptoDirections]()
    var optoPrevDirection = OptoDirections.none
    var optoCurrDirection = OptoDirections.right
    var optoMenuActions = [PopMenuDefaultAction]()
    
//    var Instructions: String = "\r\n\r\nFocus your eyes by looking at the strips of lines moving on the screen. \r\nWatching this for 5 minutes in a day helps improve vision.\r\n\r\n"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        self.navigationController?.navigationBar.titleTextAttributes =
        //            [NSAttributedString.Key.foregroundColor: UIColor.red,
        //             NSAttributedString.Key.font: UIFont(name: "Verdana", size: 22)!]
        
        navigationController?.hidesBarsOnTap = true
        
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        settingChanged()
        //AlertFunctions.showAlert(title: "OptoKinetic Exercise", message: Instructions)
        
        setupView()
        self.navigationController?.replaceCurrentViewController(with: self, animated: false)
    }
    
    override var prefersStatusBarHidden: Bool {
        return navigationController?.isNavigationBarHidden == true
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }
    


//other way to do tap for nav bar
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(OptokineticViewController.toggle))
//        view.isUserInteractionEnabled = true
//        view.addGestureRecognizer(gesture)
//
//        let backButton = UIBarButtonItem()
//        backButton.title = "Back"
//        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
//
//        settingChanged()
//        AlertFunctions.showAlert(title: "OptoKinetic Exercise", message: Instructions)
//
//        setupView()
//    }
//
//    @objc func toggle() {
//        navigationController?.setNavigationBarHidden(navigationController?.isNavigationBarHidden == false, animated: true)
//    }
//
//    override var prefersStatusBarHidden: Bool {
//        return navigationController?.isNavigationBarHidden == true
//    }
//
//    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
//        return UIStatusBarAnimation.slide
//    }
//
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
        //        animationDurationPortrait = Double((Int(self.view.frame.width) + 100) / movingBarSpeed)
        //        animationDurationLandscape = Double((Int (self.view.frame.height) + 100) / movingBarSpeed)
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
    
    func presentMenu() {
        let menuViewController = PopMenuViewController(actions: optoMenuActions)
        menuViewController.delegate = self
        present(menuViewController, animated: true, completion: nil)
    }
    
    @IBAction func colorButtonPressed(_ sender: UIBarButtonItem) {
        presentMenu()
    }
    
    func setupManualView() {
        leftRightBtnCount = 30
        topBottomBtnCount = 45
        eyeExerciseMotionManualControl()
    }
    
    func setupView() {
        leftRightBtnCount = Int((self.view.frame.height+100) / 50)
        leftRightBtnCount = 30
        setupLeftRightButtons(btnCount: leftRightBtnCount)
        topBottomBtnCount = 45
        setupTopBottomButtons(btnCount: topBottomBtnCount)
        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft || UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
            setupLandscapeModeView()
            isPortraitMode = false
        }
        else {
            setupPortraitModeView()
            isPortraitMode = true
        }
        eyeExerciseMotionManualControl()
    }
    
    func setupPortraitModeView() {
        for _ in 0..<topBottomBtnCount {
            let yBtmRightViewValue = Int(self.view.frame.height)
            let btmRightView = makeAngularButton(yValue: yBtmRightViewValue)
            angularViewArray.append(btmRightView)
            self.view.addSubview(btmRightView)
        }
    }
    
    func setupLandscapeModeView() {
        for _ in 0..<leftRightBtnCount {
            let yBtmRightViewValue = Int(self.view.frame.height)
            let btmRightView = makeLandscapeAngularButton(yValue: yBtmRightViewValue)
            angularViewArray.append(btmRightView)
            self.view.addSubview(btmRightView)
        }
    }
    
    func setupLeftRightButtons(btnCount: Int) {
        for _ in 0..<btnCount {
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
    
    func setupTopBottomButtons(btnCount: Int) {
        for _ in 0..<btnCount {
            let yDelayValue = Int(self.view.frame.height)
            let delayButton = makeButton(yValue: yDelayValue)
            bottomButtonArray.append(delayButton)
            self.view.addSubview(delayButton)
            
            let yTopButtonsValue = 0
            let topButton = makeButton(yValue: yTopButtonsValue)
            topButtonArray.append(topButton)
            self.view.addSubview(topButton)
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
        // create one per button or view
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideOrShowNavBar))
        //this would be your button
        button.addGestureRecognizer(tapGestureRecognizer)
        return button
    }
    
    func makeVerticalButton(xValue: Int) -> UIButton {
        let button = UIButton()
        button.frame = CGRect(x: Double(xValue), y: 0, width: 25, height: Double(self.view.frame.size.height))
        button.backgroundColor = UIColor.black
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        // create one per button or view
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideOrShowNavBar))
        //this would be your button
        button.addGestureRecognizer(tapGestureRecognizer)
        return button
    }
    
    func makeAngularButton(yValue: Int) -> UIView {
        let square = UIView()
        square.frame = CGRect(x: Int(self.view.frame.width), y: Int(self.view.frame.height), width: 25, height: Int(self.view.frame.height))
        square.backgroundColor = UIColor.black
        // create one per button or view
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideOrShowNavBar))
        //this would be your button
        square.addGestureRecognizer(tapGestureRecognizer)
        return square
    }
    
    func makeLandscapeAngularButton(yValue: Int) -> UIView {
        let square = UIView()
        square.frame = CGRect(x: Int(self.view.frame.width), y: Int(self.view.frame.height), width: 25, height: Int(self.view.frame.width))
        square.backgroundColor = UIColor.black
        
        return square
    }
    
    func setupColorButton() {
        for btnIdx in 0..<leftRightBtnCount {
            let btnColor: UIColor = optoKColorStatus ? UIColor.red : UIColor.black
            leftButtonArray[btnIdx].backgroundColor = btnColor
            rightButtonArray[btnIdx].backgroundColor = btnColor
        }
        for btnIdx in 0..<topBottomBtnCount {
            let btnColor: UIColor = optoKColorStatus ? UIColor.red : UIColor.black
            bottomButtonArray[btnIdx].backgroundColor = btnColor
            topButtonArray[btnIdx].backgroundColor = btnColor
            angularViewArray[btnIdx].backgroundColor = btnColor
        }
        colorButton.tintColor = optoKColorStatus ? UIColor.black : UIColor.red
    }
    
    @objc func timerAction() {
        eyeExerciseMotion()
    }
    
    func setupMenuOptions() {
        let titleStr = optoKColorStatus ? "Black-White Color" : "Red-White Color"
        let colorImg = optoKColorStatus ? UIImage(named: "black") : UIImage(named: "red")
        let menuColor = optoKColorStatus ? UIColor.white : UIColor.red
        
        optoMenuActions.removeAll()
        optoMenuActions.append(PopMenuDefaultAction(title: titleStr, image: colorImg, color: menuColor))
        
        menuOptoDirectionList.removeAll()
        
        switch optoCurrDirection {
        case .none:
            menuOptoDirectionList.removeAll()
        case .right:
            optoMenuActions.append(PopMenuDefaultAction(title: "Left Movement", image: UIImage(named: "left")))
            optoMenuActions.append(PopMenuDefaultAction(title: "Up Movement", image: UIImage(named: "top")))
            optoMenuActions.append(PopMenuDefaultAction(title: "Down Movement", image: UIImage(named: "bottom")))
            menuOptoDirectionList.append(.left)
            menuOptoDirectionList.append(.top)
            menuOptoDirectionList.append(.bottom)
        case .left:
            optoMenuActions.append(PopMenuDefaultAction(title: "Right Movement", image: UIImage(named: "right")))
            optoMenuActions.append(PopMenuDefaultAction(title: "Up Movement", image: UIImage(named: "top")))
            optoMenuActions.append(PopMenuDefaultAction(title: "Down Movement", image: UIImage(named: "bottom")))
            menuOptoDirectionList.append(.right)
            menuOptoDirectionList.append(.top)
            menuOptoDirectionList.append(.bottom)
        case .top:
            optoMenuActions.append(PopMenuDefaultAction(title: "Left Movement", image: UIImage(named: "left")))
            optoMenuActions.append(PopMenuDefaultAction(title: "Right Movement", image: UIImage(named: "right")))
            optoMenuActions.append(PopMenuDefaultAction(title: "Down Movement", image: UIImage(named: "bottom")))
            menuOptoDirectionList.append(.left)
            menuOptoDirectionList.append(.right)
            menuOptoDirectionList.append(.bottom)
        case .bottom:
            optoMenuActions.append(PopMenuDefaultAction(title: "Left Movement", image: UIImage(named: "left")))
            optoMenuActions.append(PopMenuDefaultAction(title: "Right Movement", image: UIImage(named: "right")))
            optoMenuActions.append(PopMenuDefaultAction(title: "Up Movement", image: UIImage(named: "top")))
            menuOptoDirectionList.append(.left)
            menuOptoDirectionList.append(.right)
            menuOptoDirectionList.append(.top)
        }
    }
    
    func eyeExerciseMotionManualControl() {
        setupMenuOptions()
        
        switch optoCurrDirection {
        case .none:
            stopAnimations()
        case .right:
            stopAnimations()
            animateButtonsRightOneAtTime(rptCount: -1)
        case .left:
            stopAnimations()
            animateButtonsLeftOneAtTime(rptCount: -1)
        case .top:
            stopAnimations()
            animateButtonsTopOneAtTime(rptCount: -1)
        case .bottom:
            stopAnimations()
            animateButtonsBottomOneAtTime(rptCount: -1)
        }
        optoPrevDirection = optoCurrDirection
    }
    
    func eyeExerciseMotion() {
        switch timerActionCtr {
        case 0:
            stopAnimations()
            animateButtonsRightOneAtTime(rptCount: 16)
            timerActionCtr += 1
        case 1:
            stopAnimations()
            animateButtons45DegOneAtTime(start: CGPoint(x: 0,y: Int(self.view.frame.height)), end: CGPoint(x: Int(self.view.frame.width), y: 0))
            timerActionCtr += 1
        case 2:
            stopAnimations()
            animateButtonsTopOneAtTime(rptCount: 8)
            timerActionCtr += 1
        case 3:
            stopAnimations()
            animateButtons45DegOneAtTime(start: CGPoint(x: Int(self.view.frame.width),y: Int(self.view.frame.height)), end: CGPoint(x: 0, y: 0))
            timerActionCtr += 1
        case 4:
            stopAnimations()
            animateButtonsLeftOneAtTime(rptCount: 8)
            timerActionCtr += 1
        case 5:
            stopAnimations()
            animateButtons45DegOneAtTime(start: CGPoint(x: Int(self.view.frame.width),y: 0), end: CGPoint(x: 0, y: Int(self.view.frame.height)))
            timerActionCtr += 1
        case 6:
            stopAnimations()
            animateButtonsBottomOneAtTime(rptCount: 16)
            timerActionCtr += 1
        case 7:
            stopAnimations()
            animateButtons45DegOneAtTime(start: CGPoint(x: 0,y: 0), end: CGPoint(x: Int(self.view.frame.width), y: Int(self.view.frame.height)))
            timerActionCtr = 0
        default:
            stopAnimations()
            animateButtonsRightOneAtTime(rptCount: 16)
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
    
    func animateButtonsTopOneAtTime(rptCount: Int) {
        var duration: Double = 7
        timerAnimationValue = 113
        for btnIdx in 0..<topBottomBtnCount {
            let delayBtn : Double = 0.2 * Double(btnIdx)
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft || UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
                duration = 20.0
                timerAnimationValue = 50
            }
            
            if rptCount > 0 {
                UIView.animate(withDuration: Double(duration), delay: Double(delayBtn), options: [.curveLinear, .repeat] , animations: {
                    UIView.setAnimationRepeatCount(8)
                    self.moveToTop(view: self.bottomButtonArray[btnIdx])
                }) { (finished) in
                    self.startAtBottom(view: self.bottomButtonArray[btnIdx])
                }
            }
            else {
                UIView.animate(withDuration: Double(duration), delay: Double(delayBtn), options: [.curveLinear, .repeat] , animations: {
                    self.moveToTop(view: self.bottomButtonArray[btnIdx])
                }) { (finished) in
                    self.startAtBottom(view: self.bottomButtonArray[btnIdx])
                }
            }
        }
    }
    
    func animateButtonsBottomOneAtTime(rptCount: Int) {
        var duration: Double = animationDurationLandscape
        for btnIdx in 0..<topBottomBtnCount {
            let delayBtn : Double = 0.25 * Double(btnIdx)
            timerAnimationValue = 135
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft || UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
                duration = 20.0
                timerAnimationValue = 62
            }
            
            if rptCount > 0 {
                UIView.animate(withDuration: Double(duration), delay: Double(delayBtn), options: [.curveLinear, .repeat] , animations: {
                    UIView.setAnimationRepeatCount(16)
                    self.moveToBottom(view: self.topButtonArray[btnIdx])
                }) { (finished) in
                    self.startAtTop(view: self.topButtonArray[btnIdx])
                }
            }
            else {
                UIView.animate(withDuration: Double(duration), delay: Double(delayBtn), options: [.curveLinear, .repeat] , animations: {
                    self.moveToBottom(view: self.topButtonArray[btnIdx])
                }) { (finished) in
                    self.startAtTop(view: self.topButtonArray[btnIdx])
                }
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
    
    @objc func hideOrShowNavBar(sender:UIGestureRecognizer) {
        if navigationController?.isNavigationBarHidden == true {
            navigationController?.isNavigationBarHidden = false
        } else {
            navigationController?.isNavigationBarHidden = true 
        }
    }
    
    func animateButtonsRightOneAtTime(rptCount: Int) {
        var duration: Double = animationDurationPortrait
        for btnIdx in 0..<leftRightBtnCount {
            var delayBtn : Double = 0.2 * Double(btnIdx)
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft || UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
                delayBtn = 1.0 * Double(btnIdx)
                timerAnimationValue = 75
                duration = 30.0
            }
            
            if rptCount > 0 {
                UIView.animate(withDuration: Double(duration), delay: Double(delayBtn), options: [.curveLinear, .repeat] , animations: {
                    UIView.setAnimationRepeatCount(16)
                    self.moveToRight(view: self.leftButtonArray[btnIdx])
                }) { (finished) in
                    self.startAtLeft(view: self.leftButtonArray[btnIdx])
                }
            }
            else {
                UIView.animate(withDuration: Double(duration), delay: Double(delayBtn), options: [.curveLinear, .repeat] , animations: {
                    self.moveToRight(view: self.leftButtonArray[btnIdx])
                }) { (finished) in
                    self.startAtLeft(view: self.leftButtonArray[btnIdx])
                }
            }
        }
        timerAnimationValue = 86
    }
    
    func animateButtonsLeftOneAtTime(rptCount: Int) {
        var duration: Double = 5
        for btnIdx in 0..<leftRightBtnCount {
            let delayBtn : Double = 0.25 * Double(btnIdx)
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft || UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
                duration = 30.0
            }
            
            if rptCount > 0 {
                UIView.animate(withDuration: Double(duration), delay: Double(delayBtn), options: [.curveLinear, .repeat] , animations: {
                    UIView.setAnimationRepeatCount(8)
                    self.moveToLeft(view: self.rightButtonArray[btnIdx])
                }) { (finished) in
                    self.startAtRight(view: self.rightButtonArray[btnIdx])
                }
            }
            else {
                UIView.animate(withDuration: Double(duration), delay: Double(delayBtn), options: [.curveLinear, .repeat] , animations: {
                    self.moveToLeft(view: self.rightButtonArray[btnIdx])
                }) { (finished) in
                    self.startAtRight(view: self.rightButtonArray[btnIdx])
                }
            }
        }
        timerAnimationValue = 86
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
        for btnIdx in 0..<topBottomBtnCount {
            let path = UIBezierPath()
            path.move(to: start)
            path.addLine(to: end)
            
            // create the animation
            let anim = CAKeyframeAnimation(keyPath: "position")
            anim.path = path.cgPath
            anim.rotationMode = CAAnimationRotationMode.rotateAuto
            anim.repeatCount = 16
            anim.duration = duration
            let delay: Double = Double(btnIdx) * 0.5
            anim.beginTime = CACurrentMediaTime() + delay
            
            // add the animation
            angularViewArray[btnIdx].layer.add(anim, forKey: "animate position along path")
        }
        timerAnimationValue = 134
    }
    
    func stopAnimations() {
        switch optoPrevDirection {
        case .none:
            for btnIdx in 0..<leftRightBtnCount {
                leftButtonArray[btnIdx].layer.removeAllAnimations()
            }
        case .right:
            for btnIdx in 0..<leftRightBtnCount {
                leftButtonArray[btnIdx].layer.removeAllAnimations()
            }
        case .left:
            for btnIdx in 0..<leftRightBtnCount {
                rightButtonArray[btnIdx].layer.removeAllAnimations()
            }
        case .top:
            for btnIdx in 0..<topBottomBtnCount {
                bottomButtonArray[btnIdx].layer.removeAllAnimations()
            }
        case .bottom:
            for btnIdx in 0..<topBottomBtnCount {
                topButtonArray[btnIdx].layer.removeAllAnimations()
            }
        }
        self.view.layer.removeAllAnimations()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: Double(timerAnimationValue), target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
    }
}

extension OptokineticViewController: PopMenuViewControllerDelegate {
    
    func popMenuDidSelectItem(_ popMenuViewController: PopMenuViewController, at index: Int) {
        if index == 0 {
            optoKColorStatus = !optoKColorStatus
            setupColorButton()
            setupMenuOptions()
        }
        else if index > 0 {
            optoCurrDirection = menuOptoDirectionList[index-1]
            eyeExerciseMotionManualControl()
        }
    }
    
}

