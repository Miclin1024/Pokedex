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
    
    var currLayout: layoutStates
    enum layoutStates {
        case COLLECTION
        case TABLE
    }
    
    static var shared = PokemonManager()
    fileprivate var pokedex: [Pokemon] = []
    var pokedexOrigin: [Pokemon] = []
    
    private init() {
        pokedexOrigin = PokemonGenerator.getPokemonArray()
        pokedex = pokedexOrigin
        currLayout = layoutStates.COLLECTION
    }
    
    func getPokemon(at index: Int) -> Pokemon {
        return pokedex[index]
    }
    
    func setPokedex(arr: [Pokemon]) {
        pokedex = arr
        
    }
    
    func getPokedexCount() -> Int {
        return pokedex.count
    }
    
    func searchNames(from searchDex: [Pokemon], for searchString: String) -> [Pokemon] {
        return searchDex.filter({ pokemon in
            return pokemon.name.contains(searchString)
        })
    }
    
    func searchTypes(from searchDex: [Pokemon], for type: PokeType) -> [Pokemon] {
        return searchDex.filter({ pokemon in
            return pokemon.types.contains(type)
        })
    }
    
    func searchStats(from searchDex: [Pokemon], for stat: PokeStat, largerThan num: Int) -> [Pokemon]{
        searchDex.filter({ pokemon in
            print(pokemon.getStat(stat: stat))
            return pokemon.getStat(stat: stat) > num
        })
    }
    
    func searchStats(from searchDex: [Pokemon], for stat: PokeStat, smallerThan num: Int) -> [Pokemon]{
        searchDex.filter({ pokemon in
            return pokemon.getStat(stat: stat) < num
        })
    }
    
    func unionSearch(first arr1: [Pokemon], second arr2: [Pokemon]) -> [Pokemon] {
        var buffer = arr2
        for pokemon in arr1 {
            if !buffer.contains(pokemon) {
                buffer.append(pokemon)
            }
        }
        
        return buffer
    }
    
    func intersecSearch(first arr1: [Pokemon], second arr2: [Pokemon]) -> [Pokemon] {
        var buffer: [Pokemon] = []
        for pokemon in arr1 {
            if arr2.contains(pokemon) {
                buffer.append(pokemon)
            }
        }
        
        return buffer
    }
}
