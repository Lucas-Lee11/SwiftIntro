//
//  ContentView.swift
//  Animations
//
//  Created by Lucas Lee on 9/28/20.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
    }
}

struct ContentView: View {
    
    @State var enabled:Bool = false
    @State var dragAmount:CGSize = CGSize.zero
    @State var isShowingRed:Bool = false
    let letters = Array("Hello SwiftUI")

    var body: some View {
        VStack{
            Button("Tap Me") {
                withAnimation {
                    self.isShowingRed.toggle()
                }
                self.enabled.toggle()
            }
            .frame(width: 200, height: 200)
            .background(enabled ? Color.blue : Color.red)
            .animation(.default)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
            .animation(.interpolatingSpring(stiffness: 10, damping: 1))
            
            LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 300, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged { self.dragAmount = $0.translation }
                    .onEnded { what in
                        withAnimation(.spring()) {
                            self.dragAmount = .zero
                        }
                    }
            )
            HStack(spacing: 0) {
                       ForEach(0..<letters.count) { num in
                           Text(String(self.letters[num]))
                               .padding(5)
                               .font(.title)
                               .background(self.enabled ? Color.blue : Color.red)
                               .offset(self.dragAmount)
                               .animation(Animation.default.delay(Double(num) / 20))
                       }
                   }
                   .gesture(
                       DragGesture()
                           .onChanged { self.dragAmount = $0.translation }
                           .onEnded { _ in
                               self.dragAmount = .zero
                               self.enabled.toggle()
                           }
                   )
        }
        if isShowingRed {
            Rectangle()
                .fill(Color.red)
                .frame(width: 200, height: 200)
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
