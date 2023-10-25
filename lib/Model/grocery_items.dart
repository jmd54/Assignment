// To parse this JSON data, do
//
//     final storeProduct = storeProductFromJson(jsonString);

import 'dart:convert';

StoreProduct storeProductFromJson(String str) => StoreProduct.fromJson(json.decode(str));

String storeProductToJson(StoreProduct data) => json.encode(data.toJson());

class StoreProduct {
    Store1 store1;

    StoreProduct({
        required this.store1,
    });

    factory StoreProduct.fromJson(Map<String, dynamic> json) => StoreProduct(
        store1: Store1.fromJson(json["store2"]),
    );

    Map<String, dynamic> toJson() => {
        "store1": store1.toJson(),
    };
}

class Store1 {
    int id;
    String name;
    String location;
    Contact contact;
    List<GroceryItem> groceryItems;

    Store1({
        required this.id,
        required this.name,
        required this.location,
        required this.contact,
        required this.groceryItems,
    });

    factory Store1.fromJson(Map<String, dynamic> json) => Store1(
        id: json["id"],
        name: json["name"],
        location: json["location"],
        contact: Contact.fromJson(json["contact"]),
        groceryItems: List<GroceryItem>.from(json["groceryItems"].map((x) => GroceryItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "location": location,
        "contact": contact.toJson(),
        "groceryItems": List<dynamic>.from(groceryItems.map((x) => x.toJson())),
    };
}

class Contact {
    String phone;
    String email;

    Contact({
        required this.phone,
        required this.email,
    });

    factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        phone: json["phone"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "phone": phone,
        "email": email,
    };
}

class GroceryItem {
    String name;
    double price;
    int discountPercentage;
    String image;

    GroceryItem({
        required this.name,
        required this.price,
        required this.discountPercentage,
        required this.image,
    });

    factory GroceryItem.fromJson(Map<String, dynamic> json) => GroceryItem(
        name: json["name"],
        price: json["price"]?.toDouble(),
        discountPercentage: json["discountPercentage"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "discountPercentage": discountPercentage,
        "image": image,
    };
}
