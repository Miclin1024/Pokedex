//
//  PokemonManager.swift
//  Pokedex
//
//  Created by Michael Lin on 2020/2/13.
//  Copyright © 2020 Michael Lin. All rights reserved.
//

import Foundation
import UIKit

class PokemonManager {
    
    static var shared = PokemonManager()
    fileprivate var pokedex: [Pokemon] = []
    
    private init() {
        pokedex = PokemonGenerator.getPokemonArray()
        // Load all pokemon
    }
    
    func getPokemon(at index: Int) -> Pokemon {
        return pokedex[index]
    }
    
    func getPokedexCount() -> Int {
        return pokedex.count
    }
}
