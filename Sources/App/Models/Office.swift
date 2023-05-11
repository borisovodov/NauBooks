import Fluent
import Vapor

final class Office: Model, Content {
    static let schema = "offices"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String

    @Parent(key: "admin_id")
    var admin: User

    @Children(for: \.$office)
    var books: [Book]

    init() { }

    init(id: UUID? = nil, title: String, admin: User) {
        self.id = id
        self.title = title
        self.admin = admin
    }
}
