import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/pages/spot_details.dart';
import 'package:travel_app/travel_provider/travel_provider.dart';
import 'package:travel_app/widgets/appbardecoration.dart';

class TravelSpot extends StatefulWidget {
  String? region;
  TravelSpot({this.region});
  @override
  _TravelSpotState createState() => _TravelSpotState();


}

class _TravelSpotState extends State<TravelSpot> {
  // List <TravelModel> travelList=[];
  // @override
  // void initState() {
  //   super.initState();
  //   travelList=GetTravel();
  // }
  ///
int _counter=0;
  void _customInitState(TravelProvider travelProvider){
    setState(() {
      _counter++;
    });
    travelProvider.getTravelSpot('${widget.region}');
  }

  @override
  Widget build(BuildContext context) {
    final TravelProvider travelProvider=Provider.of<TravelProvider>(context);
    if(_counter==0)_customInitState(travelProvider);
    return Scaffold(
      appBar: appBarDecoration(context,'${widget.region} Travel Spots'),
      body: _bodyUI(travelProvider),
    );
  }
  Widget _bodyUI( TravelProvider travelProvider){
    return travelProvider.travelSpotList.length<1?Center(child: Text('No Data Found Yet ??',style: TextStyle(color: Colors.amber,fontSize: 25,),),)
        :ListView.builder(
        itemCount: travelProvider.travelSpotList.length,
        // itemCount: 1,
        itemBuilder: (context,index){
          return InkWell(
              onTap: (){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SpotDetails(
                  id:travelProvider.travelSpotList[index].id,
                  spotname:travelProvider.travelSpotList[index].spotname,
                  image:travelProvider.travelSpotList[index].image,
                  description:travelProvider.travelSpotList[index].description,
                  travelregion:travelProvider.travelSpotList[index].travelregion,
                  travelspot:travelProvider.travelSpotList[index].travelspot,
                  longitude:travelProvider.travelSpotList[index].longitude,
                  latitude: travelProvider.travelSpotList[index].latitude,
                )));
              },
              child:Container(
                  margin: EdgeInsets.only(top:10,bottom: 16,left: 10,right: 10),
                  height: 400,
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
                          '${travelProvider.travelSpotList[index].image}',
                          height: 250,
                          width: double.maxFinite,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(height:10),
                      Padding(
                        padding:EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${travelProvider.travelSpotList[index].spotname}',style: TextStyle(color: Colors.grey[700],fontSize: 22),maxLines: 1,),
                            SizedBox(height:5),
                            Text('${travelProvider.travelSpotList[index].description}',maxLines: 4,textAlign: TextAlign.justify,),
                          ],
                        ),
                      )
                    ],
                  ))
          );
        });
  }
}
