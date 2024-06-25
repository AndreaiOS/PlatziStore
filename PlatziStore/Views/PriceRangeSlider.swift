//
//  PriceRangeSlider.swift
//  PlatziStore
//
//  Created by Andrea Murru on 25/06/2024.
//

import SwiftUI

struct PriceRangeSlider: View {
    let label: String
    @Binding var value: Double
    
    var body: some View {
        VStack {
            Text(label)
                .foregroundColor(Color.primary)
            
            Slider(value: $value, in: 0...1000)
            Text(value < 1000 ? "\(Int(value))" : "Max")
                .foregroundColor(Color.primary)
        }
    }
}
