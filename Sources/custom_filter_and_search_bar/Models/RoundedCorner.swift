//
//  RoundedCorner.swift
//  
//
//  Created by Softsuave on 24/06/24.
//

import SwiftUI

@available(iOS 13.0, *)
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
