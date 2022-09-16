@testable import Malibu
import Nimble
import Quick

final class FormURLEncoderSpec: QuickSpec {
    override func spec() {
        describe("FormURLEncoder") {
            var encoder: FormURLEncoder!

            beforeEach {
                encoder = FormURLEncoder()
            }

            describe("#encode:parameters") {
                it("encodes a dictionary of parameters to NSData object") {
                    let parameters = ["firstname": "John", "lastname": "Doe"]
                    let string = QueryBuilder().buildQuery(from: parameters)
                    let data = string.data(using: String.Encoding.utf8,
                                           allowLossyConversion: false)

                    expect { try encoder.encode(parameters: parameters) }.to(equal(data))
                }
            }
        }
    }
}
