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
    @IBOutlet weak var headImageHeight: NSLayoutConstraint!
    @IBOutlet var filterSelectionButton: [UIButton]!
    @IBOutlet weak var filterSelectionStack: UIStackView!
    @IBOutlet weak var pokeTypeTextField: UITextField!
    @IBOutlet weak var filterContentStack: UIStackView!
    
    var filterToggle = false
    
    enum layoutStates {
        case COLLECTION
        case TABLE
    }
    
    fileprivate let blurEffectView = UIVisualEffectView(effect: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filterSelectColor = UIColor(white: 15.0 / 100, alpha: 1)
        
        for btn in filterSelectionButton {
            btn.layer.cornerRadius = 10
            btn.layer.borderWidth = 2
            btn.layer.borderColor = filterSelectColor.cgColor
            btn.setTitleColor(filterSelectColor , for: .normal)
            btn.setTitleColor(.white, for: .selected)
            btn.setBackgroundColor(color: .clear, for: .normal)
            btn.setBackgroundColor(color: filterSelectColor, for: .selected)
        }
        
        pokeTypeTextField.textColor = filterSelectColor
        pokeTypeTextField.backgroundColor = UIColor(red: 239 / 255, green: 239 / 255, blue: 239 / 255, alpha: 1)
        pokeTypeTextField.layer.cornerRadius = 10
        pokeTypeTextField.layer.borderWidth = 0
        pokeTypeTextField.layer.borderColor = UIColor(red: 239 / 255, green: 239 / 255, blue: 239 / 255, alpha: 1).cgColor
        pokeTypeTextField.delegate = self
        
        view.addSubview(blurEffectView)
        view.bringSubviewToFront(blurEffectView)
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
    
    func toggleTypeFilterDisplay(to activate: Bool) {
        let this = filterSelectionButton[0]
        if activate {
            UIView.animate(withDuration: 0.3, animations: {
                this.isSelected = true
            }, completion: { _ in
                UIView.animate(withDuration: 0.2, animations: {
                    self.pokeTypeTextField.alpha = 1
                    //self.pokeTypeTextField.becomeFirstResponder()
                })
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                this.isSelected = false
                self.pokeTypeTextField.alpha = 0
            })
        }
    }
    
    func toggleStatFilterDisplay(to activate: Bool) {
        let this = filterSelectionButton[1]
        if activate {
            UIView.animate(withDuration: 0.3, animations: {
                this.isSelected = true
            }, completion: {_ in
                
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                this.isSelected = false
            })
        }
    }
    
    func toggleFilterInputExtend(to activate: Bool) {
        UIView.animate(withDuration: 0.3, animations: {
            self.headImageHeight.constant += activate ? 70 : -70
            self.view.layoutIfNeeded()
        })
    }
    
    func addFilterLabel(for type: PokeType) {
        let label = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 35))

        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.addConstraint(NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 35))
        label.addConstraint(NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 80))
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.backgroundColor = UIColor(red: 239 / 255, green: 239 / 255, blue: 239 / 255, alpha: 1)
        label.setTitle(type.rawValue, for: .normal)
        label.setTitleColor(UIColor(white: 15.0 / 100, alpha: 1), for: .normal)
        label.titleLabel?.textAlignment = .center
        label.titleLabel?.font = UIFont(name: "GillSans", size: 20)
        label.addTarget(self, action: #selector(PokedexViewController.cancelTypeFilter(_:)), for: .touchUpInside)
        UIView.animate(withDuration: 0.5, animations: {
            self.filterContentStack.addArrangedSubview(label)
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func cancelTypeFilter(_ sender: UIButton!) {
        SearchHandler.removeTypeFilter(for: sender.titleLabel!.text!)
        pokemonCollectionView.reloadData()
        
        UIView.animate(withDuration: 0.3, animations: {
            sender.alpha = 0
            self.view.layoutIfNeeded()
        }, completion: {_ in
            sender.removeFromSuperview()
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? DetailViewController, segue.identifier == "toDetailVC" {
            if let target = sender as? Pokemon {
                destVC.showPokemon = target
            }
        }
    }
    
    @IBAction func toggleFilter(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            let button = sender as! UIButton
            if self.filterToggle {
                self.headImageHeight.constant = 150
                self.filterSelectionStack.alpha = 0
                button.transform = .identity
            } else {
                self.headImageHeight.constant += 60
                button.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2.0))
            }
            self.view.layoutIfNeeded()
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, animations: {
                if self.filterToggle {
                    self.filterSelectionStack.alpha = 1
                }
            })
        })
        filterToggle = !filterToggle
    }
    
    @IBAction func typeSelected(_ sender: Any) {
        let statBtn = filterSelectionButton[1]
        let typeBtn = sender as! UIButton
        if statBtn.isSelected {
            toggleTypeFilterDisplay(to: true)
            toggleStatFilterDisplay(to: false)
        } else if !typeBtn.isSelected {
            toggleTypeFilterDisplay(to: true)
            toggleFilterInputExtend(to: true)
        } else {
            toggleTypeFilterDisplay(to: false)
            toggleFilterInputExtend(to: false)
        }
    }
    
    @IBAction func statSelected(_ sender: Any) {
        let statBtn = sender as! UIButton
        let typeBtn = filterSelectionButton[0]
        if typeBtn.isSelected {
            toggleTypeFilterDisplay(to: false)
            toggleStatFilterDisplay(to: true)
        } else if !statBtn.isSelected {
            toggleStatFilterDisplay(to: true)
            toggleFilterInputExtend(to: true)
        } else {
            toggleStatFilterDisplay(to: false)
            toggleFilterInputExtend(to: false)
        }
    }
    
    @IBAction func onPokeTypeEditChange(_ sender: Any) {
        let textfield = sender as! UITextField
        if let text = textfield.text {
            for type in PokeType.allCases {
                if type == text {
                    addFilterLabel(for: type)
                    textfield.text = ""
                    SearchHandler.applyTypeFilter(type: type)
                    pokemonCollectionView.reloadData()
                }
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
