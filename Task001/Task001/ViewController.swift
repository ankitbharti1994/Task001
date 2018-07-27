//
//  ViewController.swift
//  Task001
//
//  Created by Ankit Kumar Bharti on 27/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @objc dynamic var continents: [String] = ["India","Africa","America"]
    @objc dynamic var value: String? = nil
    private var selectedNodes: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didDoubleClicked(_ sender: NSTableView) {
        value = continents[sender.selectedRow]
        selectedNodes = sender.selectedRow
    }
    
    
    @IBAction func submitValue(_ sender: Any) {
        guard let val = value, let selectedRow = selectedNodes else { return }
        continents[selectedRow] = val
        value = nil
        selectedNodes = nil
    }
}
