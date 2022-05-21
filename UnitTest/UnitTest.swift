import XCTest

class UnitTest: XCTestCase {

    var smlBuilder: SmlBuilder!
    
    override func setUp() {
        smlBuilder = SmlBuilder()
    }

    override func tearDown() {
    }
    
    func testUnorderedListWithUrl() {
        let s = "* One\t * [Two](url)\t"
        let text = smlBuilder.render(s)
        
        XCTAssertEqual(text, "<ul><li>One</li><li><a href=\"url\">Two</a></li></ul>")
    }
    
    func testNotUnorderedListWithThreeAsterisks() {
        let s = "* * *"
        let text = smlBuilder.render(s)
        
        XCTAssertEqual(text, "* * *")
    }
    
    func testOrderedListWithUrl() {
        let s = "1. One\t 2. [Two](url)\t"
        let text = smlBuilder.render(s)
        
        XCTAssertEqual(text, "<ol><li>One</li><li><a href=\"url\">Two</a></li></ol>")
    }
    
    func testOrderedListWithUrl2() {
        let s = "1. One\t 2. [Two](url)"
        let text = smlBuilder.render(s)
        
        XCTAssertEqual(text, "<ol><li>One</li><li><a href=\"url\">Two</a></li></ol>")
    }
    
    func testLinkWithParenthesis() {
        let s = "text1 [title](url_(part)) text2"
        let text = smlBuilder.render(s)
            
        XCTAssertEqual(text, "text1 <a href=\"url_(part)\">title</a> text2")
    }
    
    func testLinkWithUrlAndDelimitersAndPoint() {
        let s = "text1 [title](url_1._2) text2"
        let text = smlBuilder.render(s)
        
        XCTAssertEqual(text, "text1 <a href=\"url_1._2\">title</a> text2")
    }
    
    func testLinkWithUrlAndDelimitersAndPoints() {
        let s = "text1 [title](url_.1._2) text2"
        let text = smlBuilder.render(s)
        
        XCTAssertEqual(text, "text1 <a href=\"url_.1._2\">title</a> text2")
    }

    func testLinkWithUrl() {
        let s = "text1 [title](url) text2"
        let text = smlBuilder.render(s)
        
        XCTAssertEqual(text, "text1 <a href=\"url\">title</a> text2")
    }
    
    func testParenthesisAndLinkWithUrl() {
        let s = "(tex)t1 [title](url) text2"
        let text = smlBuilder.render(s)
        
        XCTAssertEqual(text, "(tex)t1 <a href=\"url\">title</a> text2")
    }
    
    func testLinkWithUrlAndParenthesis() {
        let s = "text1 [title](url) t(ext2)"
        let text = smlBuilder.render(s)
        
        XCTAssertEqual(text, "text1 <a href=\"url\">title</a> t(ext2)")
    }
    
    func testLinkWithinParenthesis() {
        let s = "([title](url))"
        let text = smlBuilder.render(s)
        
        XCTAssertEqual(text, "(<a href=\"url\">title</a>)")
    }
    
    func testLinkWithinParenthesisWithPreAndPost() {
        let s = "(pre [title](url) post)"
        let text = smlBuilder.render(s)
        
        XCTAssertEqual(text, "(pre <a href=\"url\">title</a> post)")
    }
    
    func testLinkWithinCode() {
        let s = "`[title](url)`"
        let text = smlBuilder.render(s)
        
        XCTAssertEqual(text, "<code><a href=\"url\">title</a></code>")
    }
    
    func testParenthesis() {
        let s = "text1 (text2)"
        let text = smlBuilder.render(s)
        
        XCTAssertEqual(text, "text1 (text2)")
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
    
    func testCodeText() {
        let s = "Das ist `source code` in python"
        let text = smlBuilder.render(s)
        
        XCTAssertEqual(text, "Das ist <code>source code</code> in python")
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
        let s = "+ One\t * Two\t - Three\t"
        let text = smlBuilder.render(s)
        
        XCTAssertEqual(text, "<ul><li>One</li><li>Two</li><li>Three</li></ul>")
    }
    
    func testCodeElement() {
        let s = "`11 22 33 haha`"
        let text = smlBuilder.render(s)
        
        XCTAssertEqual(text, "<code>11 22 33 haha</code>")
    }
    
    func testMultilineCodeElement() {
        let s = "`wiederhole\t     falls n gerade:  n := n / 2\t    sonst:           n := (3 * n) + 1\tbis n = 1`"
        let text = smlBuilder.render(s)
        
        XCTAssertEqual(text, "<code>wiederhole<br>     falls n gerade:  n := n / 2<br>    sonst:           n := (3 * n) + 1<br>bis n = 1</code>")
    }
    
    func testNewline() {
        let s = "first line \\ second line"
        let text = smlBuilder.render(s)
        
        XCTAssertEqual(text, "first line <br> second line")
    }
    
    func testNoNewline() {
        let s = "first part \n second part"
        let text = smlBuilder.render(s)
        
        XCTAssertEqual(text, s)
    }
}
