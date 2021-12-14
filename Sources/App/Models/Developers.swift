//
//  KeepCoding
//
//
//  Created by JOSE LUIS BUSTOS ESTEBAN
//


import Vapor
import Fluent

// Pacientes
final class Developers : Model , Content{
    static let schema = "developers"
    
    @ID(custom: "id") var id:UUID?
    @Field(key: "name") var name:String
    @Field(key: "apell1") var apell1:String
    @Field(key: "apell2") var apell2:String
    @Field(key: "email") var email:String
    @Field(key: "photo") var photo:String //foto del Empleado en una URL
    @Parent(key: "bootcamp")  var bootcamp:Bootcamps
    
    // Relacion N a N con Heros. Asi accedo desde un developer a sus Heros
    @Siblings(through: DevelopersHeros.self, from: \.$developer, to: \.$hero ) var heros:[Heros]
   
    
    
    init(){}
    
    init(id:UUID? = nil, name:String, apell1:String, apell2:String, email:String, photo:String, bootcamp:UUID){
        self.id = id
        self.name = name
        self.apell1 = apell1
        self.apell2 = apell2
        self.email = email
        self.photo = photo
        self.$bootcamp.id  = bootcamp
    }
}

// for Register
struct DeveloperRegister : Content {
    let name : String
    let apell1 : String
    let apell2 : String
    let email : String
    let bootcamp:UUID
    var password : String
    let photo:String
    
}

struct DeveloperLike: Content {
    let hero:UUID
}
