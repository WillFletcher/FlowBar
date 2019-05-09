//
//  Flow.swift
//  FlowBar
//
//  Created by Will Fletcher on 3/30/19.
//  Copyright © 2019 Will Fletcher. All rights reserved.
//

import Foundation
import UIKit
import CoreMotion

public var flowStyle = ""

@objc public protocol Flowable {
    
    // Tab bar tabs
    var firstTab: UIView { get set }
    var secondTab: UIView { get set }
    var thirdTab: UIView { get set }
    var fourthTab: UIView { get set }
    var fifthTab: UIView { get set }
    
    // Tab bar
    var bar: UIView { get set }
}

public final class Flow: NSObject {
    
    private unowned var flowBarController: Flowable
    
    init(_ controller: FlowBarController) {
        self.flowBarController = controller
        
        super.init()
    }
    
    private var firstTab: UIView {
        set {
            self.flowBarController.firstTab = newValue
        }
        get {
            return self.flowBarController.firstTab
        }
    }
    
    private var secondTab: UIView {
        set {
            self.flowBarController.secondTab = newValue
        }
        get {
            return self.flowBarController.secondTab
        }
    }
    
    private var thirdTab: UIView {
        set {
            self.flowBarController.secondTab = newValue
        }
        get {
            return self.flowBarController.thirdTab
        }
    }
    
    private var fourthTab: UIView {
        set {
            self.flowBarController.secondTab = newValue
        }
        get {
            return self.flowBarController.fourthTab
        }
    }
    
    private var fifthTab: UIView {
        set {
            self.flowBarController.secondTab = newValue
        }
        get {
            return self.flowBarController.fifthTab
        }
    }
    
    private var tabBar: UIView {
        set {
            self.flowBarController.bar = newValue
        }
        get {
            return self.flowBarController.bar
        }
    }
    
    public enum FlowStyles: String {
        case rainstick = "rainstick"
        case bookshelf = "bookshelf"
    }
    
    let gravity = UIGravityBehavior()
    var collision: UICollisionBehavior!
    var animator: UIDynamicAnimator!
    
    var leftTiltToggled = false
    var rightTiltToggled = false
    
    func configureDynamics() {
        animator = UIDynamicAnimator(referenceView: flowBarController.bar)
        animator.addBehavior(gravity)
        gravity.addItem(firstTab)
        gravity.addItem(secondTab)
        gravity.addItem(thirdTab)
        gravity.addItem(fourthTab)

        switch tabBar.subviews.count {
        case 2:
        gravity.addItem(firstTab)
        
        case 3:
        gravity.addItem(firstTab)
        gravity.addItem(secondTab)
       
        case 4:
        gravity.addItem(firstTab)
        gravity.addItem(secondTab)
        gravity.addItem(thirdTab)
 
        case 5:
        gravity.addItem(firstTab)
        gravity.addItem(secondTab)
        gravity.addItem(thirdTab)
        gravity.addItem(fourthTab)
        
        default: break

        }
    }
    
    func activateRainstick(motion: CMDeviceMotion!, error: Error!) {
        DispatchQueue.main.async {
            
            if error != nil {
                print("error: \(error!)")
            }
            
            let grav = motion.gravity
            
            let x = CGFloat(grav.x)
            let y = CGFloat(grav.y)
            let p = CGPoint(x: x, y: y)
            
            let v = CGVector(dx: p.x, dy: 0 - p.y)
            self.gravity.gravityDirection = v
            
            print("x: \(grav.x)")
            print("y \(grav.y)")
            print("z: \(grav.z)")
            
        }
    }
    
    func activateBookShelfGravity(motion: CMDeviceMotion!, error: Error!) {
        DispatchQueue.main.async {
            
            if error != nil {
                print("error: \(error!)")
            }
            
            let grav = motion.gravity
            
            let x = CGFloat(grav.x)
            let y = CGFloat(grav.y)
            let p = CGPoint(x: x, y: y)
            
            let v = CGVector(dx: p.x, dy: 0 - p.y)
            self.gravity.gravityDirection = v
            
            print("x: \(grav.x)")
            print("y \(grav.y)")
            print("z: \(grav.z)")
            
            // Tilted top of the device to the right
            if grav.x > 0.49 && grav.x < 0.9 {
                if self.rightTiltToggled == true || self.leftTiltToggled == false {
                    UIView.animate(withDuration: 0.9, delay: 0, options: [.allowUserInteraction], animations: {
                        self.firstTab.center.x += 15
                        
                        self.rightTiltToggled = false
                        self.leftTiltToggled = true
                    }, completion: nil)
                }
            }
            
            if grav.x < -0.49 && grav.x > -0.9 {
                // Tilted top of the device to the left
                if self.rightTiltToggled == false || self.leftTiltToggled == true {
                    UIView.animate(withDuration: 0.9, delay: 0, options: [.allowUserInteraction], animations: {
                        self.firstTab.center.x -= 15
                        
                        self.leftTiltToggled = false
                        self.rightTiltToggled = true
                    }, completion: nil)
                }
            }
            
            if grav.x > -0.49 && grav.x < 0.48 {
                UIView.animate(withDuration: 0.9, delay: 0, options: [.allowUserInteraction], animations: {
                    if self.leftTiltToggled == false && self.rightTiltToggled == true {
                        self.firstTab.center.x += 15
                        
                        self.rightTiltToggled = false
                        self.leftTiltToggled = false
                        
                    } else if self.leftTiltToggled == true && self.rightTiltToggled == false {
                        self.firstTab.center.x -= 15
                        
                        self.rightTiltToggled = false
                        self.leftTiltToggled = false
                    }
                }, completion: nil)
            }
        }
    }
    
    // MARK: Flow animations
    func perfromFlowAnimation() {
        
        if let animation = FlowStyles(rawValue: flowStyle) {
            let itemBehavior = UIDynamicItemBehavior()
            switch animation {
            case .rainstick:
                
                configureDynamics()
                
                switch tabBar.subviews.count {
                case 1:
                    print("FlowBar contains no tabs")
                case 2:
                    itemBehavior.addItem(firstTab)
                    
                    collision = UICollisionBehavior(items: [firstTab])
                case 3:
                    itemBehavior.addItem(firstTab)
                    itemBehavior.addItem(secondTab)
                    
                    collision = UICollisionBehavior(items: [firstTab, secondTab])
                case 4:
                    itemBehavior.addItem(firstTab)
                    itemBehavior.addItem(secondTab)
                    itemBehavior.addItem(thirdTab)
                    
                    collision = UICollisionBehavior(items: [firstTab, secondTab, thirdTab])
                case 5:
                    itemBehavior.addItem(firstTab)
                    itemBehavior.addItem(secondTab)
                    itemBehavior.addItem(thirdTab)
                    itemBehavior.addItem(fourthTab)
                    
                    collision = UICollisionBehavior(items: [firstTab, secondTab, thirdTab, fourthTab])
                    
                default: break
                }
                
                itemBehavior.elasticity = 0.7
                animator.addBehavior(itemBehavior)
                
                collision.translatesReferenceBoundsIntoBoundary = true
                animator.addBehavior(collision)
                
                print("rainstick")
                
            case .bookshelf:
                print("bookshelf")
            }
        }
    }
}



