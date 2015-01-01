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
    
    init(title: String) {
        self.title = title
    }
}

class SerializableSpec: QuickSpec {
    override func spec() {
        var will = Author(name: "William Shakespeare", books: [Book(title: "King Lear"), Book(title: "Romeo and Juliet")])
        var json = "{\"name\":\"William Shakespeare\",\"books\":[{\"title\":\"King Lear\"},{\"title\":\"Romeo and Juliet\"}]}"
        it("serializes an object to json") {
            expect(will.toJsonString()).to(equal(json))
        }
    }
}