import UIKit
//Elegant solution
//{
//    "id": 1,
//    "user": {
//        "user_name": "Tester",
//        "real_info": {
//            "full_name":"Jon Doe"
//        }
//    },
//    "reviews_count": [
//    {
//    "count": 4
//    }
//    ]
//}
//"""
struct RawServerResponse {
    
    enum RootKeys: String, CodingKey {
        case id, user, reviewCount = "reviews_count"
    }
    
    enum UserKeys: String, CodingKey {
        case userName = "user_name", realInfo = "real_info"
    }
    
    enum RealInfoKeys: String, CodingKey {
        case fullName = "full_name"
    }
    
    enum ReviewCountKeys: String, CodingKey {
        case count
    }
    
    let id: Int
    let userName: String
    let fullName: String
    let reviewCount: Int
    
}
extension RawServerResponse: Decodable {
    
    init(from decoder: Decoder) throws {
        // id
        let container = try decoder.container(keyedBy: RootKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        
        // userName
        let userContainer = try container.nestedContainer(keyedBy: UserKeys.self, forKey: .user)
        userName = try userContainer.decode(String.self, forKey: .userName)
        
        // fullName
        let realInfoKeysContainer = try userContainer.nestedContainer(keyedBy: RealInfoKeys.self, forKey: .realInfo)
        fullName = try realInfoKeysContainer.decode(String.self, forKey: .fullName)
        
        // reviewCount
        var reviewUnkeyedContainer = try container.nestedUnkeyedContainer(forKey: .reviewCount)
        var reviewCountArray = [Int]()
        while !reviewUnkeyedContainer.isAtEnd {
            let reviewCountContainer = try reviewUnkeyedContainer.nestedContainer(keyedBy: ReviewCountKeys.self)
            reviewCountArray.append(try reviewCountContainer.decode(Int.self, forKey: .count))
        }
        guard let reviewCount = reviewCountArray.first else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: container.codingPath + [RootKeys.reviewCount], debugDescription: "reviews_count cannot be empty"))
        }
        self.reviewCount = reviewCount
    }
    
}
class CodableExample8ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let jsonString = """
{
    "id": 1,
    "user": {
        "user_name": "Tester",
        "real_info": {
            "full_name":"Jon Doe"
        }
    },
    "reviews_count": [
    {
    "count": 4
    }
    ]
}
"""
        
        let jsonData = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let serverResponse = try! decoder.decode(RawServerResponse.self, from: jsonData)
        dump(serverResponse)
        // Do any additional setup after loading the view.
    }
}
