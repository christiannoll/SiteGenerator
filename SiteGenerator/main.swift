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
let indexPage = IndexPage(index)
writer.writeIndexPage(indexPage.render())

let tagsFactory = TagsFactory()
let tags = tagsFactory.createTags(posts)
let tagsPage = TagsPage(tags)
writer.writeTagsPage(tagsPage.render())

let tagItems = tags.tagItems
for tagItem: TagItem in tagItems {
    let page = TagItemPage(tagItem)
    writer.writeTagItemPage(tagItem, page.render())
}

let impressumPage = ImpressumPage()
writer.writeImpressumPage(impressumPage.render())

/*let s = "text1 [title](url) text2"
let elements = MarkdownParser.parse(text: s)

let smlBuilder = SmlBuilder()
print(smlBuilder.parse(elements))*/


