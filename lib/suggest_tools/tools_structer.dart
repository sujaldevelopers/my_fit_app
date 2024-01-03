import 'package:flutter/material.dart';

class Toolsapp extends StatelessWidget {
  final List<String> fruits = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Fig',
    'Grapes',
    'Kiwi',
    'Lemon',
    'Mango',
    'Orange',
    'Peach',
    'Pear',
    'Strawberry',
    'Watermelon',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fruit List'),
        ),
        body: ListView.builder(
          itemCount: fruits.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Icon(Icons.favorite), // You can use any icon or widget here
              title: Text(fruits[index]),
              subtitle: Text('A delicious fruit'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Handle item click here
                print('You tapped ${fruits[index]}');
              },
            );
          },
        ),
      ),
    );
  }
}
