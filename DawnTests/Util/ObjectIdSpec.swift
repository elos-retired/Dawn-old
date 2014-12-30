import Dawn
import Nimble
import Quick

class ObjectIdSpec: QuickSpec {
    override func spec() {
        describe("ObjectId generator") {
            var id1: ObjectId!
            var id2: ObjectId!
            
            beforeEach {
                id1 = ObjectId()
                id2 = ObjectId()
            }
            
            it("generates different ObjectIds") {
                expect(id1.toString()).notTo(equal(id2.toString()))
            }
            
            it("has a timestamp") {
                expect(id1.timestamp - id2.timestamp).to(beLessThan(100))
            }
            
            it("has the same machine id") {
                expect(id1.machine).to(equal(id2.machine))
            }
            
            it("has the same process id") {
                expect(id1.pid).to(equal(id2.pid))
            }
            
            it("has a different increment") {
                expect(id1.increment).notTo(equal(id2.increment))
            }
        }
        
        describe("ObjectId interpreter") {
            let idString = "54a253eaf8e2d15d21ed7d45"
            let id = ObjectId(mongoId: idString)!
            
            it("returns nil when given nil") {
                expect(ObjectId(mongoId: nil)).to(beNil())
            }
            
            it("has the right timestamp") {
                // December 30, 2014 at 23:27:38 GMT-0800,
                // if you want to know
                expect(id.timestamp).to(equal(0x54a253ea))
            }
            
            it("has the right machine id") {
                expect(id.machine).to(equal(0xf8e2d1))
            }
            
            it("has the right process id") {
                expect(id.pid).to(equal(0x5d21))
            }
            
            it("has the right increment") {
                expect(id.increment).to(equal(0xed7d45))
            }
        }
    }
}
