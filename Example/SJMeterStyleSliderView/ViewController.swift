//
//  ViewController.swift
//  SliderTest
//
//  Created by mac on 24/07/18.
//  Copyright © 2018 SumitJagdev. All rights reserved.
//

import UIKit
import SJSliderView

class ViewController: UIViewController, SJSliderViewDelegate {

    @IBOutlet var sliderView : SJSliderView!
    @IBOutlet var stepper : UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.sliderView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func valueChanged(_ sender: UIStepper) {
        self.sliderView.moveSliderToIndex(index: Int(sender.value), withAnimation: true)
        
    }
    func didChangeSelectedIndex(index: Int) {
        print("Selected Index : ", index)
        stepper.value = Double(index)
    }

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
////        print(self.sliderView.selectedIndex)
//        self.sliderView.moveSliderToIndex(index: 10)
//    }
}

