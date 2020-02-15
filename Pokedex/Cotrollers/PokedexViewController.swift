//
//  PokedexViewController.swift
//  Pokedex
//
//  Created by Michael Lin on 2020/2/12.
//  Copyright © 2020 Michael Lin. All rights reserved.
//

import UIKit
import Kingfisher

class PokedexViewController: UIViewController {

    @IBOutlet weak var welcomeImageView: UIImageView!
    @IBOutlet weak var pokemonCollectionView: UICollectionView!
    
    fileprivate let blurEffectView = UIVisualEffectView(effect: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.bringSubviewToFront(welcomeImageView)
        UIView.animate(withDuration: 1.2, delay: 0.7, options: .curveEaseInOut, animations: {
            self.welcomeImageView.alpha = 0
        }, completion: { finished in
            self.welcomeImageView.removeFromSuperview()
            self.toggleOverlayBlur(false)
        })
        
        let bgcolor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        view.backgroundColor = bgcolor
        pokemonCollectionView.backgroundColor = bgcolor
        
        
        view.insertSubview(blurEffectView, at: 1)
        blurEffectView.effect = UIBlurEffect(style: .light)
        
        blurEffectView.frame = view.bounds
        blurEffectView.isUserInteractionEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true);

    }

    func toggleOverlayBlur(_ enabled: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.blurEffectView.effect = enabled ? UIBlurEffect(style: .light) : nil
        }
    }

}

extension PokedexViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.6, height: collectionView.frame.height / 4)
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
        let url = URL(string: entryPokemon.imageUrlLarge)
        //print(entryPokemon.imageUrlLarge)
        entry.pokemonImage.kf.setImage(with: url)
        entry.pokemonName.text = entryPokemon.name
        entry.pokemonID.text = "#" + String(entryPokemon.id)
        
        
        return entry
    }
}


