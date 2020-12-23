//
//  Styeles.swift
//  TMDB
//
//  Created by Developer on 12/22/20.
//

import Foundation
import SwiftUI

public struct CustomButtonStyle: ButtonStyle {
    var color: Color
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(Font.body.weight(.medium))
            .padding(.vertical, 12)
            .foregroundColor(Color.white)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(color)
            )
            .opacity(configuration.isPressed ? 0.6 : 1.0)
    }
}
