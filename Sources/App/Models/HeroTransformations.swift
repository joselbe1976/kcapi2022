//
//  File.swift
//  
//
//  Created by JOSE LUIS BUSTOS ESTEBAN on 18/2/22.
//

import Vapor
import Fluent

// Localizaciones de un Hero
final class HeroTransformations : Model , Content{
    static let schema = "heros_transformations"
    
    @ID() var id:UUID?
    @Parent(key: "hero") var hero:Heros
    @Field(key: "name") var name:String
    @Field(key: "description") var description:String
    @Field(key: "photo") var photo:String
    
    init(){}
    
    init(id: UUID? = nil,hero:Heros, name:String, description:String, photo:String) throws{
        self.id = id
        self.$hero.id = try hero.requireID()
        self.name = name
        self.description = description
        self.photo = photo
    }
}


struct HerosTransformationListRequest : Content {
    let id:UUID
}

struct HerosTransformationRequest : Content {
    let id:UUID
    let name:String
    let description:String
    let photo:String
}

