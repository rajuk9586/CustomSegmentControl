//
//  ViewController.swift
//  CustomSegmentController
//
//  Created by Raju Kumar on 18/12/23.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var customSegmentControl: CustomSegmentControl!
    @IBOutlet weak var customSegmentControl2: CustomSegmentControl2!
    @IBOutlet weak var customSegmentControl3: CustomSegmentControl3!
    @IBOutlet weak var customSegmentControl4: CustomSegmentControl4!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customSegmentControl.commaSeparatedButtonTitles = "Books,Videos"
        customSegmentControl.selectedSegmentIndex = 1
        customSegmentControl.updateView()
        customSegmentControl2.commaSeparatedButtonTitles = "Drive,Vehicle,Color"
        customSegmentControl2.selectedSegmentIndex = 1
        customSegmentControl2.updateView()
        customSegmentControl3.commaSeparatedButtonTitles = "1,2,3,4,5"
        customSegmentControl3.selectedSegmentIndex = 1
        customSegmentControl3.updateView()
        customSegmentControl4.commaSeparatedButtonTitles = "Drive,Vehicle,Color,Books,Videos,Drive1,Vehicle1,Color1,Books1,Video1s"
        customSegmentControl4.selectedSegmentIndex = 1
        customSegmentControl4.updateView()
        
//        for family in UIFont.familyNames {
//            print("Font Family: \(family)")
//            for name in UIFont.fontNames(forFamilyName: family) {
//                print("    \(name)")
//            }
//        }
    }

    @IBAction func SegmentedControlValueChanged(_ sender: CustomSegmentControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("Books")
        case 1:
            print("Videos")
        default:
            break
        }
    }
    @IBAction func SegmentedControl2ValueChanged(_ sender: CustomSegmentControl2) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("Books")
        case 1:
            print("Videos")
        default:
            break
        }
    }
    
    @IBAction func SegmentedControl3ValueChanged(_ sender: CustomSegmentControl3) {
        print(sender.selectedSegmentIndex)
       
    }
    
    @IBAction func SegmentedControl4ValueChanged(_ sender: CustomSegmentControl4) {
        print(sender.selectedSegmentIndex.description)
       
    }
    
}

