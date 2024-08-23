import 'package:flutter/material.dart';
import 'package:smartplandetection/robotcontrol.dart';

import 'PlantDetailsScreen.dart';

// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Sample plant data (replace with your actual data source)
  final List<Plant> plants = [
    Plant(name: 'Grape', image: 'assests/plant1.jpg'),
    Plant(name: 'Fiddle Leaf Fig', image: 'assests/plant2.jpg'),
    Plant(name: 'Snake Plant', image: 'assests/plant3.jpg'),
    // ... Add more plants
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GROWIZE'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Indoor/Outdoor plant selection (replace with actual functionality)
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => print('Selected Indoor Plants'),
                    child: Text('Indoor'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      onPrimary: Colors.white,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => print('Selected Outdoor Plants'),
                    child: Text('Outdoor'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey.shade200,
                      onPrimary: Colors.black,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => print('Selected Both Indoor & Outdoor Plants'),
                    child: Text('Both'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey.shade400,
                      onPrimary: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // Horizontal list of plant boxes (optional)
            Container(
              height: 200.0, // Set a fixed height for the container
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: plants.length,
                itemBuilder: (context, index) {
                  return PlantBox(plant: plants[index]);
                },
              ),
            ),
            // Robot control box




            Container(
              margin: EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to robot control screen
                  // You can replace the below print statement with navigation code
                  print('Navigate to Robot Control Screen');
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) {
                     return RobotControlScreen();
                  }),
                   );


                },
                child: Text(' Control'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.green.shade700,
      ),
    );
  }
}

class Plant {
  final String name;
  final String image;

  Plant({required this.name, required this.image});
}
class PlantBox extends StatelessWidget {
  final Plant plant;

  PlantBox({required this.plant});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to plant details screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PlantStatusScreen(// Example anomalies
          )),
        );
      },
      child: Container(
        width: 200.0,
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          color: Colors.green.shade100,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              plant.image,
              width: 100.0,
              height: 100.0,
            ),
            SizedBox(height: 10.0),
            Text(
              plant.name,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Plant percentage (replace with actual data source)
            Text(
              '12%',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sunny',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                  ),
                ),
                // Choose the appropriate icon based on light condition
                Icon(
                  Icons.lightbulb_outline, // Replace with desired light icon
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

