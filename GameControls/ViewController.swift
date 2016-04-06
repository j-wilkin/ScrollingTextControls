//
//  ViewController.swift
//  GameControls
//
//  Created by Jason Wilkin on 2/5/16.
//  Copyright © 2016 Jason Wilkin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var text = [
        "Line 1: Hey there. Here is a test of the text box!",
        "Line 2: Here's some more text to test.",
        "Line 3: Hey there. Here is a test of the text box!",
        "Line 4: Here's some more text to test.",
        "Line 5: Hey there. Here is a test of the text box!",
        "Line 6: Here's some more text to test.",
        "This is the last line!!!"
    ]
    
    
    @IBOutlet var textView: ScrollingTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.lines = text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        textView.fetchNextCharacter()
    }

}

