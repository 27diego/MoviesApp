//
//  VisualEffectView.swift
//  TMDB
//
//  Created by Developer on 1/2/21.
//

import SwiftUI

struct VisualEffectView: UIViewRepresentable {
    var uiVisualEffect: UIVisualEffect?
    
    func makeUIView(context: Context) -> some UIVisualEffectView {
        UIVisualEffectView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.effect = uiVisualEffect
    }
}
