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
        makeHTML(for: index, on: context.site) {
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
                 .class("responsive sidebar"),
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
    func makeHTML<T: Website>(for location: Location, on site: T, withBody body: () -> Node<HTML.BodyContext>) -> HTML {
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
                            .a(.href("/"), .img(.src("/images/icon.png")))
                        ),
                        .p(.class("app-name"), .text(site.name)),

                        .div(
                            .class("intro"),
                            .h2(.text(site.description))
                        ),
                        .a(forAppStore: site.appStoreLink)
                    ),
                    body()
                ),
                .footer(for: location, on: site)
            )
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
            .p(
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
            return .div(
                "Soon on the  App Store"
            )
        }
        return .a(
            .class("download"),
            .href(link),
            "Download on the  App Store"
        )
    }
}
