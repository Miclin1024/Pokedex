//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Michael Lin on 2020/2/15.
//  Copyright © 2020 Michael Lin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonID: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var typeImageStackView: UIStackView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var atkLabel: UILabel!
    @IBOutlet weak var spAtkLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var defLabel: UILabel!
    @IBOutlet weak var spDefLabel: UILabel!
    
    var showPokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let target = showPokemon {
            self.pokemonName.text = target.name
            self.pokemonID.text = "#" + String(target.id)
            self.pokemonImage.kf.setImage(with: URL(string: target.imageUrlLarge))
            self.totalLabel.text = String(target.total)
            self.hpLabel.text = String(target.health)
            self.atkLabel.text = String(target.attack)
            self.spAtkLabel.text = String(target.specialAttack)
            self.spDefLabel.text = String(target.specialDefense)
            self.speedLabel.text = String(target.speed)
            self.defLabel.text = String(target.defense)
            self.spDefLabel.text = String(target.specialDefense)
            
            typeImageStackView.distribution = .fillEqually
            for index in 0 ..< target.types.count {
                let typeImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
                typeImage.image = UIImage(named: target.types[index].rawValue)
                typeImage.contentMode = .scaleAspectFit
                typeImageStackView.addArrangedSubview(typeImage)
            }
            
            
    
        }
    }
}
