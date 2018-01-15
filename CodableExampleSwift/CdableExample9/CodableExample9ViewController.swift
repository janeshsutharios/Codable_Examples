//{
//    "status": 1,
//    "data": {
//        "code": 1,
//        "message": "Success",
//        "error": null,
//        "data": {

import UIKit
struct DeviceListModel: Codable {
    var dataMain: DataMain

    private enum CodingKeys: String, CodingKey {
        case dataMain = "data"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dataMain = try values.decode(DataMain.self, forKey: .dataMain)
    }
    struct DataMain: Codable {
        var dataSub: DeviceList
        private enum CodingKeys: String, CodingKey {
            case dataSub = "data"
        }
        struct DeviceList: Codable {
            struct Apps {
                let name: String
                let logoURL: [String]
                let downLoadLink: [String]
            }
            var apps: [Apps]
            init(apps: [Apps] = []) {
                self.apps = apps
            }

            struct AppsKey: CodingKey {
                var stringValue: String
                init?(stringValue: String) {
                    self.stringValue = stringValue
                }

                var intValue: Int? { return nil }
                init?(intValue: Int) { return nil }

                static let logoURL = AppsKey(stringValue: "logo_url")!
                static let downLoadLink = AppsKey(stringValue: "download_link")!
            }
            func encode(to encoder: Encoder) throws {
                var container = encoder.container(keyedBy: AppsKey.self)

                for product in apps {
                    let nameKey = AppsKey(stringValue: product.name)!
                    var productContainer = container.nestedContainer(keyedBy: AppsKey.self, forKey: nameKey)
                    try productContainer.encode(product.logoURL, forKey: .logoURL)
                    try productContainer.encode(product.downLoadLink, forKey: .downLoadLink)

                }
            }
            public init(from decoder: Decoder) throws {
                var appsObject = [Apps]()
                let container = try decoder.container(keyedBy: AppsKey.self)
                for key in container.allKeys {
                    var logoURLThis = [String]()
                    var downLoadLinkThis = [String]()

                    var nestedArrayContainer = try container.nestedUnkeyedContainer(forKey: key)
                    while !nestedArrayContainer.isAtEnd {
                        let currentObjectContainer = try nestedArrayContainer.nestedContainer(keyedBy: AppsKey.self)
                        logoURLThis.append(try currentObjectContainer.decode(String.self, forKey: .logoURL))
                        downLoadLinkThis.append(try currentObjectContainer.decode(String.self, forKey: .downLoadLink))
                    }

                    let product = Apps(name: key.stringValue, logoURL: logoURLThis, downLoadLink: downLoadLinkThis)
                    appsObject.append(product)
                }
                self.init(apps: appsObject)
            }

        }
    }
}
class CodableExample9ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let decoder = JSONDecoder()
        do {
            let decodedStore = try decoder.decode(DeviceListModel.self, from: Json.jsonExampleDevice)
            print("The store is selling the following products:")

            print("Apps count Is \(decodedStore.dataMain.dataSub.apps.count)")


            for product in (decodedStore.dataMain.dataSub.apps) {
                print("\t\(product.name) (\(product.logoURL) )")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

