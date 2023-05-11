import Fluent

struct CreateDB: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("books")
            .id()
            .field("title", .string, .required)
            .field("goodreads", .string)
            .field("goodreadsRating", .int8)
            .field("goodreadsRatingCount", .int8)
            .field("user_id", .uuid, .references("users", "id"))
            .field("office_id", .uuid, .references("offices", "id"))
            .create()
        
        try await database.schema("offices")
            .id()
            .field("title", .string, .required)
            .field("admin_id", .uuid, .references("users", "id"))
            .create()

        try await database.schema("users")
            .id()
            .field("title", .string, .required)
            .field("username", .string, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("books").delete()
        try await database.schema("offices").delete()
        try await database.schema("users").delete()
    }
}
