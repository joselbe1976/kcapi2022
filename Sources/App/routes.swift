import Fluent
import Vapor

func routes(_ app: Application) throws {
    try app.register(collection: RegisterController())  //registro de Developers
    try app.register(collection: LoginController())  // login JWT

    try app.register(collection: HerosController()) // Heros
    try app.register(collection: BootCampsController()) // Bootcamps
    try app.register(collection: DevelopersController()) // Developers
}
