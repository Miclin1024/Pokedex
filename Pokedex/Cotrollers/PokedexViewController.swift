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
    @IBOutlet weak var pokedexSearchBar: UISearchBar!
    
    enum layoutStates {
        case COLLECTION
        case TABLE
    }
    
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
        
        pokedexSearchBar.searchTextField.font = UIFont(name: "GillSans", size: 15)
        
        view.insertSubview(blurEffectView, at: 5)
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
    
    func transToTableView() {
        PokemonManager.shared.currLayout = PokemonManager.layoutStates.TABLE
        self.pokemonCollectionView.reloadData()
    }
    
    func transToCollectionView() {
        PokemonManager.shared.currLayout = PokemonManager.layoutStates.COLLECTION
        self.pokemonCollectionView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? DetailViewController, segue.identifier == "toDetailVC" {
            if let target = sender as? Pokemon {
                destVC.showPokemon = target
            }
        }
    }
    
    @IBAction func layoutToggle(_ sender: Any) {
        if PokemonManager.shared.currLayout == PokemonManager.layoutStates.COLLECTION {
            transToTableView()
        } else {
            transToCollectionView()
        }
    }
}
