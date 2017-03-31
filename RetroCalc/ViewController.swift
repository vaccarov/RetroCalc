//
//  ViewController.swift
//  RetroCalc
//
//  Created by VACCARO on 30/03/2017.
//  Copyright © 2017 VACCARO. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var outputLbl: UILabel!
    var btnSound : AVAudioPlayer!

    enum Operation: String{
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var operationCourante = Operation.Empty
    var nombreCourant = ""
    var nbrGauche = ""
    var nbrDroit = ""
    var result = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        outputLbl.text = "0"
    }
    
    func playSound(){
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }

    @IBAction func numberPressed(sender: UIButton){
        playSound()
        nombreCourant += "\(sender.tag)"
        outputLbl.text = nombreCourant
    }
    
    @IBAction func onDividePressed(sender: UIButton){
        processOperation(operation: .Divide)
    }
    @IBAction func onMultiplyPressed(sender: UIButton){
        processOperation(operation: .Multiply)
    }
    @IBAction func onSubtractPressed(sender: UIButton){
        processOperation(operation: .Subtract)
    }
    @IBAction func onAddPressed(sender: UIButton){
        processOperation(operation: .Add)
    }
    @IBAction func onEqualPressed(sender: UIButton){
        processOperation(operation: operationCourante)
    }

    @IBAction func clearBtn(_ sender: UIButton) {
        outputLbl.text = "0"
        nombreCourant = "0"
        nbrGauche = "0"
        operationCourante = Operation.Empty
    }
    func processOperation(operation : Operation){
        playSound()
        if operationCourante != Operation.Empty {
            if nombreCourant != "" {
                nbrDroit = nombreCourant
                nombreCourant = ""
                
                if operationCourante == Operation.Multiply {
                    result = "\(Double(nbrGauche)! * Double(nbrDroit)!)"
                } else if operationCourante == Operation.Divide {
                    result = "\(Double(nbrGauche)! / Double(nbrDroit)!)"
                } else if operationCourante == Operation.Subtract {
                    result = "\(Double(nbrGauche)! - Double(nbrDroit)!)"
                } else if operationCourante == Operation.Add {
                    result = "\(Double(nbrGauche)! + Double(nbrDroit)!)"
                }
            }
            nbrGauche = result
            outputLbl.text = result
        } else {
            nbrGauche = nombreCourant
            nombreCourant = ""
        }
        operationCourante = operation
    }
    
}

