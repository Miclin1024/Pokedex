//
//  SearchParser.swift
//  Pokedex
//
//  Created by Michael Lin on 2020/2/15.
//  Copyright © 2020 Michael Lin. All rights reserved.
//

import Foundation

class SearchParser {
    
    enum searchKey{
        case type
        case atk
        case def
        
    }
    
    static func search(_ searchString: String) {
        searchEval(with: searchString.components(separatedBy: " "))
    }
    
    static func searchEval(with searchArr: [String]) {
        if let first = searchArr.first {
            let pokemonOrigin = PokemonManager.shared.pokedexOrigin
            
        } else {
            
        }
        
    }
    
    func searchApply(forFunction f: () -> Void) {
        
    }
    
    func doTypeFilter(for types: [String]) {
        
    }
}
