import 'package:apiinterview/views/HomeScreen.dart';
import 'package:apiinterview/views/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}




class _SplashScreenState extends State<SplashScreen> {

  gotopage()async{
    await Future.delayed(const Duration(seconds: 3),()async{

      SharedPreferences prefs = await SharedPreferences.getInstance();
      if(prefs.containsKey("name"))
        {
          Navigator.of(context).pop();
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=>HomeScreen())

          );
        }
      else
        {
          Navigator.of(context).pop();
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=>loginscreen())
          );
        }


    });
    }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gotopage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Column(
          children: [
           Container(
             child:  Image.asset("img/welcome.gif",height:600),
           ),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
