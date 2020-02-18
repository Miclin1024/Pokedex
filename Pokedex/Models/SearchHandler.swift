//
//  SearchHandler.swift
//  Pokedex
//
//  Created by Michael Lin on 2020/2/15.
//  Copyright © 2020 Michael Lin. All rights reserved.
//

import Foundation

class SearchHandler {
    
    static let searchKey = [
        0: ["type", "type:"],
        1: ["hp", "health"],
        2: ["atk", "attack"],
        3: ["def", "defence"],
        4: ["sp_atk", "special_atk", "sp_attack", "special_attack"],
        5: ["sp_def", "special_def", "sp_defence", "special_defence"],
        6: ["speed", "spd"],
        7: ["total"],
        8: ["name", "name:"]
    ]
    static var searchResult: [Pokemon] = PokemonManager.shared.pokedexOrigin
    static var filterTypes: [PokeType] = []
    static var filterResult: [Pokemon] = []

    static func search(_ searchString: String) {
        if searchString == "" {
            searchResult = PokemonManager.shared.pokedexOrigin
        } else {
            searchResult = PokemonManager.shared.searchNames(from: PokemonManager.shared.pokedexOrigin, for: searchString)
        }
        applyTypeFilter()
        applySearch()
    }
    
    static func applyTypeFilter(type: PokeType) {
        filterTypes.append(type)
        applyTypeFilter()
    }
    
    static func applyTypeFilter() {
        if filterTypes.count == 0 {
            filterResult = searchResult
            applySearch(checkForFilter: false)
        } else {
            filterResult = []
            for type in filterTypes {
                let typeResult = PokemonManager.shared.searchTypes(from: searchResult, for: type)
                filterResult = PokemonManager.shared.unionSearch(first: typeResult, second: filterResult)
            }
            applySearch()
        }
    }
    
    static func removeTypeFilter(for type: PokeType) {
        filterTypes.remove(at: filterTypes.firstIndex(of: type)!)
        applyTypeFilter()
    }
    
    static func removeTypeFilter(for type: String) {
        for i in PokeType.allCases {
            if i == type {
                removeTypeFilter(for: i)
            }
        }
    }
    
    static func applySearch(checkForFilter: Bool = true) {
        if checkForFilter {
            let finalRes = PokemonManager.shared.intersecSearch(first: searchResult, second: filterResult)
            PokemonManager.shared.setPokedex(arr: finalRes)
        } else {
            PokemonManager.shared.setPokedex(arr: searchResult)
        }
    }
}
