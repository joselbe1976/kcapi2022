//
//  File.swift
//  
//
//  Created by JOSE LUIS BUSTOS ESTEBAN on 14/12/21.
//


import Vapor
import Fluent

// Localizaciones de un Hero
final class HerosLocations : Model , Content{
    static let schema = "heros_locations"
    
    @ID() var id:UUID?
    @Parent(key: "hero") var hero:Heros
    @Field(key: "longitud") var longitud:String
    @Field(key: "latitud") var latitud:String
    @Field(key: "dateShow") var dateShow:Date
    
    init(){}
    
    init(id: UUID? = nil,hero:Heros, longitud:String, latitud:String, dateShow:Date) throws{
        self.id = id
        self.$hero.id = try hero.requireID()
        self.longitud = longitud
        self.latitud = latitud
        self.dateShow = dateShow
    }
}


// Request to create
struct HerosLocationsRequest : Content {
    let id:UUID
    let longitud:String
    let latitud:String
}

struct HerosLocationsListRequest : Content {
    let id:UUID
}


struct HerosLocationsResponse: Content {
    let id:UUID
    let longitud:String
    let latitud:String
    let idHero:UUID
}

