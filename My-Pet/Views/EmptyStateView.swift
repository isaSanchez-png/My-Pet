//
//  EmptyStateView.swift
//  ToDoList
//
//  Created by Isa on 13/05/26.
//
import SwiftUI

struct EmptyStateView: View {
    @Binding var showAddPet: Bool

    
    var body: some View {
        ZStack{
            Color.brown.opacity(0.2)
            .ignoresSafeArea()
            
            VStack {
                Text("No Pets Yet")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 60)
                
                Spacer()
                
                Image(systemName: "pawprint.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 180)
                    .foregroundColor(.brown.opacity(0.7))
                    .padding()
                
                Spacer()
                
                VStack(spacing: 20) {
                    Text("Create your first pet to get started")
                        .font(.title2)
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
                    .font(.title3)
                    
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 50)
            }
        }
    }
}
