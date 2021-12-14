//
//  File.swift
//  
//
//  Created by JOSE LUIS BUSTOS ESTEBAN on 19/5/21.
//

import Fluent
import Vapor

// Tabla N-N Developers y Heros
final class DevelopersHeros : Model {
    static let schema = "developes_heros"
    
    @ID() var id:UUID?
    @Parent(key: "developer") var developer:Developers
    @Parent(key: "hero") var hero:Heros
    
    init(){}
    
    init(id: UUID? = nil, developer:Developers,hero:Heros ) throws{
        self.id = id
        self.$developer.id = try developer.requireID()
        self.$hero.id = try hero.requireID()
    }
}

