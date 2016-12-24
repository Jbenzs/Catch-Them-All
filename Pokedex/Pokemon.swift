//
//  Pokemon.swift
//  Pokedex
//
//  Created by Benzs Jean Francois on 12/18/16.
//  Copyright © 2016 benzsjeanfrancois. All rights reserved.
//

import Foundation
import Alamofire


class Pokemon {

    private var _name: String!
    private var _pokedexID: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvoText: String!
    private var _pokemonURL: String!
    private var _nextEvoName: String!
    private var _nextEvoID: String!
    private var _nextEvoLevel: String!
    
    var nextEvoName: String {
        
        if _nextEvoName == nil {
            _nextEvoName = ""
        }
        
        return _nextEvoName
    }
    
    var nextEvoID: String {
        
        if _nextEvoID == nil {
            _nextEvoID = ""
        }
        
        return _nextEvoID
    }
    
    var nextEvoLevel: String {
        
        if _nextEvoLevel == nil {
            _nextEvoLevel = ""
        }
        
        return _nextEvoLevel
    }
    
    var nextEvoText: String {
        
        if _nextEvoText == nil {
            
           _nextEvoText = ""
        }
        return _nextEvoText
    }
    
    var attack: String {
        
        if _attack == nil {
            _attack = ""
        }
        
        return _attack
    }
    
    var weight: String {
        
        if _weight == nil {
            
            _weight = ""
        }
        
        return _weight
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        
        return _height
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        
        return _defense
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        
        return _type
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        
        return _description
    }
    
    var name: String {
    
        return _name
    }
    
    var pokedexID: Int {
        
        return _pokedexID
    }
 
    
    init(name: String, pokedexID: Int) {
        
        self._name = name
        self._pokedexID = pokedexID
        
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexID)/"
    }
    
    func downloadPokemonDetails(completed: @ escaping DownloadComplete) {
        
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            
            if let  dict = response.result.value as? Dictionary <String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height  = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                print(self._weight)
                print(self._height)
                print(self._attack)
                print(self._defense)
                
                if let types = dict["types"] as? [Dictionary <String, String>] , types.count > 0 {
                    
                    if let name = types[0]["name"] {
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1 {
                        
                        for x in 1..<types.count {
                            if let name = types[x]["name"] {
                                
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                    
                    print(self._type)
                    
                }else {
                    self._type = ""
                }
                
                if let desArr = dict["descriptions"] as? [Dictionary <String, String>] , desArr.count > 0 {
                    
                    if let url = desArr[0]["resource_uri"] {
                        
                        let descURL = "\(URL_BASE)\(url)"
                        
                        Alamofire.request(descURL).responseJSON { (response) in
                            
                            if let descDict = response.result.value as? Dictionary <String, AnyObject> {
                                
                                if let description = descDict["description"] as? String {
                                    
                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    self._description = newDescription
                                    print(newDescription)
                                    
                                    
                                  }
                                }
                            completed()
                            
                            }
                    }
                } else {
                    self._description = ""
                }
                
                if let evolution = dict["evolutions"] as? [Dictionary <String, AnyObject>] , evolution.count > 0 {
                    
                    if let nextEvo = evolution[0]["to"] as? String {
                        
                        if nextEvo.range(of: "mega") == nil {
                            
                            self._nextEvoName = nextEvo
                            
                            if let uri = evolution[0]["resource_uri"] as? String {
                                
                                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvolID = newStr.replacingOccurrences(of: "/", with: "")
                                self._nextEvoID = nextEvolID
                                
                                if let lvlExist = evolution[0]["level"] {
                                    
                                    if let level = lvlExist as? Int {
                                        self._nextEvoLevel = "\(level)"
                                    }
                                    
                                } else {
                                    self._nextEvoLevel = ""
                                }
                            }
                        }
                    }
                    
                    print(self.nextEvoLevel)
                    print(self.nextEvoName)
                    print(self.nextEvoID)
                }

                
            }
            
            completed()
        }
        
        
        
        
        
    }
}
