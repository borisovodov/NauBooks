import Fluent
import Vapor

struct ReviewsController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let reviews = routes.grouped("reviews")
        reviews.get(use: index)
        reviews.post(use: create)
        reviews.group(":reviewID") { review in
            reviews.delete(use: delete)
        }
    }

    func index(req: Request) async throws -> [Review] {
        try await Review.query(on: req.db).all()
    }

    func create(req: Request) async throws -> Review {
        let review = try req.content.decode(Review.self)
        try await review.save(on: req.db)
        return review
    }
    
    func delete(req: Request) async throws -> HTTPStatus {
        guard let review = try await Review.find(req.parameters.get("reviewID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await review.delete(on: req.db)
        return .noContent
    }
}
