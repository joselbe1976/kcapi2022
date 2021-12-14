//
//  KeepCoding
//
//
//  Created by JOSE LUIS BUSTOS ESTEBAN
//

import Vapor
import Fluent


struct Bootcamps_v1: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Bootcamps.schema)
            .id()
            .field("name", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Bootcamps.schema)
            .delete()
    }
}




struct Developers_v1: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Developers.schema)
            .id()
            .field("name", .string, .required)
            .field("apell1", .string, .required)
            .field("apell2", .string, .required)
            .field("email", .string, .required)
            .field("photo", .string) //foto del empleado, no es requerido
            .field("bootcamp", .uuid, .required)
            .foreignKey("bootcamp", references: Bootcamps.schema, "id", onDelete: .restrict, onUpdate: .cascade, name: "FK_ADeveloper_Bootcamp") // FK con Tabla Bootcamps
           
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Developers.schema)
            .delete()
    }
}


struct CreateUsersApp_v1 : Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(UsersApp.schema)
            .id()
            .field(.email, .string, .required)
            .field(.password, .string, .required)
            .unique(on: .email) // email dato único
            .field("developer", .uuid)
            .foreignKey("developer", references: Developers.schema, "id", onDelete: .cascade, onUpdate: .cascade, name: "FK_Developer_UsersApp") // FK con Tabla Developer.
            .create()
    }
    
    // si se hecha a tras la migración
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(UsersApp.schema)
            .delete()
    }
}


struct Heros_v1: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Heros.schema)
            .id()
            .field("name", .string, .required)
            .field("description", .string, .required)
            .field("photo", .string)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Heros.schema)
            .delete()
    }
}

struct HerosLocations_v1: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(HerosLocations.schema)
            .id()
            .field("hero", .uuid, .required, .references(Heros.schema, "id"))
            .field("longitud", .string, .required)
            .field("latitud", .string, .required)
            .field("dateShow", .date)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(HerosLocations.schema)
            .delete()
    }
}


// Tabla N a N (Developers y Heros)
struct DevelopersHeros_v1: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(DevelopersHeros.schema)
            .id()
            .field("developer", .uuid, .required, .references(Developers.schema, "id"))
            .field("hero", .uuid, .required, .references(Heros.schema, "id"))
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(DevelopersHeros.schema)
            .delete()
    }
}


// --- Creacion de los datos necesarios para el backend ----
struct Create_Data_v1: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        let data1 = Bootcamps(name: "Bootcamp Mobile I")
        let data2 = Bootcamps(name: "Bootcamp Mobile II")
        let data3 = Bootcamps(name: "Bootcamp Mobile III")
        let data4 = Bootcamps(name: "Bootcamp Mobile IV")
        let data5 = Bootcamps(name: "Bootcamp Mobile V")
        let data6 = Bootcamps(name: "Bootcamp Mobile VI")
        let data7 = Bootcamps(name: "Bootcamp Mobile VII")
        let data8 = Bootcamps(name: "Bootcamp Mobile VIII")
        let data9 = Bootcamps(name: "Bootcamp Mobile IX")
        let data10 = Bootcamps(name: "Bootcamp Mobile X")
        let data11 = Bootcamps(name: "Bootcamp Mobile XI")
        let data12 = Bootcamps(name: "Bootcamp Mobile XII")
        let data13 = Bootcamps(name: "Bootcamp Mobile XIII")
        let data14 = Bootcamps(name: "Bootcamp Mobile XIV")
        
        // ejecutar un array de EventLoopFuture<void> (un bucle de ejecucion)
        return .andAllSucceed([
            data1.create(on: database),
            data2.create(on: database),
            data3.create(on: database),
            data4.create(on: database),
            data5.create(on: database),
            data6.create(on: database),
            data7.create(on: database),
            data8.create(on: database),
            data9.create(on: database),
            data10.create(on: database),
            data11.create(on: database),
            data12.create(on: database),
            data13.create(on: database),
            data14.create(on: database)
        ], on: database.eventLoop)
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        Bootcamps.query(on: database).delete()  // eliminamos los datos de los bootcamps
    }
}




