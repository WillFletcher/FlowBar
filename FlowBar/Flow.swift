//
//  Flow.swift
//  FlowBar
//
//  Created by Will Fletcher on 3/30/19.
//  Copyright © 2019 Will Fletcher. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol Flowable {
    
    var flowStyle: String { get set }
    
    // UIKitDynamics properties
    var animator: UIDynamicAnimator { get set }
    var gravity: UIGravityBehavior { get set }
    var collision: UICollisionBehavior { get set }
    
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
    
    private var animation: String {
        set {
            self.flowBarController.flowStyle = newValue
        }
        get {
            return self.flowBarController.flowStyle
        }
    }
    
    private var firstTab: UIView {
        set {
            self.flowBarController.firstTab = newValue
        }
        get {
            return self.flowBarController.firstTab
        }
    }
    
    public enum FlowStyles: String {
        case test = "test"
    }
    
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var animator: UIDynamicAnimator!
    
    // MARK: Flow animations
    func perfromFlowAnimation() {
        if let animation = FlowStyles(rawValue: animation) {
            switch animation {
            case .test:
                
                animator = UIDynamicAnimator(referenceView: flowBarController.bar)
                gravity = UIGravityBehavior(items: [firstTab])
                animator.addBehavior(gravity)
                
                print("enabled test animation")
            }
        }
    }
}



