import UIKit
///demo1


struct ProductsData: Codable {
    let name: String
    let points: Int
    let description: String?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        points = try values.decode(Int.self, forKey: .points)
        description = try values.decode(String.self, forKey: .description)
    }
}
class CodableExample3ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decodingFruitJson()
        decodingJson()



    }
    func decodingJson(){
        let jsonData = Json.jsonExample3
        let jsonDecoder = JSONDecoder()
        
        do {
            let users = try jsonDecoder.decode(ProductsData.self,
                                               from: jsonData)
            print(users)
            print(users.name)
        } catch {
            print(error)
        }
    }
    
    
}
////demo2

struct HomeStruct: Decodable {
    let routes: routes
    let apartments: apartments
}

struct apartments: Codable {
    var isParkingAvailable: Int
    var isWifiAvailable: Int
    var isPodium: Int

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isParkingAvailable = try values.decode(Int.self, forKey: .isParkingAvailable)
        isWifiAvailable = try values.decode(Int.self, forKey: .isWifiAvailable)
        isPodium = try values.decode(Int.self, forKey: .isPodium)
    }
}

struct routes: Codable {
    var byRoad: Int
    var byAir: Int
    var options: Options
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        byRoad = try values.decode(Int.self, forKey: .byRoad)
//        byAir = try values.decode(Int.self, forKey: .byAir)
//    }
}

struct Options: Codable {
    var isByChop: Int
    private enum CodingKeys: String, CodingKey {
        case isByChop = "isByChopp"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isByChop = try values.decode(Int.self, forKey: .isByChop)
    }
}


extension CodableExample3ViewController {
    
    func decodingFruitJson(){

        
        let jsonData = Json.jsonExample2
        let jsonDecoder = JSONDecoder()

////////////////////////////

        var json: Any?
        do {
            json = try JSONSerialization.jsonObject(with: jsonData)
        } catch {
            print(error)
        }
        if let item = json as? [String: Any] {
            print(item.count)
                return
        }

        //////////////////

        do {
            let modelHome = try jsonDecoder.decode(HomeStruct.self,
                                                   from: jsonData)

            print(modelHome.apartments.isWifiAvailable)
            print(modelHome.routes.byRoad)
            print(modelHome.routes.byAir)
            print(modelHome.routes.options.isByChop)

        } catch {
            print(error)
        }
    }
}
