//
//  KeepCoding
//
//
//  Created by JOSE LUIS BUSTOS ESTEBAN
//

import Fluent
import Vapor


struct RegisterController : RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let app = routes.grouped("api","register")
        app.post("developer", use: developerRegister)
    }
    
    // // Register a Developer in the System
    func developerRegister(_ req:Request) async throws -> HTTPStatus{
        var registerDevelop = try req.content.decode(DeveloperRegister.self)
        registerDevelop.password = try req.password.hash(registerDevelop.password)
        let dev = Developers(name: registerDevelop.name, apell1: registerDevelop.apell1, apell2: registerDevelop.apell2, email: registerDevelop.email, photo: registerDevelop.photo, bootcamp: registerDevelop.bootcamp)
        
        // verificamos si existe el mail como usuario, entonces error
       return try await Developers
            .query(on: req.db)
            .filter(\.$email == registerDevelop.email)  // No puede estar el mismo email
            .first()
            .flatMap{ exist in
                if exist == nil{
                    return req.db.transaction { database in // Create a Transaction for 2 inserts.
                        return dev
                            .create(on: database)
                            .flatMap{
                                // creamos el usuario de la Aplicación
                                let user = UsersApp(email: registerDevelop.email , password: registerDevelop.password, developer: dev.id )
                                return user
                                    .create(on: database)
                                    .transform(to: .created)//201
                                 
                            }
                    }
                }else{
                    // si existe, damos error
                    return req.eventLoop.makeFailedFuture(Abort(.badRequest))
                }
            }
            .get()
    }
    
    
   
}


