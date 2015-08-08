//
//  ViewController.swift
//  SimpleCircleCountdownView
//
//  Created by shenyun on 2015/8/7.
//  Copyright (c) 2015年 shenyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cdvCountdown:SimpleCircleCountdownView!
    
    @IBAction func actionStartCountdown(sender:UIButton){
        cdvCountdown.startCountDown()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        cdvCountdown.totalTime = 11

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

