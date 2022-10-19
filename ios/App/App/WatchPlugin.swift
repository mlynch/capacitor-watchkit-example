import Capacitor

@objc(WatchPlugin)
public class WatchPlugin : CAPPlugin {
    override public func load() {
        super.load()
        NotificationCenter.default.addObserver(
            self, selector: #selector(type(of: self).dataDidFlow(_:)),
            name: .dataDidFlow, object: nil
        )
    }
    @objc
    func dataDidFlow(_ notification: Notification) {
        guard let commandStatus = notification.object as? CommandStatus else { return }

        // If an error occurs, show the error message and returns.
        //
        if let errorMessage = commandStatus.errorMessage {
            print("! \(commandStatus.command.rawValue)...\(errorMessage)")
            return
        }
        
        guard let timedColor = commandStatus.timedColor else { return }
        
        self.notifyListeners("message", data: [
            "tab": "expenses"
        ])
        
        print("#\(commandStatus.command.rawValue)...\n\(commandStatus.phrase.rawValue) at \(timedColor.timeStamp)")
        
        if let fileURL = commandStatus.file?.fileURL {
            
            if fileURL.pathExtension == "log",
                let content = try? String(contentsOf: fileURL, encoding: .utf8), !content.isEmpty {
                print("\(fileURL.lastPathComponent)\n\(content)")
            } else {
                print("\(fileURL.lastPathComponent)\n")
            }
        }
    }
}
