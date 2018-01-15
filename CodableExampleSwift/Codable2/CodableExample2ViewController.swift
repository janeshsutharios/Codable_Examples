import UIKit
class CodableExample2ViewController: UIViewController {

    func decodingJson(){
        let sampleDataAddress = "https://jsonplaceholder.typicode.com/users"
        let url = URL(string: sampleDataAddress)!
        let jsonData = try! Data(contentsOf: url)
        let jsonDecoder = JSONDecoder()

        do {
            let users = try jsonDecoder.decode([User].self,
                                               from: jsonData)

            print("array count is \(users.count) & lat of first is \(String(describing: users.first?.address.geo.lat))")
            encodingToJson(users: users)//dump(users.first)
           } catch {
            print(error)
        }
    }
    func encodingToJson(users:[User]){
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        if let backToJson = try? jsonEncoder.encode(users) {
            if let jsonString = String(data: backToJson, encoding: .utf8) {
                print(jsonString)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        decodingJson()
    }
}

struct User: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String
    let address: Address
    let company: Company

    struct Address: Codable {
        let street: String
        let suite: String
        let city: String
        let zipcode: String
        let geo: Coordinates
        struct Coordinates: Codable {
            let lat: Double
            let lng: Double
            init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                let latString = try values.decode(String.self, forKey: .lat)
                let lngString = try values.decode(String.self, forKey: .lng)
                lat = Double(latString) ?? 0
                lng = Double(lngString) ?? 0
            }
        }
    }
    struct Company: Codable {
        let name: String
        let catchPhrase: String
        let bs: String
    }
}
