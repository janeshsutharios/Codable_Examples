import UIKit
//Set JSON key values for fields in our custom type
//    private enum CodingKeys: String, CodingKey {
//        case id //Leave it blank because id matches with json Id
//        case name = "name_Of_person"
//        case email = "emailId"
//    }

struct Theme : Codable {
    var themes : [Question]
}
struct Question : Codable {
    var answer:Int
    var question: Int
    var title: String
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        answer = try values.decode(Int.self, forKey: .answer)
//        question = try values.decode(Int.self, forKey: .question)
//        title = try values.decode(String.self, forKey: .title)
//    }
}


class CodableExample7ViewController: UIViewController {
    let jsonExample = """
{
  "themes": [
    {
      "answer": 1,
      "question": 44438222,
      "title": "How many letters are in the alphabet?"
    },
    {
      "answer": 0,
      "question": 44438489,
      "title": "This is a random question"
    }
  ]
 }
""".data(using: .utf8)!

    override func viewDidLoad() {
        super.viewDidLoad()
        //Decode struct using JSONDecoder
        let jsonDecoder = JSONDecoder()
        do {
            let modelResult = try jsonDecoder.decode(Theme.self,from: jsonExample)
            for value in modelResult.themes {
                print("objects -- \(value.title)  \(value.question)       \(value.answer)")
            }
        } catch {
            print(error)
        }
    }
}
