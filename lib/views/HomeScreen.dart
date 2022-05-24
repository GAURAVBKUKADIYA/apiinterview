import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/Products.dart';
import 'loginscreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var id = "";
  var name = "";
  List<product> alldata;

  getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("name");
    });

    Uri url = Uri.parse("https://fakestoreapi.com/products");
    var response = await http.get(url);
    if (response.statusCode == 200) {
        var json =jsonDecode(response.body);
        setState(() {
          alldata = json.map<product>((obj)=>product.fromJson(obj)).toList();
        });


    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
      ),
      body:(alldata!=null)?
      Column(
        children: [
          Expanded(
            child: ListView.builder(

              itemCount: alldata.length,
              itemBuilder: (context,index)
              {
                return Container(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Image.network(alldata[index].image,width: 120.0,height: 120.0,),
                          Text(alldata[index].price.toString()),
                          Text(alldata[index].title.toString()),
                        ],

                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: ()async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();


                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder:(context)=>loginscreen())
                );
              },
              child: Text("Logout"),
            ),
          )

        ],
      ):Center(child: CircularProgressIndicator(),)
    );
  }
}
