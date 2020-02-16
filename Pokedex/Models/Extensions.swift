//
//  Extensions.swift
//  Pokedex
//
//  Created by Michael Lin on 2020/2/15.
//  Copyright © 2020 Michael Lin. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

extension PokedexViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        PokemonManager.shared.searchNames(for: searchText)
        self.pokemonCollectionView.reloadData()
    }
}

extension PokedexViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if PokemonManager.shared.currLayout == PokemonManager.layoutStates.COLLECTION {
            return CGSize(width: collectionView.frame.width / 2.6, height: collectionView.frame.height / 4)
        } else {
            return CGSize(width: collectionView.frame.width / 1.1, height: collectionView.frame.height / 4)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        let cellWidth = Double(collectionView.frame.width / 2.6)
        let totalCellWidth = cellWidth * 2.0
        let totalSpacingWidth = 30.0

        let leftInset = (collectionView.frame.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset

        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PokemonManager.shared.getPokedexCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let entry = collectionView.dequeueReusableCell(withReuseIdentifier: "entry", for: indexPath) as! PokemonCollectionViewCell
        
        entry.layer.cornerRadius = 15
        entry.layer.shadowColor = UIColor.black.cgColor
        entry.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        entry.layer.shadowRadius = 10
        entry.layer.shadowOpacity = 0.24
        entry.layer.masksToBounds = false
        entry.layer.shadowPath = UIBezierPath(roundedRect: entry.bounds, cornerRadius: entry.layer.cornerRadius).cgPath
        
        entry.backgroundColor = .white
        
        let entryPokemon: Pokemon = PokemonManager.shared.getPokemon(at: indexPath.row)
        entry.pokemon = entryPokemon
        let url = URL(string: entryPokemon.imageUrlLarge)
        entry.pokemonImage.kf.setImage(with: url)
        entry.pokemonName.text = entryPokemon.name
        entry.pokemonID.text = "#" + String(entryPokemon.id)
        
        return entry
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetailVC", sender: PokemonManager.shared.getPokemon(at: indexPath.row))
    }
}
