//
//  ScrollingTextView.swift
//  SimTest
//
//  Created by Jason Wilkin on 2/7/16.
//  Copyright © 2016 Jason Wilkin. All rights reserved.
//

import Foundation
import UIKit

class ScrollingTextView: UIView {
    
    
    @IBOutlet weak var textBox: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    var lines = [String]()
    var currentLineIndex = 0
    var currentCharIndex = 0
    
    
    override func awakeFromNib() {
        self.textBox.text = ""
    }

    func setLinesAndBegin(lines: [String]) {
        self.lines = lines
        fetchNextCharacter()
    }

    
    @IBAction func nextButtonTap(sender: UIButton) {
        if currentLineIndex == lines.count {
            return
        }
        
        if self.currentCharIndex < lines[currentLineIndex].characters.count {
            finishLine()
        }
        else if currentLineIndex < lines.count {
            currentLineIndex += 1
            currentCharIndex = 0
            fetchNextCharacter()
        }
    }
    
    func finishLine() {
        self.textBox.text = lines[currentLineIndex]
        currentCharIndex = lines[currentLineIndex].characters.count
    }
    
    func fetchNextCharacter() {
        if currentLineIndex == lines.count {
            // No more lines
            return
        }
        
        let currentLine = lines[currentLineIndex]
        if currentCharIndex > currentLine.characters.count {
            // Advance to the next line
            return
        }
        
        // Update textBox
        let index = currentLine.startIndex.advancedBy(currentCharIndex)
        updateTextBoxAfterDelay(currentLine.substringToIndex(index), waitTime: 0.05, lineNumber: currentLineIndex)
    }
    
    
    func updateTextBoxAfterDelay(str: String, waitTime: NSTimeInterval, lineNumber: Int) {
        
        let delay = waitTime * Double(NSEC_PER_SEC)
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(dispatchTime, dispatch_get_main_queue()) { () -> Void in
            
            let lineFinished = self.textBox.text == self.lines[lineNumber]
            // Ensure we are still printing the same line and that the line has not been completed
            if self.currentLineIndex == lineNumber && !lineFinished {
                self.textBox.text = str
                self.textBox.sizeToFit()
                self.currentCharIndex += 1
                self.fetchNextCharacter()
            }
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