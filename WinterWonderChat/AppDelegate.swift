import StreamChat
import StreamChatSwiftUI
import UIKit
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    var streamChat: StreamChat?
    
    var chatClient: ChatClient = {
        var config = ChatClientConfig(apiKey: .init("YOUR_APP_KEY"))
        let client = ChatClient(config: config)
        return client
    }()
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        
        // The `StreamChat` instance we need to assign
        streamChat = StreamChat(chatClient: chatClient)
        
        // Calling the `connectUser` functions
        connectUser()
        
        return true
    }
    
    // The `connectUser` function we need to add.
    private func connectUser() {
        // This is a hardcoded token valid on Stream's tutorial environment.
        let token = try! Token(rawValue: "AUTH_TOKEN_FOR_TESTING")
        
        
        // Call `connectUser` on our SDK to get started.
        chatClient.connectUser(
            userInfo: .init(id: "YOUR_USER_ID",
                            name: "YOUR_USERNAME",
                            imageURL: URL(string: "https://iosdev.tools/assets/favicon-32x32-bd19455fb691b9d3f602b503b00bb4d691664b81f087ea2922ba16a95ae02dc1.png")!),
            token: token
        ) { error in
            if let error = error {
                // Some very basic error handling only logging the error.
                log.error("connecting the user failed \(error)")
                return
            }
        }
    }
}
