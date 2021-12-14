//
//  KeepCoding
//
//
//  Created by JOSE LUIS BUSTOS ESTEBAN
//

import Vapor
import Fluent

// Heros
final class Heros : Model , Content{
    static let schema = "heros"
    
    @ID(custom: "id") var id:UUID?
    @Field(key: "name") var name:String
    @Field(key: "description") var description:String
    @Field(key: "photo") var photo:String
    
    // Relacion N a N con Developers.
    @Siblings(through: DevelopersHeros.self, from: \.$hero, to: \.$developer ) var developers:[Developers]
  
    
    init(){}
    
    init(id:UUID? = nil, name:String, description:String, photo:String){
        self.id = id
        self.name = name
        self.description = description
        self.photo = photo
    }
}


// for Filter
struct HerosFilter : Content {
    var name : String
}

// Request to create
struct HerosCreateRequest : Content {
    let name:String
    let description:String
    let photo:String
}

struct HerosResponse: Content {
    let id:UUID
    let name:String
    let description:String
    let photo:String
    let favorite:Bool
}
