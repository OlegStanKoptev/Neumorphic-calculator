//
//  ContentView.swift
//  NeuMorphicCalculator
//
//  Created by Oleg Koptev on 25.05.2020.
//  Copyright © 2020 Oleg Koptev. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let startingOverallString: String = "0"
    @State var overallString: String = "0"
    @State var firstSavedValue: Double = 0
    @State var secondSavedValue: Double?
    @State var eraseAtInput = false
    @State var usingOperator: String?
    @State var op1ButtonPressed = false
    @State var op2ButtonPressed = false
    @State var op3ButtonPressed = false
    @State var op4ButtonPressed = false
    
    let content = [["C", "±", "%", "÷"], ["7", "8", "9", "×"], ["4", "5", "6", "-"], ["1", "2", "3", "+"], ["0", "0", ",", "="]]
    
    func ProcessInput(_ input: String) {
        switch input {
        case "1", "2", "3", "4", "5", "6", "7", "8", "9", "0":
            if !eraseAtInput {
                if overallString.countNumbers() == 9 { return }
                if overallString == startingOverallString {
                    overallString = input
                } else {
                    overallString += input
                }
            } else {
                overallString = input
                eraseAtInput = false
            }
            break
        case ",":
            if !overallString.contains(input) && overallString.countNumbers() != 9 {
                overallString += input
            }
            break
        case "±":
            if overallString != startingOverallString {
                overallString = String((-Double(overallString)!).clean)
            }
            break
        case "+", "-", "×", "÷":
            usingOperator = input
            firstSavedValue = Double(overallString.replacingOccurrences(of: ",", with: "."))!
            switch input {
            case "+":
                op1ButtonPressed = false
                op2ButtonPressed = false
                op3ButtonPressed = false
                break
            case "-":
                op1ButtonPressed = false
                op2ButtonPressed = false
                op4ButtonPressed = false
                break
            case "×":
                op1ButtonPressed = false
                op3ButtonPressed = false
                op4ButtonPressed = false
                break
            case "÷":
                op2ButtonPressed = false
                op3ButtonPressed = false
                op4ButtonPressed = false
                break
            default:
                break
            }
            eraseAtInput = true
            break
        case "=":
            switch usingOperator {
            case "+":
                secondSavedValue = Double(overallString.replacingOccurrences(of: ",", with: "."))
                let result = firstSavedValue + secondSavedValue!
                overallString = result.clean.replacingOccurrences(of: ".", with: ",")
                op1ButtonPressed = false
                op2ButtonPressed = false
                op3ButtonPressed = false
                op4ButtonPressed = false
                eraseAtInput = true
                break
            case "-":
                secondSavedValue = Double(overallString.replacingOccurrences(of: ",", with: "."))
                let result = firstSavedValue - secondSavedValue!
                overallString = result.clean.replacingOccurrences(of: ".", with: ",")
                op1ButtonPressed = false
                op2ButtonPressed = false
                op3ButtonPressed = false
                op4ButtonPressed = false
                eraseAtInput = true
                break
            case "×":
                secondSavedValue = Double(overallString.replacingOccurrences(of: ",", with: "."))
                let result = firstSavedValue * secondSavedValue!
                overallString = result.clean.replacingOccurrences(of: ".", with: ",")
                op1ButtonPressed = false
                op2ButtonPressed = false
                op3ButtonPressed = false
                op4ButtonPressed = false
                eraseAtInput = true
                break
            case "÷":
                secondSavedValue = Double(overallString.replacingOccurrences(of: ",", with: "."))
                let result = firstSavedValue / secondSavedValue!
                overallString = result.clean.replacingOccurrences(of: ".", with: ",")
                op1ButtonPressed = false
                op2ButtonPressed = false
                op3ButtonPressed = false
                op4ButtonPressed = false
                eraseAtInput = true
                break
            default:
                break
            }
            break
        case "%":
            if overallString != startingOverallString {
                overallString = String((Double(overallString)! / 100).clean).replacingOccurrences(of: ".", with: ",")
            }
            break
        case "C":
            overallString = startingOverallString
            firstSavedValue = 0
            secondSavedValue = nil
            usingOperator = nil
            op1ButtonPressed = false
            op2ButtonPressed = false
            op3ButtonPressed = false
            op4ButtonPressed = false
            break
        default:
            break
        }
    }
    
    private func formatString(_ string: String) -> String {
        var correctedInput = string
        var newValue = ""
        if string.first == "-" {
            correctedInput = String(string[string.index(string.startIndex, offsetBy: 1)..<string.endIndex])
            newValue += "-"
        }
        newValue += String(correctedInput[correctedInput.startIndex])
        if correctedInput.contains(",") { return string }
        if correctedInput.count > 3 {
            switch correctedInput.count % 3 {
            case 0:
                for index in 1..<correctedInput.count {
                    if index % 3 == 0 {
                        newValue.append(" ")
                    }
                    let newChar = correctedInput[correctedInput.index(correctedInput.startIndex, offsetBy: index)]
                    newValue.append(newChar)
                }
                break
            case 1:
                for index in 1..<correctedInput.count {
                    if index % 3 == 1 {
                        newValue.append(" ")
                    }
                    let newChar = correctedInput[correctedInput.index(correctedInput.startIndex, offsetBy: index)]
                    newValue.append(newChar)
                }
                break
            case 2:
                for index in 1..<correctedInput.count {
                    if index % 3 == 2 {
                        newValue.append(" ")
                    }
                    let newChar = correctedInput[correctedInput.index(correctedInput.startIndex, offsetBy: index)]
                    newValue.append(newChar)
                }
                break
            default:
                break
            }
        } else {
            newValue = string
        }
        return newValue
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color("bg")
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 0) {
                    Spacer()
                    HStack {
                        Spacer()
                        Text(self.formatString(self.overallString))
                            .font(.system(size: geometry.size.width * 0.15))
                            .fontWeight(.light)
                            .lineLimit(1)
                    }
                        .foregroundColor(Color("text"))
                    .padding(.horizontal, geometry.size.width * 0.05)
                    self.buttons(size: geometry.size)
                }
            }
        }
    }
    
    func buttons(size: CGSize) -> some View {
        VStack {
            HStack {
                NormalButton(content: content[0][0], width: size.width, action: { self.ProcessInput(self.content[0][0]) })
                NormalButton(content: content[0][1], width: size.width, action: { self.ProcessInput(self.content[0][1]) })
                NormalButton(content: content[0][2], width: size.width, action: { self.ProcessInput(self.content[0][2]) })
                OpButton(content: content[0][3], width: size.width, isPressed: $op1ButtonPressed, action: { self.ProcessInput(self.content[0][3]) })
            }
            HStack {
                NormalButton(content: content[1][0], width: size.width, action: { self.ProcessInput(self.content[1][0]) })
                NormalButton(content: content[1][1], width: size.width, action: { self.ProcessInput(self.content[1][1]) })
                NormalButton(content: content[1][2], width: size.width, action: { self.ProcessInput(self.content[1][2]) })
                OpButton(content: content[1][3], width: size.width, isPressed: $op2ButtonPressed, action: { self.ProcessInput(self.content[1][3]) })
            }
            HStack {
                NormalButton(content: content[2][0], width: size.width, action: { self.ProcessInput(self.content[2][0]) })
                NormalButton(content: content[2][1], width: size.width, action: { self.ProcessInput(self.content[2][1]) })
                NormalButton(content: content[2][2], width: size.width, action: { self.ProcessInput(self.content[2][2]) })
                OpButton(content: content[2][3], width: size.width, isPressed: $op3ButtonPressed, action: { self.ProcessInput(self.content[2][3]) })
            }
            HStack {
                NormalButton(content: content[3][0], width: size.width, action: { self.ProcessInput(self.content[3][0]) })
                NormalButton(content: content[3][1], width: size.width, action: { self.ProcessInput(self.content[3][1]) })
                NormalButton(content: content[3][2], width: size.width, action: { self.ProcessInput(self.content[3][2]) })
                OpButton(content: content[3][3], width: size.width, isPressed: $op4ButtonPressed, action: { self.ProcessInput(self.content[3][3]) })
            }
            HStack {
                DoubleButton(content: content[4][0], width: size.width, action: { self.ProcessInput(self.content[4][0]) })
                NormalButton(content: content[4][2], width: size.width, action: { self.ProcessInput(self.content[4][2]) })
                NormalButton(content: content[4][3], width: size.width, action: { self.ProcessInput(self.content[4][3]) })
            }
        }
        .aspectRatio(4/5, contentMode: .fit)
        .frame(minHeight: 0, maxHeight: size.height * 4/7)
        .padding()
    }
}

