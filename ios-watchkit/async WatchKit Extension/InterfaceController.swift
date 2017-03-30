//
//  InterfaceController.swift
//  async WatchKit Extension
//
//  Created by Jan Stárek on 25/03/2017.
//  Copyright © 2017 Jan Stárek. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController
{
    
    @IBAction func refreshButtonClicked()
    {
        let client = WebServiceApi()
        self.refreshLabel.setText("Downloading...")
        self.refreshButton.setEnabled(false)
        client.getSupportedLanguages()
        {
            response in
            self.refreshLabel.setText("")
            self.refreshButton.setEnabled(true)
            if response != nil
            {
                self.showNewData(languages: response!)
            }
            else
            {
                self.showError()
            }

        }
    }
    
    @IBOutlet var table: WKInterfaceTable!
    @IBOutlet var refreshLabel: WKInterfaceLabel!
    @IBOutlet var refreshButton: WKInterfaceButton!
    
    var tableItems : [String] = []
    
    override func awake(withContext context: Any?)
    {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        setTable()
        
    }
    
    private func showNewData(languages: [String])
    {
        tableItems = languages
        DispatchQueue.main.async
        {
            self.setTable()
            self.refreshLabel.setText("")
        }
        
    }
    
    private func showError()
    {
        
        DispatchQueue.main.async
        {
            self.setTable()
            self.refreshLabel.setText("Net error")
        }
    }
    
    override func willActivate()
    {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate()
    {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int)
    {
    }
    
    func setTable()
    {
        // Setting table
        table.setNumberOfRows(tableItems.count, withRowType: "Row")
        
        for i in 0 ..< tableItems.count
        {
            if let row = table.rowController(at: i) as? Row
            {
                row.rowLabel.setText(tableItems[i])
            }
        }
    }

}
