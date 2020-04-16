//  
//  CircleButton.swift
//  swiftUIClicker
//
//  (c) Neofonie Mobile GmbH (2020)
//
//  This computer program is the sole property of Neofonie
//  Mobile GmbH (http://mobile.neofonie.de) and is protected
//  under the German Copyright Act (paragraph 69a UrhG).
//
//  All rights are reserved. Making copies, duplicating,
//  modifying, using or distributing this computer program
//  in any form, without prior written consent of Neofonie
//  Mobile GmbH, is prohibited.
//
//  Violation of copyright is punishable under the German
//  Copyright Act (paragraph 106 UrhG).
//
//  Removing this copyright statement is also a violation.

import SwiftUI

struct FallingCoinModel: Identifiable {
    var id = UUID()
}

struct CircleButton: View {
    var action: () -> Void
    
    @State var fallingModels = [FallingCoinModel]()
    
    var body: some View {
        ZStack {
            
            ForEach(fallingModels) { model in
                FallingCoin().onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.fallingModels.removeAll(where: {$0.id == model.id})
                    }
                }
            }
            
            Button(action: {
                self.action()
                self.fallingModels.append(FallingCoinModel())
                
            }, label: {
                ZStack {
                    Image("euro")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }).buttonStyle(CircleButtonStyle())
        }
    }
}


struct FallingCoin: View {
    
    @State var isFalling: Bool = false

    var randomX: CGFloat {
        let strides = stride(from: 10, to: UIScreen.main.bounds.width, by: 100)
        let element = (strides.first(where: {_ in Bool.random()}) ?? 10)  * (Bool.random() ? -1 : 1)
        print(element)
        return element
    }
    
    var body: some View {
        
        Image(uiImage: UIImage(named: "euro")!)
            .resizable()
            .frame(width: 40, height: 40)
            .modifier(FallEffect(x: isFalling ? randomX : 0, y: isFalling ? UIScreen.main.bounds.height : 0))
            .onAppear {
                withAnimation(Animation.easeIn(duration: 1.0).delay(0.0)) {
                    self.isFalling.toggle()
                    print("is falling")
                }
        }
        .onDisappear {
            print("disappeared")
        }
        
    }
    
}

struct FallEffect: GeometryEffect {
    var x, y: CGFloat
    
    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(x, y) }
        set {
            x = newValue.first
            y = newValue.second
        }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX: x, y: y))
    }
    
}

struct CircleButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration
            .label
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
            .shadow(color: Color.black, radius: configuration.isPressed ? 0 : 10, x: 0, y: configuration.isPressed ? 0 : 10)
            .animation(Animation.easeInOut(duration: 0.3))
    }
}


struct CircleButton_Previews: PreviewProvider {
    static var previews: some View {
        CircleButton {
            print("Circle Button tapped")
        }
    }
}
