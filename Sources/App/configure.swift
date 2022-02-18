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
        
        app.databases.use(.postgres(hostname: "ec2-54-220-53-223.eu-west-1.compute.amazonaws.com", port: 5432, username: "zezyjrxzpbqqsu", password: "b2369a5fc7706264ac7ab44093576b883362506fabb1d9984bfe24b443afe7ec", database: "d5a7ughenju6tn", tlsConfiguration: .forClient(certificateVerification: .none)), as: .psql)
    }
    
    
    
    //Aqui las migraciones MOdelo datos
    app.migrations.add(Bootcamps_v1())
    app.migrations.add(Developers_v1())
    app.migrations.add(CreateUsersApp_v1())
    app.migrations.add(Heros_v1())
    app.migrations.add(HerosLocations_v1())
    app.migrations.add(DevelopersHeros_v1())
    
    
    // Aqui datos por defecto
    app.migrations.add(Create_Data_v1()) //creamos los bootcamps
    app.migrations.add(Create_Data_Heros_v1()) // cramos los heroes
    
    
    //encriptacion del sistema
    app.passwords.use(.bcrypt)
    
    //JWT Config
    app.jwt.signers.use(.hs256(key: "2022KeepCoding2022"))
    
    
    // register routes
    try routes(app)
}