// --- Creacion de los datos necesarios para el backend ----
struct Create_Data_Heros_v1: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
       
        let h1 = Heros(name: "Hulk", description: "Caught in a gamma bomb explosion while trying to save the life of a teenager, Dr. Bruce Banner was transformed into the incredibly powerful creature called the Hulk. An all too often misunderstood hero, the angrier the Hulk gets, the stronger the Hulk gets.", photo: "http://i.annihil.us/u/prod/marvel/i/mg/5/a0/538615ca33ab0/portrait_incredible.jpg")
        
        let h2 = Heros(name: "Doctor Strange", description: "", photo: "http://i.annihil.us/u/prod/marvel/i/mg/5/f0/5261a85a501fe/portrait_incredible.jpg")
 
        let h3 = Heros(name: "Captain Marvel", description: "", photo: "http://i.annihil.us/u/prod/marvel/i/mg/6/80/5269608c1be7a/portrait_incredible.jpg")
        let h4 = Heros(name: "Guardians of the Galaxy", description: "A group of cosmic adventurers brought together by Star-Lord, the  Guardians of the Galaxy protect the universe from threats all  across space. The team also includes Drax, Gamora, Groot and Rocket  Raccoon!", photo: "http://i.annihil.us/u/prod/marvel/i/mg/2/70/50febd8be6b5d/portrait_incredible.jpg")
        
        let h5 = Heros(name: "Spider-Man", description: "Bitten by a radioactive spider, high school student Peter Parker gained the speed, strength and powers of a spider. Adopting the name Spider-Man, Peter hoped to start a career using his new abilities. Taught that with great power comes great responsibility, Spidey has vowed to use his powers to help people.", photo: "http://i.annihil.us/u/prod/marvel/i/mg/3/50/526548a343e4b/portrait_incredible.jpg")
        
        let h6 = Heros(name: "Avengers", description: "Earth's Mightiest Heroes joined forces to take on threats that were too big for any one hero to tackle. With a roster that has included Captain America, Iron Man, Ant-Man, Hulk, Thor, Wasp and dozens more over the years, the Avengers have come to be regarded as Earth's No. 1 team.", photo: "http://i.annihil.us/u/prod/marvel/i/mg/9/20/5102c774ebae7/portrait_incredible.jpg")
        
        let h7 = Heros(name: "Deadpool", description: "", photo: "http://i.annihil.us/u/prod/marvel/i/mg/9/90/5261a86cacb99/portrait_incredible.jpg")
        
        let h8 = Heros(name: "Captain America", description: "Vowing to serve his country any way he could, young Steve Rogers took the super soldier serum to become America's one-man army. Fighting for the red, white and blue for over 60 years, Captain America is the living, breathing symbol of freedom and liberty.", photo: "http://i.annihil.us/u/prod/marvel/i/mg/3/50/537ba56d31087/portrait_incredible.jpg")
        
        
        let h9 = Heros(name: "Taurus (Cornelius van Lunt)", description: "New York businessman Cornelius van Lunt started a lucrative career in legitimate real estate dealing, but he later branched out into various criminal endeavors", photo: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available/portrait_incredible.jpg")
        let h10 = Heros(name: "Tarantula", description: "Tarantula has a bad attitude, evidenced by her enjoyment of inflicting pain upon her opponents, to the chagrin of her fellow Heroes for Hire", photo: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available/portrait_incredible.jpg")
        let h11 = Heros(name: "Attuma", description: "Attuma was born into the tribe of Homo mermanus who eschewed civilization to live as nomadic barbarians. For some unrecorded reason, Attuma was endowed with strength far surpassing that of his people", photo: "http://i.annihil.us/u/prod/marvel/i/mg/9/90/4ce5a862a6c48/portrait_incredible.jpg")
        let h12 = Heros(name: "Aero", description: "", photo: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available/portrait_incredible.jpg")
        let h13 = Heros(name: "Frenzy", description: "", photo: "http://i.annihil.us/u/prod/marvel/i/mg/9/b0/526958a4c3cde/portrait_incredible.jpg")
        let h14 = Heros(name: "Belasco", description: "Only the blackest of hearts would dare delve into the dark magic of the Elder Gods, but 13th Century sorcerer Belasco was of just such a heart", photo: "http://i.annihil.us/u/prod/marvel/i/mg/a/20/4ce5a878b487c/portrait_incredible.jpg")
        let h15 = Heros(name: "Bethany Cabe", description: "Former CEO, bodyguard, and love interest of Stark Enterprises and Tony Stark", photo: "http://i.annihil.us/u/prod/marvel/i/mg/f/40/4ce5a8b16ee4b/portrait_incredible.jpg")
        
        
        // ejecutar un array de EventLoopFuture<void> (un bucle de ejecucion)
        return .andAllSucceed([
            h8.create(on: database),
            h6.create(on: database),
            h5.create(on: database),
            h4.create(on: database),
            h1.create(on: database),
            h2.create(on: database),
            h3.create(on: database),
            h7.create(on: database),
            h9.create(on: database),
            h10.create(on: database),
            h11.create(on: database),
            h12.create(on: database),
            h13.create(on: database),
            h14.create(on: database),
            h15.create(on: database),
            
        ], on: database.eventLoop)
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        Heros.query(on: database).delete()  // eliminamos los datos de los Heros
    }
}

