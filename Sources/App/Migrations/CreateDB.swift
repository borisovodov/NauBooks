import Fluent

struct CreateDB: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema(Book.schema)
            .id()
            .field("title", .string, .required)
            .field("goodreads", .string)
            .field("goodreadsRating", .int8)
            .field("goodreadsRatingCount", .int8)
            .field("user_id", .uuid, .references("users", "id"))
            .field("office_id", .uuid, .references("offices", "id"))
            .create()
        
        try await database.schema(Office.schema)
            .id()
            .field("title", .string, .required)
            .field("admin_id", .uuid, .references("users", "id"))
            .create()

        try await database.schema(User.schema)
            .id()
            .field("title", .string, .required)
            .field("username", .string, .required)
            .create()
        
        try await database.schema(Review.schema)
            .id()
            .field("text", .string, .required)
            .field("book_id", .uuid, .references("books", "id"))
            .field("user_id", .uuid, .references("users", "id"))
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema(Book.schema).delete()
        try await database.schema(Office.schema).delete()
        try await database.schema(User.schema).delete()
        try await database.schema(Review.schema).delete()
    }
}
