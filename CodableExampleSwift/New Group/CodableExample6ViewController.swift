import UIKit
class CodableExample6ViewController: UIViewController {
    let jsonExample2 = """
[
    {
        "name": "Home Town Market",
        "aisles": [
            {
                "name": "Produce",
                "shelves": [
                    {
                        "name": "Discount Produce",
                        "product": {
                            "name": "Banana",
                            "points": 200,
                            "description": "A banana that's perfectly ripe."
                        }
                    }
                ]
            }
        ]
    },
    {
        "name": "Big City Market",
        "aisles": [
            {
                "name": "Sale Aisle",
                "shelves": [
                    {
                        "name": "Seasonal Sale",
                        "product": {
                            "name": "Chestnuts",
                            "points": 700,
                            "description": "Chestnuts that were roasted over an open fire."
                        }
                    },
                    {
                        "name": "Last Season's Clearance",
                        "product": {
                            "name": "Pumpkin Seeds",
                            "points": 400,
                            "description": "Seeds harvested from a pumpkin."
                        }
                    }
                ]
            }
        ]
    }
]
""".data(using: .utf8)!

    override func viewDidLoad() {
        super.viewDidLoad()
        decodeJson()
        // Do any additional setup after loading the view.
    }
    func decodeJson() {
        let decoderG = JSONDecoder()
        do {
            let serviceStores = try decoderG.decode([GroceryStoreService].self, from: jsonExample2)
            let stores = serviceStores.map { Shop(from: $0) }
            for store in stores {
                print("\(store.name) is selling:")
                for product in store.products {
                    print("\t\(product.name) (\(product.points) points)")
                    if let description = product.description {
                        print("\t\t\(description)")
                    }
                }
            }
        } catch {
            print(Error.self)
        }
    }
}
struct GroceryStoreService: Decodable {
    let name: String
    let aisles: [Aisle]

    struct Aisle: Decodable {
        let name: String
        let shelves: [Shelf]

        struct Shelf: Decodable {
            let name: String
            let product: Shop.Product
        }
    }
}
struct Shop {
    init(from service: GroceryStoreService) {
        name = service.name
        products = []

        for aisle in service.aisles {
            for shelf in aisle.shelves {
                products.append(shelf.product)
            }
        }
    }
    var name: String
    var products: [Product]
    struct Product: Codable {
        var name: String
        var points: Int
        var description: String?
    }

}
