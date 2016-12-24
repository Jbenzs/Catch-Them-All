//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Benzs Jean Francois on 12/21/16.
//  Copyright © 2016 benzsjeanfrancois. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var pokedexLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var nextEvoLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = pokemon.name.capitalized
        
        let img = UIImage(named: "\(pokemon.pokedexID)")
        currentEvoImg.image = img
        mainImg.image = img
        pokedexLabel.text = "\(pokemon.pokedexID)"
        
        pokemon.downloadPokemonDetails {
            
            print("Did arrive here")
            
            //whatever we write will only be called after the network call is complete!
            
            self.updateUI()
            
        }
        
    }
    
    func updateUI() {
        
        attackLabel.text = pokemon.attack
        defenseLabel.text = pokemon.defense
        heightLabel.text = pokemon.height
        weightLabel.text = pokemon.weight
        typeLabel.text = pokemon.type
        descriptionLabel.text = pokemon.description
        
        if pokemon.nextEvoID == "" {
            
            nextEvoLabel.text = "No Evolutions"
            nextEvoImg.isHidden = true
        } else {
            
            nextEvoImg.isHidden = false
            nextEvoImg.image = UIImage(named: pokemon.nextEvoID)
            
            let str = "Next Evolution: \(pokemon.nextEvoName) - LVL \(pokemon.nextEvoLevel)"
            nextEvoLabel.text = str
        }
    }

    @IBAction func backButtonpressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        
        
    }
   
    
}
