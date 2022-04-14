import 'package:flutter/material.dart';
import 'package:travel_app/widgets/appbardecoration.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDecoration(context,'About Us'),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          // color: Colors.greenAccent
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Toure & Travel Guide',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            Divider(),
            Text('Founder & Managing Director',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            Text('Mehedi Hasan Milton',style: TextStyle(fontSize: 20),),
            Divider(),
            Text('Address',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            Text('Sorisha Bari ,Jamalpur, Bangladesh',style: TextStyle(fontSize: 20),),
            Divider(),
            Text('Mobile',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            Text('01993-500665',style: TextStyle(fontSize: 20),),

          ],
        ),
      ),
    );
  }
}
