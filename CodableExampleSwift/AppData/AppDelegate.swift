//
//  AppDelegate.swift
//  CodableExampleSwift
//
//  Created by AdityaBirlaHealth Common on 03/11/17.
//  Copyright © 2017 Janesh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var timer: Timer?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("clicked...")
    }
   

}
/*
 import UIKit
 struct GroceryStore {
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
 extension GroceryStore: Encodable {
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

 extension GroceryStore: Decodable {
 public init(from decoder: Decoder) throws {
 var products = [Product]()
 let container = try decoder.container(keyedBy: ProductKey.self)
 for key in container.allKeys {
 print("ProductKey.self is-- \(ProductKey.self) & key is-- \(key)")
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
 class CodableExample1ViewController: UIViewController {
 override func viewDidLoad() {
 super.viewDidLoad()
 let decoder = JSONDecoder()
 do {
 let decodedStore = try decoder.decode(GroceryStore.self, from: Json.jsonExample1)
 print("The store is selling the following products:")

 print("decodedStore.count \(decodedStore)  & productCount Is \(decodedStore.products.count)")
 for product in decodedStore.products {
 print("\t\(product.name) (\(product.points) points)")
 if let description = product.description {
 print("\t\t\(description)")
 }
 }
 } catch {
 print(error.localizedDescription)
 }
 }
 }

 */
