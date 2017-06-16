//
//  FirstViewController.swift
//  SwiftLearn
//
//  Created by 于君 on 16/6/30.
//  Copyright © 2016年 zwh. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hello,world")
        let implicit :Double = 1.0
        var varStr :String?
        _ = varStr?.hashValue
        
        varStr = "hello"
        print("\(varStr)+ \(implicit)")
        print(implicit)
        var descLB :UILabel
        descLB = UILabel.init(frame: CGRectMake(0, 40, 320, 69))
        descLB.backgroundColor = UIColor.yellowColor()
        descLB.text = "addNewLable"
      
        _ = UIButton.init(type: UIButtonType.Custom)as UIButton
        var targetBT:UIButton
        targetBT = UIButton.init(frame: CGRectMake(0, 120, 320, 40))
        targetBT.backgroundColor = UIColor.redColor()
        targetBT.setTitle("normalTitle", forState: UIControlState.Normal)
        targetBT.addTarget(self, action: #selector(FirstViewController.action1(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(descLB)
        self.view.addSubview(targetBT)
        // Do any additional setup after loading the view, typically from a nib.
    }
    func action1(sender:UIButton) -> Void {
        print(sender.currentTitle)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

