//
//  KeepCoding
//
//
//  Created by JOSE LUIS BUSTOS ESTEBAN
//

import Fluent
import Vapor
import JWT


struct LoginController : RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        
        // Seguridad AppUser. (usuario y clave)
        let app = routes.grouped("api","auth")
            .grouped(UsersApp.authenticator())
            .grouped(UsersApp.guardMiddleware())
        app.post("login", use: loginJWT)
        
        
        // Seguridad JWT de un endpoint solo apra pruebas
        let tokenAppjwt = routes.grouped("api","jwt")
        tokenAppjwt.get("test", use: test)
       
    
    }
    
    
     
     func loginJWT(_ req:Request) async throws -> String{
         let user = try req.auth.require(UsersApp.self)
         var identify : UUID? = nil
         
         if let idDeveloper = user.$developer.id {
             identify = idDeveloper
         }
         
         //Creo el Payload
   
         let payload  = PayloadApp(email: .init(value: user.email), expiration: .init(value: .distantFuture), identify: identify!)
         // Firmamos con RSA256
         let token  = try req.jwt.sign(payload, kid: JWKIdentifier(string: "private"))
         return token
     }
     
     
     func test(_ req:Request) async throws -> String {
         print("entra en metodo test de JWT")
         let payload = try req.jwt.verify(as: PayloadApp.self)
         //return req.eventLoop.makeSucceededFuture("Todo Correcto email usuario: \(payload.email.value)")
         return "Todo Correcto email usuario: \(payload.email.value)"
     }
    
   
}

