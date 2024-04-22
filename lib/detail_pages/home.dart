import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'add.dart';
import 'edit.dart';

void main() => runApp(Home());

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  //make list variable to accomodate all data from database
  List _get = [];

  //make different color to different card
  final _lightColors = [
    Colors.amber.shade300,
    Colors.lightGreen.shade300,
    Colors.lightBlue.shade300,
    Colors.orange.shade300,
    Colors.pinkAccent.shade100,
    Colors.tealAccent.shade100
  ];

  @override
  void initState() {
    super.initState();
    //in first time, this method will be executed
    _getData();
  }

  Future _getData() async {
    try {
      final response = await http
          .get(Uri.parse("http://172.16.103.233/latihan/note_app/list.php"));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          _get = data;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note List', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
        ),
      ),
      //if not equal to 0 show data
      //else show text "no data available"
      body: _get.length != 0
          //we use masonry grid to make masonry card style
          ? MasonryGridView.count(
              crossAxisCount: 2,
              itemCount: _get.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        //routing into edit page
                        //we pass the id note
                        MaterialPageRoute(
                            builder: (context) => Edit(
                                  id: _get[index]['id'],
                                )));
                  },
                  child: Card(
                    //make random color to eveery card
                    color: _lightColors[index % _lightColors.length],
                    child: Container(
                      //make 2 different height
                      constraints:
                          BoxConstraints(minHeight: (index % 2 + 1) * 85),
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${_get[index]['date']}',
                            style: const TextStyle(color: Colors.black),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${_get[index]['car_type']}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: Text(
                "No Data Available",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.white,
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     Navigator.push(
      //         context,
      //         //routing into add page
      //         MaterialPageRoute(builder: (context) => Add()));
      //   },
      // ),
    );
  }
}
