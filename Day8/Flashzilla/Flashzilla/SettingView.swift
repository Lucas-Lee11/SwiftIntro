//
//  SettingView.swift
//  Flashzilla
//
//  Created by Lucas Lee on 10/4/20.
//

import SwiftUI

struct SettingView: View {
    @Binding var putBackCard:Bool
    
    var body: some View {
        Form{
            Toggle(isOn: $putBackCard) {
                Text("Put back card on fail")
            }
        }
    }
}
