import UIKit
struct GroceryStore {
    struct Product {
        let name: String
        let points: Int
        let totalPointsArray: [Int]
        

    }
    var products: [Product]
    init(products: [Product] = []) {
        self.products = products
    }
}
extension GroceryStore: Encodable {
    struct ProductKey: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        var intValue: Int? { return nil }
        init?(intValue: Int) { return nil }

        static let points = ProductKey(stringValue: "points")!

    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ProductKey.self)

        for product in products {
            let nameKey = ProductKey(stringValue: product.name)!
            var productContainer = container.nestedContainer(keyedBy: ProductKey.self, forKey: nameKey)
            try productContainer.encode(product.points, forKey: .points)
        }
    }
}

extension GroceryStore: Decodable {
    public init(from decoder: Decoder) throws {
        var products = [Product]()
        var dataPoints = [Int]()
        let container = try decoder.container(keyedBy: ProductKey.self)
        for key in container.allKeys {
           // print("ProductKey.self is-- \(ProductKey.self) & key is-- \(key)")
            enum ReviewCountKeys: String, CodingKey {
                case points
            }
            // reviewCount
            var reviewUnkeyedContainer = try container.nestedUnkeyedContainer(forKey: key)
            while !reviewUnkeyedContainer.isAtEnd {
                let reviewCountContainer = try reviewUnkeyedContainer.nestedContainer(keyedBy: ReviewCountKeys.self)
                let pointsDecoded = try reviewCountContainer.decode(Int.self, forKey: .points)
                dataPoints.append(pointsDecoded)
            }
            let product = Product(name: key.stringValue, points: 0, totalPointsArray: dataPoints)
            products.append(product)
        }

        self.init(products: products)
    }
}
class CodableExample1ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let decoder = JSONDecoder()
        do {
            let decodedStore = try decoder.decode(GroceryStore.self, from: Json.jsonExample1)
            print("The store is selling the following products:")
            
            print("productCount Is \(decodedStore.products.count)")
            for product in decodedStore.products {
                print("\t\(product.name) (\(product.totalPointsArray) )")

            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
