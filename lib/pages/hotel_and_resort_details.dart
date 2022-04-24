import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_app/widgets/appbardecoration.dart';

class HotelAndResortDetails extends StatefulWidget {

  String? hrname;
  String? hrimage;
  String? hraddress;
  String? hrdescription;
  String? hrfacilities;
  String? latitude;
  String? longitude;

  HotelAndResortDetails({
    this.hrname,
    this.hrimage,
    this.hraddress,
    this.hrdescription,
    this.hrfacilities,
    this.latitude,
    this.longitude,
  });
  @override
  _HotelAndResortDetailsState createState() => _HotelAndResortDetailsState();
}

class _HotelAndResortDetailsState extends State<HotelAndResortDetails> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Set<Marker> _marker = HashSet<Marker>();
  static GoogleMapController? _mapController;

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _marker.add(Marker(
          markerId: MarkerId('0'),
          position: LatLng(double.parse(widget.latitude ?? '0.0'),
              double.parse(widget.longitude ?? '0.0')),
          infoWindow: InfoWindow(title: widget.hrname, snippet: 'this is ${widget.hrname}')));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarDecoration(context, 'Hotel & Resort Details'),
        body: _bodyUI(),
        floatingActionButton: new FloatingActionButton(
          elevation: 0.0,
          child: new Icon(Icons.location_pin),
          backgroundColor: new Color(0xFFE57373),
          onPressed: () => _locationModal(),
        )
    );
  }

  Widget _bodyUI() {
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
            '${widget.hrimage}',
            height: 300,
            width: double.maxFinite,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(height: 10,),
        SizedBox(height: 10,),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                '${widget.hrname}',
                style: TextStyle(color: Colors.grey[800], fontSize: 25),
              ),
              SizedBox(height: 5,),
              Text(
                '${widget.hraddress}',
                style: TextStyle(color: Colors.grey[600], fontSize: 17),
              ),
              Divider(),
              Text(
                'Facilities',
                style: TextStyle(color: Colors.grey[700], fontSize: 20),
              ),
              SizedBox(height: 5,),
              Text(
                '${widget.hrfacilities}',
                textAlign: TextAlign.justify,
              ),
              Divider(),
              Text(
                'Description',
                style: TextStyle(color: Colors.grey[700], fontSize: 20),
              ),
              SizedBox(height: 5,),
              Text(
                '${widget.hrdescription}',
                textAlign: TextAlign.justify,
              ),
            ]))
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
