import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    try app.register(collection: BooksController())
    try app.register(collection: OfficesController())
    try app.register(collection: UsersController())
    try app.register(collection: ReviewsController())
}
