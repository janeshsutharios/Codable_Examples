import UIKit
class CodableExample5ViewController: UIViewController {
    //Abbreviated OpenAPI product response for example purposes
    let jsonData = """
{
    "paging": {
    "total": 8,
    "offset": 0,
    "limit": 40,
    "returned": 8
    },
    "beverages": [{
        "productId": "bb363cef-be7f-460c-86e6-07d866f624d0",
        "productType": "Beverage",
        "productNumber": 2122238,
        "name": "Unicorn Frappuccino®",
        "descriptions": {
            "short": null,
            "medium": "Great Drink!",
            "long": null
        },
        "countryCode": "CA",
        "locale": "en-CA",
        "displayOrder": 0,
        "dateModified": "2017-03-15T23:58:05.2970000Z"
    }]
}
""".data(using: .utf8)
    override func viewDidLoad() {
        super.viewDidLoad()
        jsonDecoding()
    }
    func jsonDecoding() {
        var productResponse: ProductResponse?
        if let data = jsonData {
            productResponse = try? JSONDecoder().decode(ProductResponse.self, from: data)
        }

        let paging = productResponse?.paging
        assert(paging?.total == 8)
        assert(paging?.offset == 0)
        assert(paging?.limit == 40)
        assert(paging?.returned == 8)

        assert(productResponse?.beverages.count == 1)

        let beverage = productResponse?.beverages[0]
        assert(beverage?.id == "bb363cef-be7f-460c-86e6-07d866f624d0")
        assert(beverage?.type == "Beverage")
        assert(beverage?.number == 2122238)
        assert(beverage?.name == "Unicorn Frappuccino®")
        assert(beverage?.description == "Great Drink!")
        assert(beverage?.country == "CA")
        assert(beverage?.locale == "en-CA")
        assert(beverage?.orderPrecedence == 0)


        ////Codeble  new

    }
}


struct ProductResponse: Decodable {
    let paging: Paging
    let beverages: [Beverage]
}

struct Paging: Decodable {
    let total: Int
    let offset: Int
    let limit: Int
    let returned: Int
}

struct Beverage: Codable {
    let id: String
    let type: String
    let number: Int
    let name: String
    let description: String
    let country: String
    let locale: String
    let orderPrecedence: Int
    let modified: Date?

    //Set JSON key values for fields in our custom type
    private enum CodingKeys: String, CodingKey {
        case id = "productId"
        case type = "productType"
        case number = "productNumber"
        case name
        case description = "descriptions"
        case country = "countryCode"
        case locale
        case orderPrecedence = "displayOrder"
        case modified = "dateModified"
    }

    private enum DescriptionCodingKeys: String, CodingKey {
        case short
        case medium
        case long
    }
}

//Custom Decoder
//Decodes modified date since app logic may depend on it
//Associates description with the medium description in the description object
extension Beverage {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        type = try values.decode(String.self, forKey: .type)
        number = try values.decode(Int.self, forKey: .number)
        name = try values.decode(String.self, forKey: .name)

        /* Assign Description from an inner nested container, Ex: medium description */
        let nestedDescription = try values.nestedContainer(keyedBy: DescriptionCodingKeys.self, forKey: .description)
        description = try nestedDescription.decode(String.self, forKey: .medium)

        country = try values.decode(String.self, forKey: .country)
        locale = try values.decode(String.self, forKey: .locale)
        orderPrecedence = try values.decode(Int.self, forKey: .orderPrecedence)

        let dateString = try values.decode(String.self, forKey: .modified)
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withColonSeparatorInTime, .withDashSeparatorInDate, .withFullDate, .withTime]
        modified = formatter.date(from: dateString)
    }
}





/**Encoding
 var beverageDictionary: Data!
 if let productResponse = productResponse {
 let encoder = JSONEncoder()
 encoder.outputFormatting = .prettyPrinted
 encoder.dateEncodingStrategy = .iso8601

 beverageDictionary = try? encoder.encode(productResponse.beverages[0])
 }

 print("\nBeverage JSON:\n\n\(String(data: beverageDictionary, encoding: .utf8)!)")

 Encodable --
 //Custom Encoder - Omits modified date since that is a backend value
 extension Beverage {
 func encode(to encoder: Encoder) throws {
 var container = encoder.container(keyedBy: CodingKeys.self)
 try container.encode(id, forKey: .id)
 try container.encode(type, forKey: .type)
 try container.encode(number, forKey: .number)
 try container.encode(name, forKey: .name)

 var descriptionContainer = container.nestedContainer(keyedBy: DescriptionCodingKeys.self, forKey: .description)
 try descriptionContainer.encode(description, forKey: .medium)

 try container.encode(country, forKey: .country)
 try container.encode(locale, forKey: .locale)
 try container.encode(orderPrecedence, forKey: .orderPrecedence)
 }
 }
 Encoding end**/

