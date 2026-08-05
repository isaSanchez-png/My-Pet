//
//  Pet.swift
//  My-Pet
//
//  Created by Isa on 17/05/26.
//

import Foundation

struct Pet: Identifiable, Codable {
    var id = UUID()
    var name: String
    var type: PetType
    var favoriteFood: String
    var imageData: Data?
    
    var birthDate: Date
    var weightHistory: [WeightRecord]
    var vaccines: [Vaccine]
    var lastDeworming: [Deworming]
    var lastFoodPurchase: Date?
    
    var age: String {
        let calendar = Calendar.current
        let now = Date()
        let ageComponents = calendar.dateComponents([.year, .month], from: birthDate, to: now)
        let years = ageComponents.year ?? 0
        let months = ageComponents.month ?? 0
        
        if years == 0 {
            return "\(months) m"
        } else if months == 0 {
            return "\(years) yrs"
        } else {
            return "\(years) yrs, \(months) m"
        }
    }
    
    enum PetType: String, CaseIterable, Codable {
        case cat = "Cat"
        case dog = "Dog"
        
        var defaultEmoji: String {
            switch self {
            case .cat: return "🐱"
            case .dog: return "🐶"
            }
        }
    }
    
    struct WeightRecord: Codable {
        var dateWeight: Date
        var weight: Double
    }
    
    struct Vaccine: Codable {
        var name: String
        var lastDate: Date
        var nextDate: Date?
    }
    
    struct Deworming: Codable {
        var lastDate: Date
        var nextDate: Date?
    }
}
