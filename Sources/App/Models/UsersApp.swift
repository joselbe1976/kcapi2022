//
//  KeepCoding
//
//
//  Created by JOSE LUIS BUSTOS ESTEBAN
//

import Vapor
import Fluent

extension FieldKey {
    static var email: FieldKey { "email" }
    static var password: FieldKey { "password" }
    static var activo: FieldKey { "activo" }
}

final class UsersApp : Model, Content{
    static var schema = "users"

    @ID() var id : UUID? // Identificador
    @Field(key: .email) var email:String
    @Field(key: .password) var password:String
    
    //Se le asocia un developer al usuario id
    @OptionalParent(key: "developer") var developer:Developers?
   
    
    init(){}
    
    init(id:UUID? = nil, email:String, password:String, developer:UUID?){
        self.id = id
        self.email = email
        self.password = password
        self.$developer.id = developer
    }

}

// autenticacion basica. ModelAuthenticatable para Web Leaf
extension  UsersApp : ModelAuthenticatable, ModelCredentialsAuthenticatable{
    // Security: Basic Auythetication
    static var usernameKey = \UsersApp.$email
    static var passwordHashKey = \UsersApp.$password
    
    // verifica
    func verify(password: String) throws -> Bool {
        try Bcrypt.verify(password, created: self.password)
    }
}

// para Web
extension UsersApp: SessionAuthenticatable {
    typealias SessionID = UUID
    var sessionID: UUID {
        self.id!
    }
}


//Validacion basica
extension  UsersApp : Validatable{
    // validaciones sobre los datos. de la clase (no es de seguridad). Se ejecuta cuando se hace el decode (recibo JSOn en el endpoint en el POST). Se valida justo antes del decode.
    static func validations(_ validations: inout Validations) {
        validations.add("email", as: String.self, is: Validator.email, required: true)
        validations.add("password", as: String.self, is: .count(8...) && !.empty, required: true)
        // opodemos usar && y Ors.
    }
}


// web

struct UserSessionAuthenticator: SessionAuthenticator {
    typealias User = UsersApp
    
    func authenticate(sessionID: UUID, for request: Request) -> EventLoopFuture<Void> {
        UsersApp.find(sessionID, on: request.db).map { user in
            if let user = user {
                request.auth.login(user)
            }
        }
    }
}

