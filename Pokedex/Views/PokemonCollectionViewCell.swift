//
//  PokemonCollectionViewCell.swift
//  Pokedex
//
//  Created by Michael Lin on 2020/2/12.
//  Copyright © 2020 Michael Lin. All rights reserved.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonID: UILabel!
    
    var pokemon: Pokemon? = nil
}
