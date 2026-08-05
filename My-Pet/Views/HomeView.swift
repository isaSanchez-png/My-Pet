//
//  HomeView.swift
//  My-Pet
//
//  Created by Isa on 17/05/26.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var manager = PetManager()
    @State private var showAddPet = false
    @State private var showDetailPet = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.brown.opacity(0.2)
                    .ignoresSafeArea()
                
                VStack {
                    Text("My Pet")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 40)
                    
                    Spacer()
                    
                    Image(systemName: "pawprint.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 160)
                        .foregroundColor(.orange)
                    
                    Spacer()
                    
                    if manager.pets.isEmpty {
                        EmptyStateView(showAddPet: $showAddPet)
                    } else {
                        let pet = manager.pets.first!
                        Text("Welcome back, \(pet.name)!")
                            .font(.title2)
                            .foregroundColor(.secondary)
                            .padding(.bottom, 10)
                        
                        Button("Show my pet \(pet.type.defaultEmoji)") {
                            showDetailPet = true
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.brown)
                        .font(.title2)
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationDestination(isPresented: $showDetailPet) {
                if let pet = manager.pets.first {
                    PetDetailView(pet: pet)
                }
            }
            .sheet(isPresented: $showAddPet) {
                AddPetView(manager: manager)
            }
        }
    }
}
