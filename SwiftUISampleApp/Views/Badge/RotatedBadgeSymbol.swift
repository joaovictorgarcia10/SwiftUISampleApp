//
//  RotatedBadgeSymbol.swift
//  SwiftUISampleApp
//
//  Created by João Victor Garcia Leite Santana on 21/01/25.
//

import SwiftUI

struct RotatedBadgeSymbol: View {
    let angle: Angle
    
    var body: some View {
        BadgeSymbol()
            .padding(-60)
            .rotationEffect(angle, anchor: .bottom)
    }
}


#Preview {
    RotatedBadgeSymbol(angle: Angle(degrees: 5))
}

