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
            
            Text("My Pets")
                .font(.largeTitle)
                .bold()
                .padding(.bottom)
                
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing){
                        Button { showAddPet = true} label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            ZStack{
                if manager.pets.isEmpty{
                    EmptyStateView(showAddPet: $showAddPet)
                } else {
                    List{
                        ForEach(manager.pets){ pet in
                            NavigationLink(destination: PetDetailView(pet: pet)){
                                HStack{
                                    Text(pet.type.defaultEmoji)
                                    VStack(alignment: .leading){
                                        Text(pet.name)
                                        Text("Age: \(pet.age) years")
                                            .font(.caption)
                                    }
                                }
                            }
                        }
                        .onDelete(perform: manager.deletePets)
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .sheet(isPresented: $showAddPet){
                AddPetView(manager: manager)
            }
        }
    }
}
#Preview {
    PetListView()
}
