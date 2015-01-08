import Nimble
import Quick

class ElosDateFormatterSpec: QuickSpec {
    override func spec() {
        let dateString = "1970-01-01T00:00:00.000000000+00:00"
        let date = NSDate(timeIntervalSince1970: 0)
        
        describe("ElosDateFormatter.dateFromString") {
            it("returns a nil date for nil string") {
                expect(ElosDateFormatter.dateFromString(nil)).to(beNil())
            }
            
            it("returns the correct date from an elos-formatted string") {
                let testDate = ElosDateFormatter.dateFromString(dateString)
                expect(testDate).notTo(beNil())
                expect(testDate).to(equal(date))
            }
        }
        
        describe("ElosDateFormatter.stringFromDate") {
            it("returns a nil string for nil date") {
                expect(ElosDateFormatter.stringFromDate(nil)).to(beNil())
            }
            
            it("returns the correct elos-formatted string for a date") {
                let testString = ElosDateFormatter.stringFromDate(date)
                expect(testString).notTo(beNil())
                
                // To deal with some timezone-related issues
                expect(ElosDateFormatter.dateFromString(testString)).to(equal(date))
            }
        }
    }
}