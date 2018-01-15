import UIKit

class CodableEample4ViewController: UIViewController {
    let jsonExample3 = """
{
    "Banana": {
        "points": 200,
        "description": "A banana grown in Ecuador."
    },
    "Orange": {
        "points": 100
    }
}
""".data(using: .utf8)!
    override func viewDidLoad() {
        super.viewDidLoad()
        decoding()
    }
    func decoding(){
        let decoder = JSONDecoder()
        do {
        let decodedStore = try decoder.decode(KiranaStore.self, from: jsonExample3)

            print("The store is selling the following products:")
            for product in decodedStore.products {
                print("\t\(product.name) (\(product.points) points)")
                if let description = product.description {
                    print("\t\t\(description)")
                }
            }
        } catch {
            print(Error.self)
        }


    }
}



struct KiranaStore {
    struct Product {
        let name: String
        let points: Int
        let description: String?
    }

    var products: [Product]

    init(products: [Product] = []) {
        self.products = products
    }
}
extension KiranaStore: Encodable {
    struct ProductKey: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        var intValue: Int? { return nil }
        init?(intValue: Int) { return nil }

        static let points = ProductKey(stringValue: "points")!
        static let description = ProductKey(stringValue: "description")!
    }


    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ProductKey.self)

        for product in products {
            // Any product's `name` can be used as a key name.
            let nameKey = ProductKey(stringValue: product.name)!
            var productContainer = container.nestedContainer(keyedBy: ProductKey.self, forKey: nameKey)

            // The rest of the keys use static names defined in `ProductKey`.
            try productContainer.encode(product.points, forKey: .points)
            try productContainer.encode(product.description, forKey: .description)
        }
    }
}
//
//var encoder = JSONEncoder()
//encoder.outputFormatting = .prettyPrinted
//
//let store = KiranaStore(products: [
//    .init(name: "Grapes", points: 230, description: "A mixture of red and green grapes."),
//    .init(name: "Lemons", points: 2300, description: "An extra sour lemon.")
//    ])
//
//print("The result of encoding a KiranaStore:")
//let encodedStore = try encoder.encode(store)
//print(String(data: encodedStore, encoding: .utf8)!)
//print()
extension KiranaStore: Decodable {
    public init(from decoder: Decoder) throws {
        var products = [Product]()
        let container = try decoder.container(keyedBy: ProductKey.self)
        for key in container.allKeys {
            // Note how the `key` in the loop above is used immediately to access a nested container.
            let productContainer = try container.nestedContainer(keyedBy: ProductKey.self, forKey: key)
            let points = try productContainer.decode(Int.self, forKey: .points)
            let description = try productContainer.decodeIfPresent(String.self, forKey: .description)

            // The key is used again here and completes the collapse of the nesting that existed in the JSON representation.
            let product = Product(name: key.stringValue, points: points, description: description)
            products.append(product)
        }

        self.init(products: products)
    }
}


