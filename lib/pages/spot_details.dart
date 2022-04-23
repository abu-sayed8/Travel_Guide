import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/travel_provider/travel_provider.dart';
import 'package:travel_app/widgets/appbardecoration.dart';
import 'package:travel_app/widgets/notification_widgets.dart';

class SpotDetails extends StatefulWidget {
  String? id;
  String? spotname;
  String? image;
  String? description;
  String? travelregion;
  String? travelspot;
  String? latitude;
  String? longitude;

  SpotDetails({
    this.id,
    this.spotname,
    this.image,
    this.description,
    this.travelregion,
    this.travelspot,
    this.latitude,
    this.longitude,
  });

  @override
  _SpotDetailsState createState() => _SpotDetailsState();
}

class _SpotDetailsState extends State<SpotDetails> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Set<Marker> _marker = HashSet<Marker>();
  static GoogleMapController? _mapController;
  int _counter=0;
  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _marker.add(Marker(
          markerId: MarkerId('0'),
          position: LatLng(double.parse(widget.latitude ?? '0.0'),
          double.parse(widget.longitude ?? '0.0')),
      infoWindow: InfoWindow(title: widget.spotname, snippet: 'this is ${widget.spotname}')));
    });
  }
  // void _onMapCreated(GoogleMapController controller) {
  //   _mapController = controller;
  //   setState(() {
  //     _marker.add(Marker(
  //       markerId: MarkerId('0'),
  //       position: LatLng(double.parse(widget.latitude ?? '0.0'),
  //           double.parse(widget.longitude ?? '0.0')),
  //       infoWindow: InfoWindow(
  //           title: "${widget.spotname ?? ''}",
  //           snippet: "${widget.spotname ?? ''}"),
  //     ));
  //   });
  // }
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _onMapCreated(_mapController!);
  // }

  void _customInitState(TravelProvider travelProvider){
    setState(() {
      _counter++;
    });
    travelProvider.getHotelAndResortWithTravelSpot("${widget.travelspot}");
  }

  @override
  Widget build(BuildContext context) {
    final TravelProvider travelProvider=Provider.of<TravelProvider>(context);
    if(_counter==0)_customInitState(travelProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Spot Details',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        actions: [
          IconButton(
          onPressed: (){
            travelProvider.loadingMgs= 'Submitting information...';
            showLoadingDialog(context,travelProvider);
            travelProvider.addFavouriteTravelSpot(
                context,
                travelProvider.travelModel,
                '${widget.id}',
                '${widget.spotname}',
                '${widget.description}',
                '${widget.image}',
                '${widget.travelregion}',
                '${widget.travelspot}',
                '${widget.latitude}',
                '${widget.longitude}',
            );
    //             .then((value){
    //           Navigator.push(context,MaterialPageRoute(builder: (context)=>MyCartPage()));
    // }
    // );

    }, icon: Icon(Icons.favorite))

        ],
      ),
      body: _bodyUI(travelProvider),
        floatingActionButton: new FloatingActionButton(
            elevation: 0.0,
            child: new Icon(Icons.location_pin),
            backgroundColor: new Color(0xFFE57373),
            onPressed: () => _locationModal(),
        )
    );
  }

  Widget _bodyUI(TravelProvider travelProvider) {
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.all(1),
          margin: EdgeInsets.all(2),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade300,
              width: 3
            )
          ),
          child: Image.network(
            '${widget.image}',
            height: 300,
            width: double.maxFinite,
            // fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 10,),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                '${widget.spotname}',
                style: TextStyle(color: Colors.grey[700], fontSize: 25),
              ),
                  Divider(),
              Text(
                '${widget.description}',
                textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 14)
              ),
                  Divider(),
                  travelProvider.hotelAndResortWithTravelSpotList.length<1?Container():Text(
                    'Hotel And Resort',
                    style: TextStyle(color: Colors.green,fontSize: 20),
              ),
                  Divider(),
                  travelProvider.hotelAndResortWithTravelSpotList.length<1?Container():Container(
                    child: ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: travelProvider.hotelAndResortWithTravelSpotList.length,
                        itemBuilder: (context,index){
                          return Container(
                            color: Colors.grey[100],
                            margin: EdgeInsets.symmetric(vertical: 5),
                            padding: EdgeInsets.symmetric(horizontal: 3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${travelProvider.hotelAndResortWithTravelSpotList[index].hrname}",
                                    style: TextStyle(color: Colors.grey[900], fontSize: 20)
                                ),
                                SizedBox(height: 5,),
                                Text("${travelProvider.hotelAndResortWithTravelSpotList[index].hraddress}",
                                    style: TextStyle(color: Colors.grey[800], fontSize: 15)
                                ),
                                Divider(),
                                Text("Facilities : ",
                                    style: TextStyle(color: Colors.grey[800], fontSize: 20)
                                ),
                                SizedBox(height: 2,),
                                Text("${travelProvider.hotelAndResortWithTravelSpotList[index].hrfacilities}",
                                    style: TextStyle(color: Colors.grey[800], fontSize: 14)
                                ),
                                SizedBox(height: 5,),

                                Text("Description : ",
                                    style: TextStyle(color: Colors.grey[800], fontSize: 20)
                                ),
                                SizedBox(height: 2,),
                                Text("${travelProvider.hotelAndResortWithTravelSpotList[index].hrdescription}",
                                    style: TextStyle(color: Colors.grey[800], fontSize: 14)
                                ),

                              ],
                            ),
                          );
                        }),
                  )

                ])),
        ],
    );
  }
  ///Location Modal
  void _locationModal() {
    showModalBottomSheet(
      context: context,
      constraints: BoxConstraints(maxHeight: 500, maxWidth: double.infinity),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      builder: (context) {
        Size size = MediaQuery.of(context).size;
        return Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              color: Color(0xffF4F7F5),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                // Container(
                //     width: size.width,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.only(
                //           topLeft: Radius.circular(10),
                //           topRight: Radius.circular(10)
                //       ),
                //       color: Theme.of(context).primaryColor,
                //     ),
                //     //Color(0xffF4F7F5),
                //     //padding: const EdgeInsets.only(right: 15),
                //     child: GestureDetector(
                //       onTap: ()=>Navigator.pop(context),
                //       child: Icon(Icons.clear,color: Colors.grey[100],size: 30,),
                //     )
                // ),
                Container(
                  height: 20,
                  margin: EdgeInsets.only(bottom: 10),
                  child: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.close,size: 20,)),
                ),
                widget.latitude == null
                    ? Container()
                    : Container(
                  height: MediaQuery.of(context).size.height * .50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: GoogleMap(
                      compassEnabled: true,
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                            double.parse(widget.latitude ?? '0.0'),
                            double.parse(widget.longitude ?? '0.0')),
                        zoom: 15,
                      ),
                      markers: _marker,
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}
