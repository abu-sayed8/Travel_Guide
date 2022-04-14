import 'package:flutter/material.dart';
import 'package:travel_app/add/add_travelspot.dart';
import 'package:travel_app/pages/travel_spot.dart';
import 'package:travel_app/widgets/appbardecoration.dart';
import 'package:travel_app/widgets/static_variables.dart';

class RegionPage extends StatefulWidget {
  int? index;
  String? region;

  RegionPage({this.index, this.region});

  @override
  _RegionPageState createState() => _RegionPageState();
}

class _RegionPageState extends State<RegionPage> {
  List regionList=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.index == 0){
      regionList= StaticVariables.TravelBD;
    }else{
      regionList=StaticVariables.TravelWorld;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarDecoration(context, '${widget.region}'),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTravelSpot()));
        },
        child: Icon(Icons.add),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 100,
            ),
            itemCount: regionList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => TravelSpot(
                    region:regionList[index],
                  )));
                },
                child:Card(
                  child: Center(
                    child: Text(regionList[index],),
                  ),
                )
              );
            }));
  }
}
