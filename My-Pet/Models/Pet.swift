//
//  Pet.swift
//  My-Pet
//
//  Created by Isa on 17/05/26.
//
import SwiftUI

struct Pet: Identifiable, Codable {
    let id = UUID()
    var name: String
    var type : Pet.type
    var age: Int
    var imageData: Data?
    var favoriteFood: String
    
    enum type: String, CaseIterable, Codable {
        case fish = "Fish"
        case bird = "Bird"
        case cat = "Cat"
        case dog = "Dog"
        
        var defaulEmoji: String {
            switch self {
            case .fish: return "🐠"
            case .bird: return "🦜"
            case .cat: return "🐱"
            case .dog: return "🐶"
            }
        }
    }
    
}
