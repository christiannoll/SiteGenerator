import XCTest

class UnitTest: XCTestCase {

    var smlBuilder: SmlBuilder!
    
    override func setUp() {
        smlBuilder = SmlBuilder()
    }

    override func tearDown() {
    }

    func testLinkWithUrl() {
        let s = "text1 [title](url) text2"
        let text = smlBuilder.render(s)
        
        XCTAssertEqual(text, "text1<a href=\"url\">title</a> text2")
    }
    
    func testUnterminatedLink() {
        let s = "[hello] world"
        let text = smlBuilder.render(s)
        
        XCTAssertEqual(text, "[hello] world")
    }
    
    func testUnterminatedLink2() {
        let s = "[hello](world"
        let text = smlBuilder.render(s)
        
        XCTAssertEqual(text, "[hello](world")
    }
    
    func testBoldText() {
        let s = "Hello, *world*!"
        let text = smlBuilder.render(s)
        
        XCTAssertEqual(text, "Hello, <strong>world</strong>!")
    }
    
    func testItalicText() {
        let s = "Hello, _world_!"
        let text = smlBuilder.render(s)
        
        XCTAssertEqual(text, "Hello, <em>world</em>!")
    }
    
    func testBoldWithinItalicText() {
        let s = "Hello, _*world*_!"
        let text = smlBuilder.render(s)
        
        XCTAssertEqual(text, "Hello, <em><strong>world</strong></em>!")
    }
    
    func testItalicWithinBoldText() {
        let s = "Hello, *_world_*!"
        let text = smlBuilder.render(s)
        
        XCTAssertEqual(text, "Hello, <strong><em>world</em></strong>!")
    }
    
    func testUnterminatedBoldMarker() {
        let s = "Hello, *world!"
        let text = smlBuilder.render(s)
        
        XCTAssertEqual(text, "Hello, *world!")
    }
    
    func testUnterminatedItalicMarker() {
        let s = "Hello, _world!"
        let text = smlBuilder.render(s)
        
        XCTAssertEqual(text, "Hello, _world!")
    }
    
    func testOrderedList() {
        let s = "1. One\t 2. Two\t"
        let text = smlBuilder.render(s)
        
        XCTAssertEqual(text, "<ol><li>One</li><li>Two</li></ol>")
    }
    
    func testUnorderedList() {
        let s = "* One\t * Two\t"
        let text = smlBuilder.render(s)
        
        XCTAssertEqual(text, "<ul><li>One</li><li>Two</li></ul>")
    }
    
    func testUnorderedList2() {
        let s = "- One\t - Two\t"
        let text = smlBuilder.render(s)
        
        XCTAssertEqual(text, "<ul><li>One</li><li>Two</li></ul>")
    }
    
    func testMixedUnorderedList() {
        let s = "* One\t - Two\t * Three\t"
        let text = smlBuilder.render(s)
        
        XCTAssertEqual(text, "<ul><li>One</li><li>Two</li><li>Three</li></ul>")
    }
    
    func testMixedUnorderedList2() {
        let s = "- One\t * Two\t - Three\t"
        let text = smlBuilder.render(s)
        
        XCTAssertEqual(text, "<ul><li>One</li><li>Two</li><li>Three</li></ul>")
    }
}
