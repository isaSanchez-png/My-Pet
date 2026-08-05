//
//  EmptyStateView.swift
//  My-Pet
//
//  Created by Isa on 13/05/26.
//

import SwiftUI

struct EmptyStateView: View {
    @Binding var showAddPet: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Create your first pet to get started")
                .font(.title3)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            Button {
                showAddPet = true
            } label: {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Add New Pet")
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(.orange)
            .font(.headline)
        }
        .padding(.horizontal, 32)
    }
}
