//
//  ScreenShape.swift
//  TMDB
//
//  Created by Developer on 12/23/20.
//

import Foundation
import SwiftUI

struct ScreenShape: Shape {
    var screenCurveture: CGFloat = 30
    var isClip = false
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: rect.origin.x + screenCurveture, y: rect.origin.y + screenCurveture))
            path.addQuadCurve(to: CGPoint(x: rect.width - screenCurveture, y: rect.origin.y + screenCurveture), control: CGPoint(x: rect.midX, y: rect.origin.y))
            if isClip {
                path.addLine(to: CGPoint(x: rect.width, y: rect.height))
                path.addLine(to: CGPoint(x: rect.origin.x, y: rect.height))
                path.closeSubpath()
            }
        }
    }
}


struct DateShape: Shape {
    var cutRadius: CGFloat = 5    
    func path(in rect: CGRect) -> Path {
        
        return Path{ path in
            path.move(to: CGPoint(x: rect.origin.x, y: rect.origin.y ))
            path.addLine(to: CGPoint(x: rect.width, y: rect.origin.y))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height - rect.height / 4))
            path.addArc(center: CGPoint(x: rect.width, y: rect.height - rect.height / 4 + cutRadius), radius: cutRadius, startAngle: Angle(degrees: -90) , endAngle: Angle(degrees: 90) , clockwise: true)
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.origin.x, y: rect.height))
            path.addLine(to: CGPoint(x: rect.origin.x, y: rect.height - rect.height / 4 + cutRadius * 2))
            path.addArc(center: CGPoint(x: rect.origin.x, y: rect.height - rect.height / 4 + cutRadius), radius: cutRadius, startAngle: Angle(degrees: 90) , endAngle: Angle(degrees: -90) , clockwise: true)
            path.closeSubpath()
            
        }
    }
}
