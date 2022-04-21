import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/travel_provider/travel_provider.dart';
import 'package:travel_app/widgets/buttons.dart';
import 'package:travel_app/widgets/form_decorationt.dart';
import 'package:travel_app/widgets/notification_widgets.dart';
import 'package:travel_app/widgets/static_variables.dart';

class AddHotelAndResort extends StatefulWidget {
  const AddHotelAndResort({Key? key}) : super(key: key);

  @override
  _AddHotelAndResortState createState() => _AddHotelAndResortState();
}

class _AddHotelAndResortState extends State<AddHotelAndResort> {
  // GlobalKey <ScaffoldState> _scaffoldKey=GlobalKey();
  final _formKey = GlobalKey<FormState>();
  ImagePicker picker = ImagePicker();
  File? _imgFile;
  String? selectTravelRegion;
  String? selectTravelSpot;

  @override
  Widget build(BuildContext context) {
    final TravelProvider travelProvider = Provider.of<TravelProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Travel Spot'),
        centerTitle: true,
      ),
      body: _bodyUI(travelProvider),
    );
  }

  Widget _bodyUI(TravelProvider travelProvider) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ClipRRect(
                child: _imgFile != null
                    ? Image.file(
                  _imgFile!,
                  width: size.width,
                  height: size.height * 0.3,
                  fit: BoxFit.contain,
                )
                    : Icon(
                  Icons.image,
                  size: size.height * 0.3,
                  color: Theme.of(context).primaryColor,
                )
              // Image.asset('images/user.png',width: size.width ,
              //   height: size.height * 0.3,
              //   fit: BoxFit.fill,),
            ),
            SizedBox(height: size.width * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async => await _getImageFromCamera(),
                  icon: Icon(
                    Icons.camera_alt,
                    size: 40,
                  ),
                  color: Colors.blue,
                ),
                SizedBox(width: size.width * 0.08),
                IconButton(
                  onPressed: () {
                    _getImageFromGallery();
                  },
                  icon: Icon(
                    Icons.image,
                    size: 40,
                  ),
                  color: Colors.blue,
                ),
              ],
            ),
            Divider(),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: size.width * 0.08),
                  _textFieldBuilder('Hotel & Resort name', travelProvider),
                  SizedBox(height: size.width * 0.08),
                  _textFieldBuilder('Address', travelProvider),
                  SizedBox(height: size.width * 0.08),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      // color: Color(0xffF4F7F5),
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                        border: Border.all(color: Colors.black, width: 3)),
                    width: MediaQuery.of(context).size.width,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: selectTravelRegion,
                        hint: Container(
                          width: size.width * .75,
                          child: Text('Select Region',
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: size.height * 0.023)),
                        ),
                        items: StaticVariables.TravelRegion.map(
                                (selectTravelRegion) {
                              return DropdownMenuItem(
                                child: Container(
                                  width: size.width * .75,
                                  child: Text(selectTravelRegion,
                                      style: TextStyle(
                                        color: Colors.grey[900],
                                        fontSize: 16,
                                      )),
                                ),
                                value: selectTravelRegion,
                              );
                            }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectTravelSpot = null;
                            selectTravelRegion = newValue as String?;
                            travelProvider.hotelAndResortModel.travelspot = null;
                            travelProvider.hotelAndResortModel.travelregion = newValue as String?;
                          });
                        },
                        dropdownColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: size.width * 0.08),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      // color: Color(0xffF4F7F5),
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                        border: Border.all(color: Colors.black, width: 3)),
                    width: MediaQuery.of(context).size.width,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: selectTravelSpot,
                        hint: Container(
                          width: size.width * .75,
                          child: Text('Select Travel Spot',
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: size.height * 0.023)),
                        ),
                        items: selectTravelRegion != null
                            ? selectTravelRegion == 'Travel Bangladesh'
                            ? StaticVariables.TravelBD.map(
                                (selectTravelRegion) {
                              return DropdownMenuItem(
                                child: Container(
                                  width: size.width * .75,
                                  child: Text(selectTravelRegion,
                                      style: TextStyle(
                                        color: Colors.grey[900],
                                        fontSize: 16,
                                      )),
                                ),
                                value: selectTravelRegion,
                              );
                            }).toList()
                            : selectTravelRegion == 'Travel World'
                            ? StaticVariables.TravelWorld.map(
                                (selectTravelRegion) {
                              return DropdownMenuItem(
                                child: Container(
                                  width: size.width * .75,
                                  child: Text(selectTravelRegion,
                                      style: TextStyle(
                                        color: Colors.grey[900],
                                        fontSize: 16,
                                      )),
                                ),
                                value: selectTravelRegion,
                              );
                            }).toList()
                            : null
                            : null,
                        onChanged: (newValue) {
                          setState(() {
                            selectTravelSpot = null;
                            selectTravelSpot = newValue as String?;
                            travelProvider.hotelAndResortModel.travelspot = newValue as String?;
                          });
                        },
                        dropdownColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: size.width * 0.08),
                  _textFieldBuilder('latitude', travelProvider),
                  SizedBox(height: size.width * 0.08),
                  _textFieldBuilder('longitude', travelProvider),
                  SizedBox(height: size.width * 0.08),
                  _textFieldBuilder('Facilities', travelProvider),
                  SizedBox(height: size.width * 0.08),
                  _textFieldBuilder('Description', travelProvider),
                  SizedBox(height: size.width * 0.08),

                  InkWell(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        travelProvider.loadingMgs= 'Submitting information...';
                        showLoadingDialog(context,travelProvider);
                        // Navigator.pop(context);
                        // Center(child: CircularProgressIndicator(),);

                        await travelProvider.addHotelAndResort(
                            context,
                            travelProvider.hotelAndResortModel,
                            _imgFile!);
                      }
                    },
                    child: button(context, 'Submit'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textFieldBuilder(String hintTxt, TravelProvider travelProvider) {
    Size size = MediaQuery.of(context).size;
    return TextFormField(
      keyboardType: hintTxt == 'latitude' || hintTxt == 'longitude'?TextInputType.number
          :TextInputType.text,
      maxLines: hintTxt == 'Facilities' ? 4
          :hintTxt == 'Description' ? 5 : 1,
      // scrollPhysics: ScrollPhysics(),
      // textAlign: TextAlign.start,
      decoration: FormDecoration.copyWith(
        labelText: hintTxt,
        labelStyle: TextStyle(fontSize: size.height * 0.023),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please Fill All filled';
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          hintTxt == 'Hotel & Resort name' ? travelProvider.hotelAndResortModel.hrname = value
              :hintTxt == 'Address' ? travelProvider.hotelAndResortModel.hraddress = value
              :hintTxt == 'Facilities' ? travelProvider.hotelAndResortModel.hrfacilities = value
              :hintTxt == 'latitude' ? travelProvider.hotelAndResortModel.latitude = value
              :hintTxt == 'longitude' ? travelProvider.hotelAndResortModel.longitude = value
              : travelProvider.hotelAndResortModel.hrdescription = value;
        });
      },
    );
  }

  Future<void> _getImageFromGallery() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery, maxWidth: 300, maxHeight: 300);
    if (pickedFile != null) {
      setState(() {
        _imgFile = File(pickedFile.path);
      });
    } else {
      Navigator.pop(context);
    }
  }

  Future<void> _getImageFromCamera() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.camera, maxWidth: 300, maxHeight: 300);
    if (pickedFile != null) {
      setState(() {
        _imgFile = File(pickedFile.path);
      });
    } else {
      // showSnackBar(_scaffoldKey, 'No image selected', Colors.deepOrange);
      Navigator.pop(context);
    }
  }
}
