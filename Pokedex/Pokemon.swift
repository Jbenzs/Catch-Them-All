//
//  Pokemon.swift
//  Pokedex
//
//  Created by Benzs Jean Francois on 12/18/16.
//  Copyright © 2016 benzsjeanfrancois. All rights reserved.
//

import Foundation


class Pokemon {

    fileprivate var _name: String!
    fileprivate var _pokedexID: Int!
    
    var name: String {
    
        return _name
    }
    
    var pokedexID: Int {
        
        return _pokedexID
    }
 
    
    init(name: String, pokedexID: Int) {
        
        self._name = name
        self._pokedexID = pokedexID
    }
}
