import Fluent
import Vapor

final class Review: Model, Content {
    static let schema = "reviews"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "text")
    var text: String

    @Parent(key: "book_id")
    var book: Book
    
    @Parent(key: "user_id")
    var author: User

    init() { }

    init(id: UUID? = nil, text: String, book: Book, author: User) {
        self.id = id
        self.text = text
        self.book = book
        self.author = author
    }
}
