//
//  ViewController.swift
//  SimTest
//
//  Created by Jason Wilkin on 2/5/16.
//  Copyright © 2016 Jason Wilkin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var textBox: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    var text = [
        "Hey there. Here is a test of the text box!",
        "Here's some more text to test.",
        "This is the last line!!!"
    ]
    var currentLineIndex = 0
    var currentCharIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textBox.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        fetchNextCharacter()
    }
    
    
    @IBAction func nextButtonTap(sender: UIButton) {
        if currentLineIndex < text.count {
            currentLineIndex += 1
            currentCharIndex = 0
            fetchNextCharacter()
        }
    }

    
    
    func fetchNextCharacter() {
        if currentLineIndex == text.count {
            // No more lines
            return
        }
            
        let currentLine = text[currentLineIndex]
        if currentCharIndex > currentLine.characters.count {
            // Advance to the next line
            //currentLineIndex += 1
            currentCharIndex = 0
            return
        }
        
        // Update textBox
        let index = currentLine.startIndex.advancedBy(currentCharIndex)
        updateTextBoxAfterDelay(currentLine.substringToIndex(index), waitTime: 0.1)
    }
    
    
    func updateTextBoxAfterDelay(str: String, waitTime: NSTimeInterval) {
        
        let delay = waitTime * Double(NSEC_PER_SEC)
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(dispatchTime, dispatch_get_main_queue()) { () -> Void in
            self.textBox.text = str
            self.currentCharIndex += 1
            self.fetchNextCharacter()
        }
        
    }
    
    
    // http://stackoverflow.com/questions/24034544/dispatch-after-gcd-in-swift/24318861#24318861
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    

}

