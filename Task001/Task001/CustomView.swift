//
//  CustomView.swift
//  Task002
//
//  Created by Ankit Kumar Bharti on 30/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class CustomView: NSView {

    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var deleteButton: NSButton!
    
    var willDeleteItemAtIndex: ((Int) -> ())? = nil
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    @IBAction func deleteItem(_ sender: NSButton) {
        willDeleteItemAtIndex?(sender.tag)
    }
}
