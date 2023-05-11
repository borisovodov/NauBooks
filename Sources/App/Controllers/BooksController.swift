import Fluent
import Vapor

struct BooksController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let books = routes.grouped("books")
        books.get(use: index)
        books.post(use: create)
        books.group(":bookID") { book in
            books.delete(use: delete)
        }
    }

    func index(req: Request) async throws -> [Book] {
        try await Book.query(on: req.db).all()
    }

    func create(req: Request) async throws -> Book {
        let book = try req.content.decode(Book.self)
        try await book.save(on: req.db)
        return book
    }
    
    func delete(req: Request) async throws -> HTTPStatus {
        guard let book = try await Book.find(req.parameters.get("bookID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await book.delete(on: req.db)
        return .noContent
    }
}
