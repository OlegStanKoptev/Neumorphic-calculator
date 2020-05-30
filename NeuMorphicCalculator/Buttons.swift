//
//  Buttons.swift
//  NeuMorphicCalculator
//
//  Created by Oleg Koptev on 25.05.2020.
//  Copyright © 2020 Oleg Koptev. All rights reserved.
//

import SwiftUI


struct NeumorphicButtonStyle: ButtonStyle {
    var color = Color("buttonLight")
    var isEnabled = true
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(color)
            .shadow(color: Color("darkShadow"), radius: 8, x: isEnabled ? !configuration.isPressed ? 6 : -6 : -6, y: isEnabled ? !configuration.isPressed ? 6 : -6 : -6)
            .shadow(color: Color("lightShadow"), radius: 8, x: isEnabled ? !configuration.isPressed ? -6 : 6 : 6 , y: isEnabled ? !configuration.isPressed ? -6 : 6 : 6)
            .scaleEffect(isEnabled ? !configuration.isPressed ? 1.0 : 0.975 : 0.975)
    }
}

struct OpButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        .foregroundColor(Color("bgOrange"))
    }
}
