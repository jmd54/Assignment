import 'package:flutter/material.dart';
import 'package:grocery_store_app/Model/list_of_stores.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine the time of day
    TimeOfDay currentTime = TimeOfDay.now();
    String greeting = _getGreeting(currentTime);

    // Get the screen size
    Size screenSize = MediaQuery.of(context).size;
    return  Scaffold(
      // appBar: AppBar(
      //   title: const Center(child: Text('Grocery Store App')),
      // ),
      body: Container(
        // color: Color.fromARGB(255, 214, 214, 223),
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenSize.height*0.1,),
              Text(
                  greeting,
                  style: TextStyle(
                    fontSize: screenSize.width * 0.1, // Adjust text size based on screen width
                  ),
                ),
                SizedBox(height: screenSize.height*0.3),
                Text(
                  'Welcome to the Grocery Store App.',
                  style: TextStyle(
                    fontSize: screenSize.width * 0.055, // Adjust text size based on screen width
                  ),
                ),
                SizedBox(height: screenSize.height*0.1),
      
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the List of Stores screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ListOfStores()),
        
                    );
                  },
                  child: const Text('Go to List of Stores'),
      
                ),
            ],
          ),
        ),
      ),
    );
  }
  String _getGreeting(TimeOfDay time) {
    if (time.hour >= 0 && time.hour < 12) {
      return 'Good Morning';
    } else {
      return 'Good Evening';
    }
  }
}