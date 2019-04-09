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
    
    // Tabbar tabs and tabbar
    var firstTab: UIView! { get set }
    var secondTab: UIView! { get set }
    var thirdTab: UIView! { get set }
    var fourthTab: UIView? { get set }
    var fifthTab: UIView? { get set }
    var bar: UIView! {get set}
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
    
    public enum FlowStyles: String {
        case test = "test"
    }
    
    let gravity = UIGravityBehavior()
    var collision: UICollisionBehavior!
    var animator: UIDynamicAnimator!
    
    func gravityUpdated(motion: CMDeviceMotion!, error: Error!) {
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
        }
    }
    
    func configureDynamics() {
        animator = UIDynamicAnimator(referenceView: flowBarController.bar)
        animator.addBehavior(gravity)
        gravity.addItem(firstTab)
        gravity.addItem(secondTab)
    }
    
    // MARK: Flow animations
    func perfromFlowAnimation() {
        if let animation = FlowStyles(rawValue: flowStyle) {
            switch animation {
            case .test:
            
                configureDynamics()
                
                let itemBehavior = UIDynamicItemBehavior(items: [firstTab, secondTab])
                itemBehavior.elasticity = 0.7
                animator.addBehavior(itemBehavior)
                
                collision = UICollisionBehavior(items: [firstTab, secondTab])
                collision.translatesReferenceBoundsIntoBoundary = true
                animator.addBehavior(collision)
            }
        }
    }
}


