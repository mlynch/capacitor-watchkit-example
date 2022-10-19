//
//  InterfaceController.swift
//  IonifitsWatch WatchKit Extension
//
//  Created by Max Lynch on 2/25/22.
//

import WatchKit
import WatchConnectivity
import Foundation

class InterfaceController: WKInterfaceController, TestDataProvider, SessionCommands {
  
    @IBOutlet var coworkersButton: WKInterfaceButton!
    @IBOutlet var bookTravelButton: WKInterfaceButton!
    @IBOutlet var expenseButton: WKInterfaceButton!
  
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }
    
    @IBAction func coworkersAction() {
        print("Opening coworkers")
    }
    
    @IBAction func bookTravelAction() {
        print("Booking travel")
    }
    
    @IBAction func expenseAction() {
        print("Expensing")
        sendMessage(timedColor())
    }
    
    private func timedColor() -> [String: Any] {
        let red = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        let green = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        let blue = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        
        let randomColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        
        let data = try? NSKeyedArchiver.archivedData(withRootObject: randomColor, requiringSecureCoding: false)
        guard let colorData = data else { fatalError("Failed to archive a UIColor!") }
    
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        let timeString = dateFormatter.string(from: Date())
        
        return [PayloadKey.timeStamp: timeString, PayloadKey.colorData: colorData]
    }

}
