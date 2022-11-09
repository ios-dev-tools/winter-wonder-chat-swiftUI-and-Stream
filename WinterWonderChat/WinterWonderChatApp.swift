//
//  WinterWonderChatApp.swift
//  WinterWonderChat
//
//  Created by Nick iOS Dev Tools on 04/11/2022.
//

import SwiftUI
import StreamChat
import StreamChatSwiftUI

@main
struct WinterWonderChatApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ChatChannelListView(viewFactory: CustomUIFactory.shared)
        }
    }
}
