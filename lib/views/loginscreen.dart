import 'dart:convert';

import 'package:apiinterview/resources/StyaleResources.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'HomeScreen.dart';

class loginscreen extends StatefulWidget {
  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  TextEditingController _name = TextEditingController();
  TextEditingController _password = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  bool _isload = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Center(
          child: Text("LoginScreen"),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Name",
                style: styaleresources.PRIMARYTEXT,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Password",
                style: styaleresources.PRIMARYTEXT,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _password,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _isload=true;
                    });
                    var name = _name.text.toString();
                    var pass = _password.text.toString();
                    
                    Uri url = Uri.parse("https://begratefulapp.ca/api/login");

                    Map<String,String> parms={
                      "name": name,
                      "password": pass,
                      "device_token":"12345678",
                      "device_os":"android"
                    };
                    var heder = {
                      "Content-Type":"application/json"
                    };

                    var response = await http.post(url,body: jsonEncode(parms),headers: heder);
                    if(response.statusCode==200)
                      {
                        var json = jsonDecode(response.body);
                        if(json["result"]=="success")
                          {
                        Fluttertoast.showToast(
                            msg: "Successfully Login",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0);

                        var name = json ["data"]["name"];
                        var id = json ["data"]["id"];
                        
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.setString("name", name.toString());
                        prefs.setString("id", id.toString());


                        Navigator.of(context).pop();
                        // _scaffoldKey.currentState.showSnackBar(
                        //     new SnackBar(duration: new Duration(seconds: 4), content:
                        //     new Row(
                        //       children: <Widget>[
                        //         new CircularProgressIndicator(),
                        //         new Text("  Please Wait...")
                        //       ],
                        //     ),
                        //     ));
                        // // _handleSignIn()
                        //     .whenComplete(() =>
                        //     Navigator.of(context).pushNamed("/Home")
                        // );
                        setState(() {

                          _isload=false;
                        });
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>HomeScreen())
                        );
                      }
                        else{
                          Fluttertoast.showToast(
                              msg: "Somthing Wrong",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      }
                    
                  },
                  child: (_isload)?CircularProgressIndicator():Text("Login"),
                ),

              )
            ],
          ),
        ),
      ),
    );
  }
}
