//
//  Pokemon.swift
//  Pokedex
//
//  Created by SAMEER SURESH on 9/25/16.
//  Copyright © 2020 MDB. All rights reserved.
//  Updated by ANMOL PARANDE on 01/25/20

import Foundation

/* Note 1:
   There are 18 different types of Pokemon, and a single Pokemon can inherit multiple types:
        Bug, Grass, Dark, Ground, Dragon, Ice, Electric, Normal, Fairy,
        Poison, Fighting, Psychic, Fire, Rock, Flying, Steel, Ghost, Water
*/

enum PokeType:String {
    case Bug
    case Grass
    case Dark
    case Ground
    case Dragon
    case Ice
    case Electric
    case Normal
    case Fairy
    case Poison
    case Fighting
    case Psychic
    case Fire
    case Rock
    case Flying
    case Steel
    case Ghost
    case Water
    case Unknown
}

enum PokeStat:String {
    case attack
    case defense
    case health
    case specialAttack
    case specialDefense
    case speed
    case total
}

class Pokemon: Decodable {
    
    /* Note 2:
       The image for each Pokemon is not provided, but a URL is. You should look up how to get an image from it's URL.
    */
     
    let name: String
    let id: Int
    let attack: Int
    let defense: Int
    let health: Int
    let specialAttack: Int
    let specialDefense: Int
    let speed: Int
    let total: Int
    let types: [PokeType]
    let imageUrl: String
    let imageUrlLarge: String
    let evolutionName: String
    
    enum CodingKeys: String, CodingKey {
        case id = "national_number"
        case health = "hp"
        case images = "sprites"
        case spAtk = "sp_atk"
        case spDef = "sp_def"
        
        case name, total, speed, attack, defense, type, evolution
    }
    
    enum ImageKeys: String, CodingKey {
        case normal
        case large
    }
    
    enum EvolutionKeys: String, CodingKey {
        case name
    }
    
    func getStat(stat: PokeStat) -> Int {
        switch stat {
            case .attack:
                return self.attack
            case .defense:
                return self.defense
            case .health:
                return self.health
            case .specialAttack:
                return self.specialAttack
            case .specialDefense:
                return self.specialDefense
            case .speed:
                return self.speed
            case .total:
                return self.total
        }
    }
    
    required init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        let name = try valueContainer.decode(String.self, forKey: .name)
        
        
        if let evolutionContainer = try? valueContainer.nestedContainer(keyedBy: EvolutionKeys.self, forKey: .evolution), let evolutionName = try? evolutionContainer.decode(String.self, forKey: .name), evolutionName != "" {
            self.name = evolutionName
        } else {
            self.name = name
        }
        
        self.evolutionName = "None"
        
        self.id = Int(try valueContainer.decode(String.self, forKey: .id)) ?? 0
        self.attack = try valueContainer.decode(Int.self, forKey: .attack)
        self.defense = try valueContainer.decode(Int.self, forKey: .defense)
        self.health = try valueContainer.decode(Int.self, forKey: .health)
        self.specialAttack = try valueContainer.decode(Int.self, forKey: .spAtk)
        self.specialDefense = try valueContainer.decode(Int.self, forKey: .spDef)
        self.speed = try valueContainer.decode(Int.self, forKey: .speed)
        self.total = try valueContainer.decode(Int.self, forKey: .total)
        
        let stringTypes = try valueContainer.decode([String].self, forKey: .type)
        
        self.types = stringTypes.map({ (type) -> PokeType in
            guard let type = PokeType(rawValue: type) else { return .Unknown}
            return type
        })
        
        let imageContainer = try valueContainer.nestedContainer(keyedBy: ImageKeys.self, forKey: .images)
        
        self.imageUrl = try imageContainer.decode(String.self, forKey: .normal)
        self.imageUrlLarge = try imageContainer.decode(String.self, forKey: .large)
    }
}

extension Pokemon: Equatable {
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.name == rhs.name && lhs.evolutionName == rhs.evolutionName
    }
}
