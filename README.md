
# URLToolbox

A lightweight Swift package that provides non-optional URL string intializers,
and URL pattern matching, mainly for parsing deep link URLs.

## Features

- ✅ **Non-Optional `URL` Initialization**
  - Crash or throw immediately on invalid strings, instead of returning `nil`.
- 🔍 **URL Pattern Matching**
  - Define URL patterns for parsing e.g. deep link URLs.

## License

See the LICENSE file for licensing information.

## Example

```swift
enum DeepLinkID {
    case cast
    case movieGallery
}

let matcher = URLMatcher(patterns: [

    // "moviedb://*@*:*/movies/:movieID:/gallery?page=:pageID:"
    URLMatchPattern(
        id: DeepLinkID.movieGallery,
        scheme: "moviedb",
        path: ["movies", .int("movieID"), "gallery"],
        query: [
            ("page", .string("pageID"))
        ]
    ),

    // "moviedb://*@*:*/cast"
    URLMatchPattern(
        id: DeepLinkID.cast,
        scheme: "moviedb",
        path: ["cast"]
    )
])

let movieGalleryURL = URL(string: "moviedb://host/movies/123/gallery?page=4")!

let match = matcher.matchURL(movieGalleryURL)

if let match {

    switch match.id.switchable {
    case DeepLinkID.movieGallery:
        print("This is the movie gallery")
    case DeepLinkID.cast:
        print("This is the cast")
    }

    dump(match.parameters)
    dump(match.id)
    dump(match["movieID"])
    dump(match["pageID"])
    dump(match.banana)
    dump(match.movieID as? Int)
}
```
