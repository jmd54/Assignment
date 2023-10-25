// To parse this JSON data, do
//
//     final store = storeFromJson(jsonString);

import 'dart:convert';

Store storeFromJson(String str) => Store.fromJson(json.decode(str));

String storeToJson(Store data) => json.encode(data.toJson());

class Store {
    List<StoreElement> stores;

    Store({
        required this.stores,
    });

    factory Store.fromJson(Map<String, dynamic> json) => Store(
        stores: List<StoreElement>.from(json["stores"].map((x) => StoreElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "stores": List<dynamic>.from(stores.map((x) => x.toJson())),
    };
}

class StoreElement {
    int id;
    String name;
    String location;
    Contact contact;

    StoreElement({
        required this.id,
        required this.name,
        required this.location,
        required this.contact,
    });

    factory StoreElement.fromJson(Map<String, dynamic> json) => StoreElement(
        id: json["id"],
        name: json["name"],
        location: json["location"],
        contact: Contact.fromJson(json["contact"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "location": location,
        "contact": contact.toJson(),
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
