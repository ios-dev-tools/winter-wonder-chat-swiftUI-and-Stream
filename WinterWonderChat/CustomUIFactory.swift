//
//  CustomUIFactory.swift
//  WinterWonderChat
//
//  Created by Nick iOS Dev Tools on 04/11/2022.
//

import SwiftUI
import Foundation
import StreamChat
import StreamChatSwiftUI
import EffectsLibrary

class CustomUIFactory: ViewFactory {
    @Injected(\.chatClient) public var chatClient: ChatClient
    
    private init() {}
        
    public static let shared = CustomUIFactory()
    
    public func makeMessageReadIndicatorView(channel: ChatChannel, message: ChatMessage) -> some View {
        return CustomMessageReadIndicatorView(readUsers: channel.readUsers(currentUserId: chatClient.currentUserId, message: channel.latestMessages.first), showReadCount: false)
    }
    
    var snowConfig = SnowConfig(
        intensity: .low,
        lifetime: .long,
        initialVelocity: .slow,
        fadeOut: .slow
    )

    func makeMessageListBackground(colors: ColorPalette, isInThread: Bool) -> some View {
        ZStack {
            GeometryReader{ geo in
                ZStack {
                    PlayerView()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geo.size.width, height: geo.size.height)
                        .overlay(Color.black.opacity(0.25))
                        .blur(radius: 3)
                        .edgesIgnoringSafeArea(.all)

                    VStack (alignment: .trailing) {
                        Spacer()
                        Image("snow_bank")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geo.size.width, height: 30)
                    }
                }.rotationEffect(.degrees(180))

            }

            HStack {
                SnowView(config: snowConfig)
                SnowView(config: snowConfig)
                SnowView(config: snowConfig)
            }.rotationEffect(.degrees(180))
        }
    }

    public func makeTrailingComposerView(enabled: Bool, cooldownDuration: Int, onTap: @escaping () -> Void) -> some View {
        return CustomSendMessageButton(enabled: enabled, onTap: onTap)
    }
}

struct CustomMessageReadIndicatorView: View {
    @Injected(\.images) private var images
    @Injected(\.fonts) private var fonts
    @Injected(\.colors) private var colors
    
    var readUsers: [ChatUser]
    var showReadCount: Bool
    
    public init(readUsers: [ChatUser], showReadCount: Bool) {
        self.readUsers = readUsers
        self.showReadCount = showReadCount
    }
    
    public var body: some View {
        HStack(spacing: 2) {
            if showReadCount && !readUsers.isEmpty {
                Text("\(readUsers.count)")
                    .font(fonts.footnoteBold)
                    .foregroundColor(colors.tintColor)
                    .accessibilityIdentifier("readIndicatorCount")
            }
            Image(
                !readUsers.isEmpty ? "read_by_all" : "not_read_by_all"
            )
            .resizable()
            .scaledToFit()
            .frame(height: 16)
            .accessibilityIdentifier("readIndicatorCheckmark")
        }
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("MessageReadIndicatorView")
    }
}

struct CustomSendMessageButton: View {
    @Injected(\.images) private var images
    @Injected(\.colors) private var colors
    
    var enabled: Bool
    var onTap: () -> Void
    
    public init(enabled: Bool, onTap: @escaping () -> Void) {
        self.enabled = enabled
        self.onTap = onTap
    }
    
    public var body: some View {
        Button {
            onTap()
        } label: {
            Image(enabled ? "send" : "do_not_send")
                .resizable()
                .scaledToFit()
                .frame(width: 50)
        }
        .disabled(!enabled)
        .accessibilityAddTraits(.isButton)
        .accessibilityIdentifier("SendMessageButton")
    }
    
    private var enabledBackground: UIColor {
        colors.highlightedAccentBackground
    }
}
