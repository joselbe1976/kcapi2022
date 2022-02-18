import Fluent
//import FluentSQLiteDriver
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

   // app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)
 
    //PostGree
    
    if let databaseURL = Environment.get("DATABASE_URL"), var postgresConfig = PostgresConfiguration(url: databaseURL) {
        postgresConfig.tlsConfiguration = .forClient(certificateVerification: .none)
        app.databases.use(.postgres(
            configuration: postgresConfig
        ), as: .psql)
    } else {
        
        app.databases.use(.postgres(hostname: "ec2-34-233-214-228.compute-1.amazonaws.com", port: 5432, username: "xpbmiqzjbtqomr", password: "a02e20293d4f02afe5a6cb4073577e0b779de84c2eafa5e73f7e0974147e90af", database: "d9s1n4l072ofsm", tlsConfiguration: .forClient(certificateVerification: .none)), as: .psql)
    }
    
    
    
    //Aqui las migraciones MOdelo datos
    app.migrations.add(Bootcamps_v1())
    app.migrations.add(Developers_v1())
    app.migrations.add(CreateUsersApp_v1())
    app.migrations.add(Heros_v1())
    app.migrations.add(HerosLocations_v1())
    app.migrations.add(DevelopersHeros_v1())
    app.migrations.add(HerosTransformations_v1())
    
    
    // Aqui datos por defecto
    app.migrations.add(Create_Data_v1()) //creamos los bootcamps
    app.migrations.add(Create_Data_Heros_v1()) // cramos los heroes
    app.migrations.add(Create_Data_Transformations_v1()) //creamos las transformaciones de los Heroes
    
    //encriptacion del sistema
    app.passwords.use(.bcrypt)
    
    //JWT Config
    app.jwt.signers.use(.hs256(key: "2022KeepCoding2022"))
    
    
    // register routes
    try routes(app)
}
