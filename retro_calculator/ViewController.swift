//
//  ViewController.swift
//  retro_calculator
//
//  Created by Matthew Schmale on 2/13/16.
//  Copyright © 2016 Schmale. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var OutPutLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    
    var result = ""
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        
        
        do {
            
        try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            
           print( err.debugDescription)
        }
        
    }
    

    @IBAction func numPressed(btn: UIButton!){
        playSound()
        runningNumber += "\(btn.tag)"
        OutPutLbl.text = runningNumber
     
    }
    
    
    
    @IBAction func OnDividePress(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func OnMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func OnAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
   
    @IBAction func OnSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func OnEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    func processOperation(op: Operation) {
       playSound()
        
        if currentOperation != Operation.Empty{
            //Run Math
            
            //A user entered an operator, but then selected another operator without
            //first entering a number
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply{
                    result =  "\(Double(leftValStr)! * Double(rightValStr)! )"
                    
                } else if currentOperation == Operation.Divide{
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                    
                } else if currentOperation == Operation.Subtract{
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                    
                } else if currentOperation == Operation.Add{
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                OutPutLbl.text = result
            }
             currentOperation = op
        
                } else {
            
                //This is the first time an operator has been pressed
                leftValStr = runningNumber
                runningNumber = ""
                currentOperation = op

                }
       
    }
   
    @IBAction func whenPressClear( clearbtn: UIButton!){
        playSound()
        resetCalc()
    }
    
    func playSound() {
        if btnSound.playing{
            btnSound.stop()
            }
        btnSound.play()
        }
    func resetCalc(){
        OutPutLbl.text = "0"
         runningNumber = ""
         leftValStr = ""
         rightValStr = ""
         currentOperation = Operation.Empty
         result = ""
    }
        
}

