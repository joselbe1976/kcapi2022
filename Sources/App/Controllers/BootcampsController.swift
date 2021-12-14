//
//  File.swift
//  
//
//  Created by JOSE LUIS BUSTOS ESTEBAN on 9/5/21.
//

import Fluent
import Vapor
import JWT


struct BootCampsController : RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        
        // Seguridad JWT de un endpoint solo apra pruebas
        let tokenAppjwt = routes.grouped("api","data")
        tokenAppjwt.get("bootcamps", use: allBootcamps)

    }
    
    
    // Devuelve todos los BootCamps
    func allBootcamps(_ req:Request) async throws -> [Bootcamps] {
        let data = try await Bootcamps.query(on: req.db).all()
        return data

    }

}


