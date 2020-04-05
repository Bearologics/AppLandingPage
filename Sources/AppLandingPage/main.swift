import Foundation
import Publish
import Plot

typealias Link = (name: String, url: String)
typealias AppStoreLink = String

// This type acts as the configuration for your website.
struct AppLandingPage: Website {
    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case index
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://app-landingpage-demo.netlify.com")!
    var name = "Fantasy App"
    var description = "A project I've been working on (in my dreams) for ages, soon available on iOS, iPadOS, macOS and also watchOS! Oh did I forget to mention tvOS?"
    var language: Language { .english }
    var imagePath: Path? { nil }
}

extension Website {
    var appStoreLink: AppStoreLink? {
        nil //"https://itunes.apple.com/xyz"
    }

    var credits: Link {
        ("Some Developer(s)", "https://")
    }
    
    var footerLinks: [Link] {
        [(name: "Home", url: "/"),
        (name: "Support", url: "mailto:"),
        (name: "About", url: "/about")]
    }
}

// This will generate your website using the built-in Foundation theme:
try AppLandingPage().publish(withTheme: .landingpage)

