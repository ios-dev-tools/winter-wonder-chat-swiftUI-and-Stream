//
//  PlayerView.swift
//  EffectsLibraryStreamChatSwiftUI
//
//  Created by Nick iOS Dev Tools on 04/11/2022.
//

import SwiftUI

struct PlayerView: UIViewRepresentable {
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) {
    }

    func makeUIView(context: Context) -> UIView {
        return LoopingPlayerUIView(frame: .zero)
    }
}
