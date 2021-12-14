//
//  KeepCoding
//  
//
//  Created by JOSE LUIS BUSTOS ESTEBAN
//

import Vapor
import Fluent

// Bootcamps KeepCoding
final class Bootcamps : Model , Content{
    static let schema = "bootcamps"
    
    @ID(custom: "id") var id:UUID?
    @Field(key: "name") var name:String
    
    // relacion Virtual para ver Prograamdores de un Bootcamp
    //@Children(for: \.$bootcamp) var developers:[Developers]
   
    init(){}
    
    init(id:UUID? = nil, name:String){
        self.id = id
        self.name = name
    }
}

