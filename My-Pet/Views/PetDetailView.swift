//
//  PetDetailView.swift
//  My-Pet
//
//  Created by Isa on 17/05/26.
//

import SwiftUI

struct PetDetailView: View {
    let pet: Pet
    
    private var formattedDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if let imageData = pet.imageData,
                   let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 160, height: 160)
                        .clipShape(Circle())
                        .shadow(radius: 8)
                } else {
                    Text(pet.type.defaultEmoji)
                        .font(.system(size: 80))
                        .padding()
                        .background(Circle().fill(Color.gray.opacity(0.2)))
                }
                
                Text(pet.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                VStack(spacing: 12) {
                    InfoRow(icon: "pawprint", title: "Type", value: pet.type.rawValue)
                    InfoRow(icon: "calendar", title: "Age", value: pet.age)
                    InfoRow(icon: "fork.knife", title: "Favorite Food", value: pet.favoriteFood)
                }
                .padding(.horizontal)
                
                VStack(spacing: 12) {
                    InfoRow(
                        icon: "syringes.fill",
                        title: "Last Vaccine",
                        value: pet.vaccines.last.map { "\($0.name) (\(formattedDate.string(from: $0.lastDate)))" } ?? "None"
                    )
                    InfoRow(
                        icon: "chart.bar.xaxis",
                        title: "Last Weight",
                        value: pet.weightHistory.last.map { "\($0.weight) Kg" } ?? "No record"
                    )
                    InfoRow(
                        icon: "cross.vial.fill",
                        title: "Last Deworming",
                        value: pet.lastDeworming.last.map { formattedDate.string(from: $0.lastDate) } ?? "None"
                    )
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarTitleDisplayMode(.inline)
    }
    
    struct InfoRow: View {
        let icon: String
        let title: String
        let value: String
        
        var body: some View {
            HStack {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(.brown)
                    .frame(width: 30)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(value)
                        .font(.body)
                        .bold()
                }
                Spacer()
            }
            .padding()
            .background(Color(.secondarySystemGroupedBackground))
            .cornerRadius(12)
        }
    }
}
