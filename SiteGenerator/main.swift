import Foundation

let contentParser = ContentParser()
let posts = contentParser.parse()

let writer = PageWriter()

let homePage = HomePage(posts)
writer.writeHomePage(homePage.render())

for post: Item in posts {
    let page = PostPage(post)
    writer.writePostPage(post, page.render())
}

let archiveFactory = ArchiveFactory()
let archive = archiveFactory.createArchive(posts)
let archivePage = ArchivePage(archive);
writer.writeArchivePage(archivePage.render())

let archiveYears = archive.years
for year: ArchiveYear in archiveYears {
    for month: ArchiveMonth in year.months {
        let page = ArchiveMonthPage(month)
        writer.writeArchiveMonthPage(month, page.render())
    }
}

let indexFactory = IndexFactory()
let index = indexFactory.createIndex(posts)


/*let s = "text1 [title](url) text2"
let elements = MarkdownParser.parse(text: s)

let smlBuilder = SmlBuilder()
print(smlBuilder.parse(elements))*/

