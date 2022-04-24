import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/add/add_hotel_and_rosort.dart';
import 'package:travel_app/pages/hotel_and_resort_details.dart';
import 'package:travel_app/travel_provider/travel_provider.dart';
import 'package:travel_app/widgets/appbardecoration.dart';

class HotelAndResort extends StatefulWidget {
  const HotelAndResort({Key? key}) : super(key: key);

  @override
  _HotelAndResortState createState() => _HotelAndResortState();
}

class _HotelAndResortState extends State<HotelAndResort> {
  int _counter=0;
  void _customInitState(TravelProvider travelProvider){
    setState(() {
      _counter++;
    });
    travelProvider.getHotelAndResort();
  }

  @override
  Widget build(BuildContext context) {
    final TravelProvider travelProvider=Provider.of<TravelProvider>(context);
    if(_counter==0)_customInitState(travelProvider);
    return Scaffold(
      appBar: appBarDecoration(context,'Hotel & Resort'),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddHotelAndResort()));
        },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: _bodyUi(travelProvider),
    );
  }
  Widget _bodyUi( TravelProvider travelProvider){
    return travelProvider.hotelAndResortList.length<1?Center(child: Text('No Hotel & Resort Found Yet ??',style: TextStyle(color: Colors.amber,fontSize: 25,),),)
        :ListView.builder(
        itemCount: travelProvider.hotelAndResortList.length,
        // itemCount: 1,
        itemBuilder: (context,index){
          return InkWell(
              onTap: (){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => HotelAndResortDetails(
                  hrname:travelProvider.hotelAndResortList[index].hrname,
                  hrimage:travelProvider.hotelAndResortList[index].hrimage,
                  hraddress:travelProvider.hotelAndResortList[index].hraddress,
                  hrdescription:travelProvider.hotelAndResortList[index].hrdescription,
                  hrfacilities:travelProvider.hotelAndResortList[index].hrfacilities,
                  longitude:travelProvider.hotelAndResortList[index].longitude,
                  latitude: travelProvider.hotelAndResortList[index].latitude,
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
                          '${travelProvider.hotelAndResortList[index].hrimage}',
                          height: 250,
                          width: double.maxFinite,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(height:7),
                      Padding(
                        padding:EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${travelProvider.hotelAndResortList[index].hrname}',maxLines:2,style: TextStyle(color: Colors.grey[700],fontSize: 20),),
                            SizedBox(height:2),
                            Text('${travelProvider.hotelAndResortList[index].hraddress}',style: TextStyle(color: Colors.grey[600],fontSize: 17),textAlign: TextAlign.left,),
                            SizedBox(height:2),
                            Text('${travelProvider.hotelAndResortList[index].hrdescription}',maxLines: 4,style: TextStyle(fontSize: 14),textAlign: TextAlign.justify,),
                          ],
                        ),
                      )
                    ],
                  ))
          );
        });
  }
}
