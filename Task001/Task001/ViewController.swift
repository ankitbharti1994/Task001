//
//  ViewController.swift
//  Task001
//
//  Created by Ankit Kumar Bharti on 27/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @objc dynamic var nodes: [Node] = []
    @objc dynamic var selectedNodes: [Node] = []
    @IBOutlet private weak var sourceTableView: NSTableView!
    @IBOutlet private weak var destinationTableView: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
    }
    
    private func registerTableView() {
        sourceTableView.registerForDraggedTypes([.string])
        destinationTableView.registerForDraggedTypes([.string])
    }
    
    @IBAction func didDoubleClicked(_ sender: NSTableView) {
        insertSelectedNode(indexSet: sender.selectedRowIndexes)
    }
    
    @IBAction func copyNode(_ sender: Any) {
        insertSelectedNode(indexSet: sourceTableView.selectedRowIndexes)
    }
    
    private func insertSelectedNode(indexSet: IndexSet) {
        if !indexSet.isEmpty {
            for index in indexSet.makeIterator() {
                let node = nodes[index]
                if !selectedNodes.contains(node) {
                    selectedNodes.append(node)
                }
            }
        }
        
    }
}

// MARK:- NSTableViewDataSource

extension ViewController: NSTableViewDataSource {
    
    // MARK:- Drag Operation
    
    func tableView(_ tableView: NSTableView, pasteboardWriterForRow row: Int) -> NSPasteboardWriting? {
        guard tableView == sourceTableView else {
            return nil
        }
        let pasteboardItem = NSPasteboardItem()
        pasteboardItem.setString(nodes[row].name, forType: .string)
        return pasteboardItem
    }
    
    // MARK:- Drop Operation
    
    func tableView(_ tableView: NSTableView, validateDrop info: NSDraggingInfo, proposedRow row: Int, proposedDropOperation dropOperation: NSTableView.DropOperation) -> NSDragOperation {
        return .copy
    }
    
    func tableView(_ tableView: NSTableView, acceptDrop info: NSDraggingInfo, row: Int, dropOperation: NSTableView.DropOperation) -> Bool {
        guard tableView == destinationTableView else {
            return false
        }
        let pasteboard = info.draggingPasteboard()
        guard let name = pasteboard.string(forType: .string) else { return false }
        let names = name.components(separatedBy: "\n")
        let _ = names.map {[weak self] in
            self?.selectedNodes.append(Node(name: $0))
        }
        return true
    }
}



extension ViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        guard let view = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("Cell"), owner: self) as? NSTableCellView, let customView = view.subviews.first as? CustomView else { return nil }
        customView.deleteButton.tag = row
        customView.willDeleteItemAtIndex = {[weak self] in
            self?.selectedNodes.remove(at: $0)
        }
        return view
        
    }
}
