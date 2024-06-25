//
//  ErrorMessageView.swift
//  PlatziStore
//
//  Created by Andrea Murru on 25/06/2024.
//

import SwiftUI

struct ErrorMessageView: View {
    let errorMessage: String
    
    var body: some View {
        Text("Error: \(errorMessage)")
            .padding()
            .foregroundColor(.red)
    }
}
