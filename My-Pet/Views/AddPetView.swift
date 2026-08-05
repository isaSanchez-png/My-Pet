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
    @State private var kind: Pet.PetType = .cat
    @State private var favoriteFood = ""
    
    @State private var imageData: Data?
    @State private var processedImage: Image?
    @State private var selectedItem: PhotosPickerItem?
    
    @State private var birthDate = Date()
    
    // Weight
    @State private var weightValue: Double = 0.0
    @State private var weightDate: Date = Date()
    @State private var weightHistory: [Pet.WeightRecord] = []
    
    // Vaccines
    @State private var vaccineName: String = ""
    @State private var lastVaccineDate: Date = Date()
    @State private var vaccinesList: [Pet.Vaccine] = []
    
    // Deworming & Food
    @State private var lastDewormingDate: Date = Date()
    @State private var dewormingList: [Pet.Deworming] = []
    @State private var lastFoodPurchase: Date = Date()
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("General Info")) {
                    HStack {
                        Text("Name:")
                        TextField("Mandarina", text: $name)
                    }
                    
                    Picker("Kind", selection: $kind) {
                        Text("Cat 🐱").tag(Pet.PetType.cat)
                        Text("Dog 🐶").tag(Pet.PetType.dog)
                    }
                    .pickerStyle(.segmented)
                    
                    HStack {
                        Text("Favorite food:")
                        TextField("Tuna churu", text: $favoriteFood)
                    }
                    
                    DatePicker("Birth Date", selection: $birthDate, displayedComponents: [.date])
                    
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        HStack {
                            Text("Photo")
                            Spacer()
                            if let processedImage {
                                processedImage
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                            } else {
                                Image(systemName: "photo.badge.plus")
                                    .font(.title2)
                            }
                        }
                    }
                    .onChange(of: selectedItem) { newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                self.imageData = data
                                if let uiImage = UIImage(data: data) {
                                    self.processedImage = Image(uiImage: uiImage)
                                }
                            }
                        }
                    }
                }
                
                Section(header: Text("Weight Tracking")) {
                    HStack {
                        TextField("Weight (Kg)", value: $weightValue, format: .number)
                            .keyboardType(.decimalPad)
                        Text("Kg")
                    }
                    DatePicker("Checkup Date", selection: $weightDate, displayedComponents: [.date])
                    
                    Button("Add Weight Record") {
                        if weightValue > 0 {
                            let newRecord = Pet.WeightRecord(dateWeight: weightDate, weight: weightValue)
                            weightHistory.append(newRecord)
                            weightValue = 0.0
                        }
                    }
                }
                
                Section(header: Text("Vaccines")) {
                    TextField("Vaccine Name", text: $vaccineName)
                    DatePicker("Vaccine Date", selection: $lastVaccineDate, displayedComponents: [.date])
                    
                    Button("Add Vaccine") {
                        if !vaccineName.isEmpty {
                            let nextDate = calculateNextVaccine(from: lastVaccineDate)
                            let newVaccine = Pet.Vaccine(name: vaccineName, lastDate: lastVaccineDate, nextDate: nextDate)
                            vaccinesList.append(newVaccine)
                            vaccineName = ""
                        }
                    }
                }
                
                Section(header: Text("Deworming & Care")) {
                    DatePicker("Last Deworming", selection: $lastDewormingDate, displayedComponents: [.date])
                    DatePicker("Last Food Purchase", selection: $lastFoodPurchase, displayedComponents: [.date])
                }
            }
            .navigationTitle("Add a New Pet")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let dewormingRecord = Pet.Deworming(lastDate: lastDewormingDate, nextDate: nil)
                        
                        let newPet = Pet(
                            name: name,
                            type: kind,
                            favoriteFood: favoriteFood,
                            imageData: imageData,
                            birthDate: birthDate,
                            weightHistory: weightHistory,
                            vaccines: vaccinesList,
                            lastDeworming: [dewormingRecord],
                            lastFoodPurchase: lastFoodPurchase
                        )
                        manager.addPets(newPet)
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
    
    private func calculateNextVaccine(from date: Date) -> Date {
        return Calendar.current.date(byAdding: .day, value: 365, to: date) ?? date
    }
}
