import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/pages/about_us.dart';
import 'package:travel_app/pages/favourite_place.dart';
import 'package:travel_app/pages/hotel-and-resort.dart';
import 'package:travel_app/pages/region_page.dart';
import 'package:travel_app/widgets/appbardecoration.dart';
import 'package:travel_app/widgets/static_variables.dart';

import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBarDecoration(context, 'Home'),
      body: _bodyUi(),
      drawer: drawerUi(),
    );
  }
  Widget drawerUi() {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(85),
                  bottomRight: Radius.circular(85)),
              color: Colors.green,
            ),
            child: Center(
              child: Text(
                "Travel Guide",
                style: TextStyle(fontSize: 35, color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
            },
            leading: Icon(
              Icons.home,
              color: Colors.green,
            ),
            trailing: Icon(Icons.arrow_forward_ios,),
            title: Text(
              "Home",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Divider(
            height: 1,
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => RegionPage(
                index:0,
                region:StaticVariables.HomeData[0],
              )));
            },
            leading: Icon(
              Icons.my_location_sharp,
              color: Colors.green,
            ),
            trailing: Icon(Icons.arrow_forward_ios,),
            title: Text(
              "Travel Bangladesh",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Divider(
            height: 1,
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => RegionPage(
                index:1,
                region:StaticVariables.HomeData[1],
              )));
            },
            leading: Icon(
              Icons.language,
              color: Colors.green,
            ),
            trailing: Icon(Icons.arrow_forward_ios,),
            title: Text(
              "Travel World",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Divider(
            height: 1,
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => FavouritePlace()));
            },
            leading: Icon(
              Icons.featured_play_list,
              color: Colors.green,
            ),
            trailing: Icon(Icons.arrow_forward_ios,),
            title: Text(
              "Travel Blog",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Divider(
            height: 1,
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => FavouritePlace()));
            },
            leading: Icon(
              Icons.star,
              color: Colors.green,
            ),
            trailing: Icon(Icons.arrow_forward_ios,),
            title: Text(
              "Favoriate Place",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Divider(
            height: 1,
          ),
          ListTile(
            onTap: () {
            Navigator.push(
            context, MaterialPageRoute(builder: (context) => HotelAndResort()));
            },
            leading: Icon(
              Icons.hotel_outlined,
              color: Colors.green,
            ),
            trailing: Icon(Icons.arrow_forward_ios,),
            title: Text(
              "Hotel & Resort",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Divider(
            height: 1,
          ),
          ListTile(
            onTap: () async{
              if (await canLaunch('https://www.youtube.com/')) {
              await launch('https://www.youtube.com/results?search_query=travel+video');};
            },
            leading: Icon(
              Icons.video_collection_outlined,
              color: Colors.green,
            ),
            trailing: Icon(Icons.arrow_forward_ios,),
            title: Text(
              "Video",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Divider(
            height: 1,
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AboutUs()));
            },
            leading: Icon(
              Icons.save,
              color: Colors.green,
            ),
            trailing: Icon(Icons.arrow_forward_ios,),
            title: Text(

              "About Us",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Divider(
            height: 1,
          ),
          ListTile(
            onTap: () {
              Navigator.push;
            },
            leading: Icon(
              Icons.share,
              color: Colors.green,
            ),
            trailing: Icon(Icons.arrow_forward_ios,),
            title: Text(
              "Share ",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bodyUi() {
    Size size = MediaQuery.of(context).size;
    Color Primerycolor = Theme.of(context).primaryColor;
    Color hintcolor = Theme.of(context).hintColor;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: size.height * 0.12,
            width: size.width,
            decoration: BoxDecoration(color: Primerycolor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.pin_drop_outlined,
                  size: size.height * 0.08,
                  color: hintcolor,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Travel Guide',
                      style: TextStyle(
                          color: hintcolor, fontSize: size.height * .045),
                    ),
                    Text('Travel Information for All Countries',
                        style: TextStyle(
                            color: hintcolor, fontSize: size.height * .016)),
                  ],
                )
              ],
            ),
          ),
          GridView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 150,
              ),
              itemCount: StaticVariables.HomeData.length,
              itemBuilder: (context, index) {
                return _gridBuilder(index);
              }),
          Card(
              child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () async {
                            // await canLaunch('https://vtti.gov.bd/')
                            //      ?await launch('https://vtti.gov.bd/')
                            // : Container(),
                            if (await canLaunch('https://www.facebook.com/')) {
                              await launch('https://www.facebook.com/');
                            }
                            ;
                          },
                          icon: Icon(
                            FontAwesomeIcons.facebook,
                            size: 45,
                            color: Colors.blue,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            // await canLaunch('https://vtti.gov.bd/')
                            //      ?await launch('https://vtti.gov.bd/')
                            // : Container(),
                            if (await canLaunch('https://twitter.com/')) {
                              await launch('https://twitter.com/');
                            }
                            ;
                          },
                          icon: Icon(
                            FontAwesomeIcons.twitter,
                            size: 45,
                            color: Colors.blue,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            // await canLaunch('https://vtti.gov.bd/')
                            //      ?await launch('https://vtti.gov.bd/')
                            // : Container(),
                            if (await canLaunch('https://www.instagram.com/')) {
                              await launch('https://www.instagram.com/');
                            }
                            ;
                          },
                          // ignore: prefer_const_constructors
                          icon: Icon(
                            FontAwesomeIcons.instagram,
                            size: 45,
                            color: Colors.purple,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            // await canLaunch('https://vtti.gov.bd/')
                            //      ?await launch('https://vtti.gov.bd/')
                            // : Container(),
                            if (await canLaunch('https://www.youtube.com/')) {
                              await launch('https://www.youtube.com/');
                            }
                            ;
                          },
                          // ignore: prefer_const_constructors
                          icon: Icon(
                            FontAwesomeIcons.youtube,
                            size: 45,
                            color: Colors.red,
                          ),
                        ),
                      ])))
        ],
      ),
    );
  }

  Widget _gridBuilder(int index) {
    return InkWell(
        onTap: () async{
          if (index == 0 || index == 1) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => RegionPage(
              index:index,
              region:StaticVariables.HomeData[index],
            )));
          }
          if (index == 2) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HotelAndResort(
            )));
          }
          if (index == 3) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => FavouritePlace(
            )));
          }
        if (index == 4) {
          // await canLaunch('https://vtti.gov.bd/')
          //      ?await launch('https://vtti.gov.bd/')
          // : Container(),
          if (await canLaunch('https://www.youtube.com/')) {
    await launch('https://www.youtube.com/results?search_query=travel+video');};

          }
          if (index == 5) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AboutUs(
            )));
          }
        },
        child: Card(
          color: Colors.green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                index == 0
                    ? Icons.my_location_sharp
                    : index == 1
                    ? Icons.language
                    : index == 2
                    ? Icons.hotel_outlined
                    : index == 3
                    ? Icons.favorite
                    : index == 4
                    ? Icons.video_library_sharp
                    : Icons.supervised_user_circle_outlined,
                color: Colors.white,
                size: 30,
              ),
              Text(
                StaticVariables.HomeData[index],
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ));
  }
}
