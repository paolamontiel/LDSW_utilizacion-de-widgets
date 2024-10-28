import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Utilización de widgets',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Actividad 3.4 Utilización de widgets',
          style: TextStyle( fontSize: 24, fontWeight: FontWeight.bold, ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text('Widget Text:', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), ),
              Text('"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."', style: TextStyle(fontSize: 16),),
              SizedBox(height: 20),

              Text('Widget Row:', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.blue, size: 30),
                  SizedBox(width: 10),
                  Icon(Icons.star, color: Colors.green, size: 30),
                  SizedBox(width: 10),
                  Icon(Icons.star, color: Colors.red, size: 30),
                ],
              ),
              SizedBox(height: 20),

              Text('Widget Column:', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), ),
              Column(
                children: [
                  Text('Elemento 1', style: TextStyle(fontSize: 16), ),
                  Text('Elemento 2', style: TextStyle(fontSize: 16), ),
                  Text('Elemento 3', style: TextStyle(fontSize: 16), ),
                ],
              ),
              SizedBox(height: 20),

              Text('Widget Container:', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
              Container(
                width: 100,
                height: 100,
                color: Colors.purple,
                child: Center(
                  child: Text('Container', style: TextStyle(color: Colors.white, fontSize: 16), ),
                ),
              ),
              SizedBox(height: 20),


              Text('Widget Stack:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    color: Colors.orange,
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.blue,
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    color: Colors.white,
                    child: Center(
                      child: Text('Stack', style: TextStyle(color: Colors.black, fontSize: 16), ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
