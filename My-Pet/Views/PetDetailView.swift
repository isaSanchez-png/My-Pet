//
//  PetDetailView.swift
//  My-Pet
//
//  Created by Isa on 17/05/26.
//

import SwiftUI
import PhotosUI

struct PetDetailView: View {
    let pet: Pet

    var body: some View {
        ScrollView{
            VStack (spacing: 20){
                if let imageData = pet.imageData,
                   let uiImage = UIImage(data: imageData){
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                } else {
                    Text(pet.type.defaultEmoji)
                        .font(.system(size: 100))
                        .padding()
                        .background(Circle().fill(Color.gray.opacity(0.2)))
                }
                
                Text(pet.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                VStack(spacing: 12) {
                    InfoRow(icon: "pawprint", title: "Tipo", value: pet.type.rawValue)
                    InfoRow(icon: "calendar", title: "Edad", value: String(pet.age))
                    InfoRow(icon: "fork.knife", title: "Comida favorita", value: pet.favoriteFood)
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct InfoRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View{
        HStack{
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.brown)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 4){
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.body)
            }
            Spacer()
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(12)
    }
}
