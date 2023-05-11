import Fluent
import Vapor

struct OfficesController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let offices = routes.grouped("offices")
        offices.get(use: index)
        offices.post(use: create)
        offices.group(":officeID") { office in
            offices.delete(use: delete)
        }
    }

    func index(req: Request) async throws -> [Office] {
        try await Office.query(on: req.db).all()
    }

    func create(req: Request) async throws -> Office {
        let office = try req.content.decode(Office.self)
        try await office.save(on: req.db)
        return office
    }
    
    func delete(req: Request) async throws -> HTTPStatus {
        guard let office = try await Office.find(req.parameters.get("officeID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await office.delete(on: req.db)
        return .noContent
    }
}
