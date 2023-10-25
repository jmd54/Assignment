import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grocery_store_app/Model/grocery_items.dart';
import 'package:grocery_store_app/Model/store.dart';
import 'package:grocery_store_app/Screens/grocery_items.dart';
import 'package:http/http.dart'as http;

class ListOfStores extends StatefulWidget {
  const ListOfStores({super.key});

  @override
  State<ListOfStores> createState() => _ListOfStoresState();
}

class _ListOfStoresState extends State<ListOfStores> {
   late List<StoreElement>stores=[];
    @override
  void initState() {
    super.initState();
    fetchStores();
  }
    Future<void> fetchStores() async {
    try {
    final response = await http.get(Uri.parse('https://singhneelesh.github.io/assignment/storeList.json'));

    if (response.statusCode == 200) {
      // final Map<String, dynamic> data  = json.decode(response.body);
      setState(() {
        stores = storeFromJson(response.body).stores.toList();
      });
    } else {
      print('Failed to fetch store data: ${response.statusCode}');
    }
  } catch (error) {
    print('Error fetching store data: $error');
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text('List of Stores'),
      ),
      body: ListView.builder(
        itemCount: stores.length,
        itemBuilder: (context, index){
          final store = stores[index];
          return GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>GroceryItems(store.id, store),
                ),
              );
            },
            child: ListTile(
              title: Text(store.name),
              subtitle: Text(store.location),
              
                  ),
          );
        }
    )
    );
  }
}