import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/pages/spot_details.dart';
import 'package:travel_app/widgets/appbardecoration.dart';

import '../travel_provider/travel_provider.dart';
class FavouritePlace extends StatefulWidget {
  const FavouritePlace({Key? key}) : super(key: key);

  @override
  _FavouritePlaceState createState() => _FavouritePlaceState();
}

class _FavouritePlaceState extends State<FavouritePlace> {
  int _counter=0;
  void _customInitState(TravelProvider travelProvider){
    setState(() {
      _counter++;
    });
    travelProvider.getFavouriteSpot();
  }

  @override
  Widget build(BuildContext context) {
    final TravelProvider travelProvider=Provider.of<TravelProvider>(context);
    if(_counter==0)_customInitState(travelProvider);
    return Scaffold(
      appBar: appBarDecoration(context,'Favourite Spots'),
      body: _bodyUI(travelProvider),
    );
  }
  Widget _bodyUI( TravelProvider travelProvider){
    return ListView.builder(
      // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //   crossAxisCount: 1,
      //   mainAxisExtent: 350,
      //   mainAxisSpacing: 10,
      //   crossAxisSpacing: 10
      // ),
        itemCount: travelProvider.favouriteSpotList.length,
        // itemCount: 1,
        itemBuilder: (context,index){
          return InkWell(
              onTap: (){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SpotDetails(
                  spotname:travelProvider.favouriteSpotList[index].spotname,
                  image:travelProvider.favouriteSpotList[index].image,
                  description:travelProvider.favouriteSpotList[index].description,
                  longitude:travelProvider.favouriteSpotList[index].longitude,
                  latitude: travelProvider.favouriteSpotList[index].latitude,
                )));
              },
              child:Container(
                  margin: EdgeInsets.only(top:10,bottom: 16,left: 10,right: 10),
                  height: 350,
                  width: double.maxFinite,
                  // padding: EdgeInsets.all(16),

                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 5.0,
                            spreadRadius: 3.0,
                            offset: Offset(0,3)
                        )
                      ]
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        child: Image.network(
                          '${travelProvider.favouriteSpotList[index].image}',
                          height: 200,
                          width: double.maxFinite,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height:10),
                      Padding(
                        padding:EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${travelProvider.favouriteSpotList[index].spotname}',style: TextStyle(color: Colors.grey[700],fontSize: 30),),
                            SizedBox(height:5),
                            Text('${travelProvider.favouriteSpotList[index].description}',maxLines: 4,textAlign: TextAlign.justify,),
                          ],
                        ),
                      )
                    ],
                  ))
          );
        });
  }
}