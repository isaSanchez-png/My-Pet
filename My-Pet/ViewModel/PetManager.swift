//
//  PetManager.swift
//  My-Pet
//
//  Created by Isa on 17/05/26.
//

import Foundation
import Combine
import SwiftUI

class PetManager: ObservableObject {
    @Published var pets: [Pet] = []
    private let saveKey = "savedPets"
    
    init() {
        loadPets()
        if pets.isEmpty {
            addExample()
        }
    }
    
    func addPets(_ pet: Pet) {
        pets.append(pet)
        savePets()
    }
    
    func deletePets(offsets: IndexSet) {
        pets.remove(atOffsets: offsets)
        savePets()
    }
    
    func updatePets(_ pet: Pet) {
        if let index = pets.firstIndex(where: { $0.id == pet.id }) {
            pets[index] = pet
            savePets()
        }
    }
    
    private func savePets() {
        if let encoded = try? JSONEncoder().encode(pets) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    func loadPets() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let savedPets = try? JSONDecoder().decode([Pet].self, from: data) {
            pets = savedPets
        }
    }
    
    private func addExample() {
        let examplePet = Pet(
            name: "Mandarina",
            type: .cat,
            favoriteFood: "Churu de atun",
            imageData: nil,
            birthDate: Date(),
            weightHistory: [Pet.WeightRecord(dateWeight: Date(), weight: 4.2)],
            vaccines: [Pet.Vaccine(name: "Triple Felina", lastDate: Date(), nextDate: nil)],
            lastDeworming: [Pet.Deworming(lastDate: Date(), nextDate: nil)],
            lastFoodPurchase: Date()
        )
        pets.append(examplePet)
        savePets()
    }
}
