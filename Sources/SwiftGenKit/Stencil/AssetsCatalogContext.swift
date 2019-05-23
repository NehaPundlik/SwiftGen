//
// SwiftGenKit
// Copyright © 2019 SwiftGen
// MIT Licence
//

import Foundation

//
// See the documentation file for a full description of this context's structure:
// Documentation/SwiftGenKit Contexts/Assets.md
//

extension AssetsCatalog.Parser {
  public func stencilContext() -> [String: Any] {
    let catalogs = self.catalogs
      .sorted { lhs, rhs in lhs.name < rhs.name }
      .map { catalog -> [String: Any] in
        [
          "name": catalog.name,
          "assets": structure(entries: catalog.entries)
        ]
      }

    return [
      "catalogs": catalogs
    ]
  }

  private func structure(entries: [AssetsCatalog.Entry]) -> [[String: Any]] {
    // swiftlint:disable:next closure_body_length
    return entries.map { entry in
      switch entry {
      case .color(let entryInfo):
        return [
          "type": "color",
          "name": entryInfo.name,
          "value": entryInfo.value ?? ""
        ]
      case .data(let entryInfo):
        return [
          "type": "data",
          "name": entryInfo.name,
          "value": entryInfo.value ?? ""
        ]
      case .group(let entryInfo, let isNamespaced, let items):
        return [
          "type": "group",
          "isNamespaced": "\(isNamespaced)",
          "name": entryInfo.name,
          "items": structure(entries: items)
        ]
      case .image(let entryInfo):
        return [
          "type": "image",
          "name": entryInfo.name,
          "value": entryInfo.value ?? ""
        ]
      }
    }
  }
}
