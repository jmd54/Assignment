import 'dart:convert';
import 'package:grocery_store_app/Model/store.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:cached_network_image/cached_network_image.dart';


class GroceryItems extends StatefulWidget {
  final int storeId;
  final StoreElement storeDetails;
  GroceryItems(this.storeId, this.storeDetails);


  @override
  State<GroceryItems> createState() => _GroceryItemsState();
}

class _GroceryItemsState extends State<GroceryItems> {
  
  late List groceryItems;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
    print(widget.storeId);
  }

  Future<void> fetchData() async {
    // Fetch store details and grocery items from the API
    final response = await http.get(Uri.parse('https://singhneelesh.github.io/assignment/storeDetails/${widget.storeId}.json'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        // storeDetails = storeProductFromJson(response.body).store1;
        groceryItems = data["store${widget.storeId}"]["groceryItems"];
      
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Store Details and Grocery Items'),
      ),
      body: isLoading
          ? ShimmerLoading()
          : SingleChildScrollView(
              child: Column(
                children: [
                  StoreDetailsCard(widget.storeDetails),
                  GroceryItemList(groceryItems),
                ],
              ),
            ),
    );
  }
}

class ShimmerLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.grey,
      child: Column(
        children: [
          Container(
            height: 150,
            color: Colors.white,
          ),
          Container(
            height: 200,
            color: Colors.white,
          ),
          Container(
            height: 300,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class StoreDetailsCard extends StatelessWidget {
  final StoreElement storeDetails;
  StoreDetailsCard(this.storeDetails);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(storeDetails.name),
            subtitle: Text(storeDetails.location),
          ),
          ListTile(
            title: Text('Contact'),
            subtitle: Text(storeDetails.contact.phone.toString()),
            trailing: 
              Icon(Icons.phone),
            ),
        ]
          ),
    );
      
  }
}

class GroceryItemList extends StatelessWidget {
  final List groceryItems;

  GroceryItemList(this.groceryItems);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: groceryItems.length,
      itemBuilder: (context, index) {
        var item = groceryItems[index];
        return Card(
          child: ListTile(
            leading: CachedNetworkImage(
              imageUrl: item["image"],height: 80,width: 80, fit: BoxFit.cover,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            title: Padding(
              padding: const EdgeInsets.only(left:15),
              child: Text(item["name"],),
            ) ,
            
            subtitle: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                  
                  children: [
                    Container(
                      height: 25,
                      width: 50,
                      decoration: BoxDecoration(color: Colors.red.withOpacity(0.5),borderRadius: BorderRadius.circular(5)),
                      child: Center(child: Text("${item["discountPercentage"]}%",style: TextStyle(fontSize: 16),)),
                    ),
                    SizedBox(width: 30 ),
                    Text("\$ ${item["price"]}",style: TextStyle(color: const Color.fromARGB(255, 45, 204, 50),fontWeight: FontWeight.bold  ))
                  ],
                ),
            )
            // subtitle: Text("Price: ${item["price"]} - Discount: ${item["discountPercentage"]}%"),
          ),
        );
        
      },
    );
  }
}