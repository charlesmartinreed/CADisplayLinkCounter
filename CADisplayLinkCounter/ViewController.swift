//
//  ViewController.swift
//  CADisplayLinkCounter
//
//  Created by Charles Martin Reed on 11/28/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //STEP 1: Create a UILabel
    let countingLabel: UILabel = {
        let label = UILabel()
        label.text = "1234"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add the label as a subview, give it a frame so that it can be drawn on screen
        view.addSubview(countingLabel)
        countingLabel.frame = view.frame
        
        //STEP 2: Create a CADisplayLink here
        let displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate))
        //add the run loop on the main thread
        displayLink.add(to: .main, forMode: .default)
        
        //FAILURE: UIView can't help us here
//        UIView.animate(withDuration: 2.5) {
//            self.countingLabel.text = "99999" //basically, the text instantaneously turns into 99999
//        }
    }
    
    //our counting values for the animation in handleUpdate
    var startValue: Double = 0
    let endValue: Double = 1000
    let animationDuration: Double = 1.5
    
    //animation timing
    let animationStartDate = Date()
    
    @objc func handleUpdate() {
        //calculate % of time since animation began
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartDate)
        
        //stop the animation
        if elapsedTime > animationDuration {
            countingLabel.text = "\(endValue)"
        } else {
            let percentage = elapsedTime / animationDuration
            let value = startValue + percentage * (endValue - startValue)
            countingLabel.text = "\(value)"
        }
        
        //let seconds = Date().timeIntervalSince1970
        //countingLabel.text = "\(seconds) since 1970"
        //print(Date()) //for testing
    }


}

