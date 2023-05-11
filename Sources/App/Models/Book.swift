import Fluent
import Vapor

final class Book: Model, Content {
    static let schema = "books"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String

    @OptionalField(key: "goodreads")
    var goodreads: String?

    @OptionalField(key: "goodreadsRating")
    var goodreadsRating: Int8?

    @OptionalField(key: "goodreadsRatingCount")
    var goodreadsRatingCount: Int8?

    @OptionalParent(key: "user_id")
    var user: User?

    @OptionalParent(key: "office_id")
    var office: Office?
    
    @Children(for: \.$book)
    var reviews: [Review]

    init() { }

    init(id: UUID? = nil, title: String, goodreads: String?, user: User?, office: Office?) {
        self.id = id
        self.title = title
        self.goodreads = goodreads
        self.user = user
        self.office = office
    }
}
