//
//  AddPetView.swift
//  My-Pet
//
//  Created by Isa on 21/05/26.
//

import SwiftUI
import PhotosUI

struct AddPetView: View {
    @ObservedObject var manager: PetManager
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var kind: Pet.type = .cat
    @State private var age = 0
    let step = 1
    let range = 0...15
    @State private var favoriteFood = ""
    @State private var imageData: Data?
    @State private var processedImage: Image?
    @State private var selectedItem: PhotosPickerItem?
    

    var body: some View {
        NavigationStack{
            Form{
                HStack{
                    Text("Name: ")
                    TextField("Mandarina", text: $name)
                }
                .padding(5)
                VStack{
                        Text("Select the kind of your pet")
                            .padding([.bottom], 10)
                        Picker(selection: $kind){
                            Text("Fish").tag(Pet.type.fish)
                            Text("Bird").tag(Pet.type.bird)
                            Text("Cat").tag(Pet.type.cat)
                            Text("Dog").tag(Pet.type.dog)
                        } label: {
                            Text("Kind")
                        }
                        .pickerStyle(.segmented)
                    }
                
                Stepper(
                    value: $age,
                    in: range,
                    step: step
                ) {
                    Text("Age:  \(age)")
                        .padding(5)
                }
                
                HStack{
                    Text("Favorite food: ")
                    TextField("Tuna churu", text: $favoriteFood)
                }
                .padding(5)
                
                HStack{
                    Text("Photo")
                    PhotosPicker(selection: $selectedItem){
                        if let processedImage {
                            processedImage
                                .resizable()
                                .scaledToFit()
                        } else {
                            ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            .navigationTitle("Add a New Pet")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .cancellationAction){
                    Button("Cancel"){dismiss() }
                }
                ToolbarItem(placement: .confirmationAction){Button("Save"){
                    let newPet = Pet(
                        name: name,
                        type: kind,
                        age: age,
                        imageData: imageData,
                        favoriteFood: favoriteFood
                    )
                    manager.addPets(newPet)
                    dismiss()
                }
                .disabled(name.isEmpty)
                }
            }
        }
    }
}
