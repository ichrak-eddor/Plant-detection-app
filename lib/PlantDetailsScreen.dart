import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class PlantStatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grape'),
        backgroundColor: Colors.green.shade700,
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.info_circle),
            onPressed: () {
              // Info button pressed
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildPlantMetrics(),
            SizedBox(height: 20.0),
            _buildWeeklySummary(),
          ],
        ),
      ),
    );
  }

  Widget _buildPlantMetrics() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildMetricCard('Sunlight', 'Good', CupertinoIcons.sun_max, Colors.yellow),
            _buildMetricCard('Moisture', 'Low', CupertinoIcons.drop, Colors.blue),
          ],
        ),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildMetricCard('Temp.', 'Good', CupertinoIcons.thermometer, Colors.red),
            _buildMetricCard('Fertility', 'Good', CupertinoIcons.leaf_arrow_circlepath, Colors.green),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard(String title, String status, IconData icon, Color color) {
    return Card(
      child: Container(
        width: 150.0,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32.0),
            SizedBox(height: 8.0),
            Text(title, style: TextStyle(fontSize: 16.0)),
            SizedBox(height: 4.0),
            Text(status, style: TextStyle(color: color)),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklySummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Last week', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Sunlight: Good'),
            TextButton(onPressed: () {}, child: Text('See details')),
          ],
        ),
        _buildWeeklyBarChart(CupertinoIcons.sun_max, Colors.yellow, 'Good'),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Moisture: Not Good'),
          ],
        ),
        _buildWeeklyBarChart(CupertinoIcons.drop, Colors.blue, 'Not Good'),
      ],
    );
  }

  Widget _buildWeeklyBarChart(IconData icon, Color color, String status) {
    return Container(
      height: 80.0,
      child: Row(
        children: [
          Icon(icon, color: color),
          SizedBox(width: 10.0),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: 20.0,
                          height: 60.0,
                          color: color.withOpacity((index + 1) / 7),
                        ),
                      ),
                      Text(['S', 'M', 'T', 'W', 'T', 'F', 'S'][index]),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


















/*import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'homescrean.dart';

class PlantDetailsScreen extends StatelessWidget {
  final Plant plant;

  PlantDetailsScreen({required this.plant});

  final DatabaseReference _database = FirebaseDatabase.instance.reference().child('disease').child('data');

  Future<Map<dynamic, dynamic>> fetchPlantData() async {
    DataSnapshot dataSnapshot = await _database.once().then((snapshot) => snapshot.snapshot);
    return dataSnapshot.value as Map<dynamic, dynamic>? ?? {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Details'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: FutureBuilder<Map<dynamic, dynamic>>(
          future: fetchPlantData(),
          builder: (context, AsyncSnapshot<Map<dynamic, dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              Map<dynamic, dynamic> data = snapshot.data ?? {};

              // Check if the predicted class is 'Potato___Late_blight'
              if (data['predicted_class'] == 'Potato___Late_blight') {
                // Show a SnackBar notification
                WidgetsBinding.instance?.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Potato___Late_blight detected!'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                });
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    plant.image,
                    width: 200.0,
                    height: 200.0,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    plant.name,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Predicted Class: ${data['predicted_class'] ?? 'N/A'}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}


 */