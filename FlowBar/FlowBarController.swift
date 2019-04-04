//
//  FlowBarController.swift
//  FlowBar
//
//  Created by Will Fletcher on 3/31/19.
//  Copyright © 2019 Will Fletcher. All rights reserved.
//

import UIKit

public class FlowBarController: UITabBarController, Flowable {
    
    public var flowStyle = ""
    
    public var animator = UIDynamicAnimator()
    public var gravity = UIGravityBehavior()
    public var collision = UICollisionBehavior()
    
    public var firstTab: UIView?
    public var secondTab: UIView?
    public var thirdTab: UIView?
    public var fourthTab: UIView?
    public var fifthTab: UIView?
    public var bar: UIView!
    
    lazy public var flow: Flow = Flow(self)
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bar = self.tabBar
        
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        configureTabs()
        animate()
    }
    
    func configureTabs() {
        
        // Initialize tab properties according to the number of tabs on the tab bar
        // Note: Tab bar's UIBarBackground counts as a subview at index 0. This is why indexing for tabs begins at index 1
        
        switch tabBar.subviews.count {
        case 1:
            print("FlowBar contains no tabs")
            
        case 2:
            firstTab = self.tabBar.subviews[1]
            print("FlowBar contains one tab")
            
        case 3:
            firstTab = self.tabBar.subviews[1]
            secondTab = self.tabBar.subviews[2]
           
        case 4:
            firstTab = self.tabBar.subviews[1]
            secondTab = self.tabBar.subviews[2]
            thirdTab = self.tabBar.subviews[3]
            
        case 5:
            firstTab = self.tabBar.subviews[1]
            secondTab = self.tabBar.subviews[2]
            thirdTab = self.tabBar.subviews[3]
            fourthTab = self.tabBar.subviews[4]
            
        default: break
        }
    }
    
    func configureDynamics() {
        animator = UIDynamicAnimator(referenceView: self.tabBar)
    }
    
    public func animate() {
        self.flowStyle = "test"
        self.flow.perfromFlowAnimation()
    }
}