struct NormalButton: View {
    let content: String
    let width: CGFloat
    var isEnabled = true
    let action: () -> Void
    var body: some View {
        Button(action: { if self.isEnabled { self.action() } }) {
            Capsule()
                .aspectRatio(contentMode: .fit)
                .overlay(Text(self.content)
                    .foregroundColor(isEnabled ? Color("text") : .red)
                    .font(.system(size: width * 0.08))
                    .fontWeight(.light)
                )
        }
        .buttonStyle(NeumorphicButtonStyle(isEnabled: isEnabled))
    }
}

struct DoubleButton: View {
    let content: String
    let width: CGFloat
    var isEnabled = true
    let action: () -> Void
    var body: some View {
        Button(action: { if self.isEnabled { self.action() } }) {
            Capsule()
                .overlay(Text(content)
                    .foregroundColor(isEnabled ? Color("text") : .red)
                    .font(.system(size: width * 0.08))
                    .fontWeight(.light)
                )
            
        }
        .buttonStyle(NeumorphicButtonStyle())
    }
}

struct OpButton: View {
    let content: String
    let width: CGFloat
    @Binding var isPressed: Bool
    var isEnabled = true
    let action: () -> Void
    var body: some View {
        Button(action: {
            if self.isEnabled {
                self.action()
                self.isPressed = true
            }
        }) {
            Capsule()
                .shadow(color: Color("darkShadow"), radius: 8, x: isEnabled ? !isPressed ? 6 : -6 : -6, y: isEnabled ? !isPressed ? 6 : -4 : -4)
                .shadow(color: Color("lightShadow"), radius: 8, x: isEnabled ? !isPressed ? -6 : 6 : 6, y: isEnabled ? !isPressed ? -6 : 4 : 4)
                .scaleEffect(isEnabled ? !isPressed ? 1.0 : 0.975 : 0.975)
                .animation(Animation.easeInOut(duration: 0.1))
                .overlay(Text(content)
                    .foregroundColor(isEnabled ? Color("text") : .red)
                    .font(.system(size: width * 0.08))
                    .fontWeight(.light)
                )
        }
        .buttonStyle(OpButtonStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environment(\.colorScheme, .dark)
            ContentView()
        }
    }
}
