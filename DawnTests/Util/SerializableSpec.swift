import Dawn
import Nimble
import Quick

class Author: Serializable {
    var name: String
    var books: Array<Book>
    
    init(name: String, books: Array<Book>) {
        self.name = name
        self.books = books
    }
}

class Book: Serializable {
    var title: String
    var published_at: NSDate
    
    init(title: String, published_at: NSDate) {
        self.title = title
        self.published_at = published_at
    }
}

class SerializableSpec: QuickSpec {
    override func spec() {
        var date = NSDate()
        var dateStr = ElosDateFormatter.stringFromDate(date)! // Separately tested
        var lear = Book(title: "King Lear", published_at: date)
        var romeo = Book(title: "Romeo and Juliet", published_at: date)
        var will = Author(name: "William Shakespeare", books: [lear, romeo])
        var json = "{\"name\":\"William Shakespeare\",\"books\":[{\"title\":\"King Lear\",\"published_at\":\"\(dateStr)\"},{\"title\":\"Romeo and Juliet\",\"published_at\":\"\(dateStr)\"}]}"
        it("serializes an object to json") {
            expect(will.toJsonString()).to(equal(json))
        }
    }
}