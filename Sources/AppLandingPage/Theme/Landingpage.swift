import Publish
import Plot
import Foundation

public extension Theme {
    static var landingpage: Self {
        Theme(
            htmlFactory: LandingPageHTMLFactory()
        )
    }
}

private struct LandingPageHTMLFactory<Site: Website>: HTMLFactory {
    func makeIndexHTML(for index: Index,
                       context: PublishingContext<Site>) throws -> HTML {
        makeIndexHTML(for: index, on: context.site) {
            .div(
                .class("responsive sidebar"),
                .div(
                    .img(.src("/images/iphone.png"))
                )
            )
        }
    }
    
    func makePageHTML(for page: Page,
                      context: PublishingContext<Site>) throws -> HTML {
        makeHTML(for: page, on: context.site) {
             .div(
                 .div(.contentBody(page.body))
             )
        }
    }

    func makeSectionHTML(for section: Section<Site>,
                         context: PublishingContext<Site>) throws -> HTML {
        makeHTML(for: section, on: context.site) {
            .div(.contentBody(section.body))
        }
    }

    func makeItemHTML(for item: Item<Site>,
                      context: PublishingContext<Site>) throws -> HTML {
        makeHTML(for: item, on: context.site) {
            .div(.contentBody(item.body))
        }
    }

    func makeTagListHTML(for page: TagListPage,
                         context: PublishingContext<Site>) throws -> HTML? {
        nil
    }

    func makeTagDetailsHTML(for page: TagDetailsPage,
                            context: PublishingContext<Site>) throws -> HTML? {
        nil
    }
}

private extension LandingPageHTMLFactory {
    func makeIndexHTML<T: Website>(for location: Location, on site: T, withBody body: () -> Node<HTML.BodyContext>) -> HTML {
        HTML(
            .lang(site.language),
            .head(for: location, on: site),
            .body(
                .header(
                    .class("container"),
                    .div(
                        .class("responsive intro-container"),
                        .div(
                            .class("app-icon"),
                            .a(.href("/"))
                        ),
                        .p(.class("app-name"), .text(site.name)),

                        .div(
                            .class("intro"),
                            .h2(.text(site.description))
                        ),
                        .a(forAppStore: site.appStoreLink),
                        .a(forTestFlight: site.testflightLink)
                    ),
                    body()
                ),
                .footer(for: location, on: site)
            )
        )
    }
    
    func makeHTML<T: Website>(for location: Location, on site: T, withBody body: () -> Node<HTML.BodyContext>) -> HTML {
        HTML(
            .lang(site.language),
            .head(for: location, on: site),
            .body(
                .header(
                    .class("container"),
                    body()
                ),
                .footer(for: location, on: site)
            )
        )
    }
}

private extension Node where Context == HTML.DocumentContext {
    static func head<T: Website>(
    for location: Location,
    on site: T) -> Node {
        var title = location.title

        let stylesheetPaths = [
            "/css/styles.css"
        ]
        
        if title.isEmpty {
            title = site.name
        } else {
            title.append(" | " + site.name)
        }

        var description = location.description

        if description.isEmpty {
            description = site.description
        }

        return .head(
            .encoding(.utf8),
            .siteName(site.name),
            .url(site.url(for: location)),
            .title(title),
            .description(description),
            .twitterCardType(location.imagePath == nil ? .summary : .summaryLargeImage),
            .forEach(stylesheetPaths, { .stylesheet($0) }),
            .viewport(.accordingToDevice),
            .unwrap(site.favicon, { .favicon($0) }),
            .unwrap(Path.defaultForRSSFeed, { path in
                let title = "Subscribe to \(site.name)"
                return .rssFeedLink(path.absoluteString, title: title)
            }),
            .unwrap(location.imagePath ?? site.imagePath, { path in
                let url = site.url(for: path)
                return .socialImageLink(url)
            }),
            .unwrap(site.plausibleSiteName, { siteName in
                .script(.attribute(named: "defer"), .attribute(named: "data-domain", value: siteName), .src("https://plausible.io/js/plausible.js"))
            })
        )
    }
}

private extension Node where Context == HTML.BodyContext {
    static func footer<T: Website>(
    for location: Location,
    on site: T) -> Node {
        .footer(
            .class("container footer"),
            .div(.class("separator")),
            .div(
                .class("responsive credit"),
                "Made with ♥ by ",
                .a(
                    .href(site.credits.url),
                    .text(site.credits.name)
                )
            ),
            .div(
                .class("responsive links"),
                .forEach(site.footerLinks, {
                    .a(.href($0.url), .text($0.name))
                })
            )
        )
    }
    
    static func a(forAppStore link: AppStoreLink?) -> Node {
        guard let link = link else {
            return .empty
        }
        return .a(
            .img(.src("/images/appstore.svg")),
            .href(link)
        )
    }
    
    static func a(forTestFlight link: AppStoreLink?) -> Node {
        guard let link = link else {
            return .empty
        }
        return .div(
            .a(.href(link), .text("Get latest beta from TestFlight."))
        )
    }
}
