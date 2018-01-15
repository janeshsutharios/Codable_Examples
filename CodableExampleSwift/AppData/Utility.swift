
import Foundation



struct Json {
    //    static let jsonExample1 = """
    //    {
    //        "Banana": [{
    //            "points": 200,
    //            "description": "A banana grown in Ecuador."
    //        },
    //        "Orange": {
    //            "points": 100
    //        }
    //
    //    }
    //    """.data(using: .utf8)!


    static let jsonExampleDevice = """
        {
        "status": 1,
        "data": {
        "code": 1,
        "message": "Success",
        "error": null,
        "data": {
        "recommended": [
                    {
                    "logo_url": "/assets/appicons/nokia-icon.png",
                    "name": "Nokia",
                    "download_link": "https://Nokia/"
                   },
                   {
                    "logo_url": "/assets/appicons/Apple-icon.png",
                    "name": "AppleHealth",
                    "download_link": "https://Apple"
                   }
                      ],
        "Others": [
                    {
                    "logo_url": "/assets/appicons/Other1.png",
                    "name": "Nokia",
                    "download_link": "https://other/1"
                   },
                   {
                    "logo_url": "/assets/appicons/other-icon2.png",
                    "name": "AppleHealth",
                    "download_link": "https://Other2"
                   }
                    ]
                }
            }
        }
        """.data(using: .utf8)!

    static let jsonExample1 = """
    {
        "Banana": [
                    {
                        "points": 200
                    },
                    {
                        "points": 100
                    }
                 ]
    }
    """.data(using: .utf8)!


    static let jsonExample2 = """
    {
        "routes": {
        "options": {
            "isByChopp": 789
            },

            "byRoad": 123,
            "byAir": 456
        },
        "apartments": {
            "isParkingAvailable": 1,
            "isWifiAvailable": 1,
            "isPodium": 0
        }
    }
    """.data(using: .utf8)!



    static let jsonExample3 = """
    {
            "name": "200",
            "points": 200,
            "description": "A banana grown in Ecuador."
    }
    """.data(using: .utf8)!
}
