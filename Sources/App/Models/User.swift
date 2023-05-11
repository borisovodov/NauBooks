import Fluent
import Vapor

final class User: Model, Content {
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "username")
    var username: String

    @Children(for: \.$user)
    var books: [Book]
    
    @Children(for: \.$author)
    var reviews: [Review]

    init() { }

    init(id: UUID? = nil, username: String) {
        self.id = id
        self.username = username
    }
}
