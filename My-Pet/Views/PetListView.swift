//
//  PetDetailView.swift
//  My-Pet
//
//  Created by Isa on 17/05/26.
//

import SwiftUI

struct PetListView: View {
    @StateObject private var manager = PetManager()
    @State private var showAddPet: Bool = false


    var body: some View {
        NavigationStack{
            ZStack{
                if manager.pets.isEmpty{
                    EmptyStateView(showAddPet: $showAddPet)
                } else {
                    //mostrar la lista de mascotas
                }
            }
            .navigationTitle("My Pets")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showAddPet){
                AddPetView(manager: manager)
            }
        }
    }
}
#Preview {
    PetListView()
}
