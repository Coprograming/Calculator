//
//  ViewController.swift
//  Retro-Calculator
//
//  Created by Kasey Schlaudt on 5/22/16.
//  Copyright © 2016 com.coprograming.com. All rights reserved.
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
        case Clear = "Cleared"
        
    }
    
    @IBOutlet var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    let clearValStr = 0
    var currentOperation : Operation = Operation.Empty
    var result = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do{
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()

        }catch let err as NSError{
            print(err.debugDescription)
        }
        
    }
    @IBAction func numberPressed(btn: UIButton!){
        playSound()
        
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }

    @IBAction func onDividePress(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPress(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPress(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPress(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPress(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    @IBAction func onClearPress(sender: AnyObject) {
        processOperation(Operation.Clear)
        outputLbl.text = "\(0)"
       
        
    }
    
    
    func processOperation(op: Operation){
        playSound()
        
        if currentOperation != Operation.Empty{
            
            if runningNumber != "" {
            rightValStr = runningNumber
            runningNumber = ""
            
            if currentOperation == Operation.Multiply {
                result = "\(Double(leftValStr)! * Double(rightValStr)!)"
            }else if currentOperation == Operation.Divide{
                result = "\(Double(leftValStr)! / Double(rightValStr)!)"
            }else if currentOperation == Operation.Subtract{
                result = "\(Double(leftValStr)! - Double(rightValStr)!)"
            }else if currentOperation == Operation.Add{
                result = "\(Double(leftValStr)! + Double(rightValStr)!)"
            }else {
                result = "\(Double(clearValStr) * Double(leftValStr)! + Double(rightValStr)!)"
                }
            
            leftValStr = result
            outputLbl.text = result
            }
            
            currentOperation = op
            
        }else {
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }else {
        btnSound.play()
        }
    }
}

