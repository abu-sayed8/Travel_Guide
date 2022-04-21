import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/model/hotel_resort_model.dart';
import 'package:travel_app/model/travel_model.dart';

class TravelProvider extends ChangeNotifier {
  TravelModel _travelModel = TravelModel();
  HotelAndResortModel _hotelAndResortModel = HotelAndResortModel();
  List<TravelModel> _travelSpotList = [];
  List<TravelModel> _favouriteSpotList = [];
  List<HotelAndResortModel> _hotelAndResortList = [];
  List<HotelAndResortModel> _hotelAndResortWithTravelSpotList = [];

  String? _loadingMgs;

  TravelModel get travelModel => _travelModel;
  HotelAndResortModel get hotelAndResortModel => _hotelAndResortModel;

  get travelSpotList => _travelSpotList;

  get favouriteSpotList => _favouriteSpotList;
  get hotelAndResortList => _hotelAndResortList;
  get hotelAndResortWithTravelSpotList => _hotelAndResortWithTravelSpotList;

  String get loadingMgs => _loadingMgs!;
  // set travelSpotList(List<TravelModel> value) {
  //   _travelSpotList = value;
  //   notifyListeners();
  // }
  set travelModel(TravelModel model) {
    model=TravelModel();
    _travelModel = model;
    notifyListeners();
  }
 set hotelAndResortModel(HotelAndResortModel model) {
    model=HotelAndResortModel();
    _hotelAndResortModel = model;
    notifyListeners();
  }
  set loadingMgs(String val) {
    _loadingMgs = val;
    notifyListeners();
  }
  void cleartravelSpotList() {
    _travelSpotList.clear();
    notifyListeners();
  }
// void clearfavouriteSpotListt() {
//   _favouriteSpotList.clear();
//   notifyListeners();
// }
  /// add travel spot
  Future<void> addTravelSpot(
      BuildContext context,
      TravelModel travelModel,
      File imageFile) async {
    final int timestemp = DateTime.now().microsecondsSinceEpoch;
    String id = travelModel.spotname! + timestemp.toString();

    final String submitDate = DateFormat("dd-MMM-yyyy/hh:mm:aa")
        .format(DateTime.now());

    firebase_storage.Reference storageReference = firebase_storage
        .FirebaseStorage.instance.ref().child('Travel Spot Img').child(id);
    firebase_storage.UploadTask storageUploadTask = storageReference.putFile(imageFile);
    firebase_storage.TaskSnapshot taskSnapshot;
    storageUploadTask.then((value) {
      taskSnapshot = value;
      taskSnapshot.ref.getDownloadURL().then((newImageDownloadUrl) {
        final image = newImageDownloadUrl;
        FirebaseFirestore.instance.collection('travel_spots').doc(id).set({
          'id': id,
          'spotname': travelModel.spotname,
          'image': image,
          'description': travelModel.description,
          'travelregion': travelModel.travelregion,
          'travelspot': travelModel.travelspot,
          'latitude': travelModel.latitude,
          'longitude': travelModel.longitude,
          'timestemp': timestemp.toString(),
          'submitDate': submitDate.toString(),
        });
        Navigator.pop(context);
      }, onError: (error) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          error.toString(),
        )));
      });
    }, onError: (error) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        error.toString(),
      )));
    });
  }
/// add Hotel and resort
  Future<void> addHotelAndResort(
      BuildContext context,
      HotelAndResortModel hotelAndResortModel,
      File imageFile) async {
    final int timestamp = DateTime.now().microsecondsSinceEpoch;
    String hrid = timestamp.toString()+hotelAndResortModel.hrname!  ;

    final String submitDate = DateFormat("dd-MMM-yyyy/hh:mm:aa")
        .format(DateTime.now());

    firebase_storage.Reference storageReference = firebase_storage
        .FirebaseStorage.instance.ref().child('Hotel & Resort Img').child(hrid);
    firebase_storage.UploadTask storageUploadTask = storageReference.putFile(imageFile);
    firebase_storage.TaskSnapshot taskSnapshot;
    storageUploadTask.then((value) {
      taskSnapshot = value;
      taskSnapshot.ref.getDownloadURL().then((newImageDownloadUrl) {
        final image = newImageDownloadUrl;
        FirebaseFirestore.instance.collection('HotelAndResort').doc(hrid).set({
          'hrid': hrid,
          'hrname': hotelAndResortModel.hrname,
          'hrimage': image,
          'hraddress': hotelAndResortModel.hraddress,
          'hrdescription': hotelAndResortModel.hrdescription,
          'hrfacilities': hotelAndResortModel.hrfacilities,
          'travelregion': hotelAndResortModel.travelregion,
          'travelspot': hotelAndResortModel.travelspot,
          'latitude': hotelAndResortModel.latitude,
          'longitude': hotelAndResortModel.longitude,
          'timestamp': timestamp.toString(),
          'submitDate': submitDate.toString(),
        });
        Navigator.pop(context);
      }, onError: (error) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          error.toString(),
        )));
      });
    }, onError: (error) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        error.toString(),
      )));
    });
  }
/// Get travel spot
  Future<void> getTravelSpot(String travelspot) async {
    try {
      await FirebaseFirestore.instance
          .collection('travel_spots')
          .where('travelspot', isEqualTo: travelspot)
          .get()
          .then((snapShot) {
        _travelSpotList.clear();
        for (var element in snapShot.docChanges) {
          TravelModel travelModelss = TravelModel(
            id: element.doc['id'],
            spotname: element.doc['spotname'],
            image: element.doc['image'],
            description: element.doc['description'],
            travelregion: element.doc['travelregion'],
            travelspot: element.doc['travelspot'],
            latitude: element.doc['latitude'],
            longitude: element.doc['longitude'],
            timestemp: element.doc['timestemp'],
            submitDate: element.doc['submitDate'],
          );
          _travelSpotList.add(travelModelss);
        }
      });
      print("Length: " + _travelSpotList.length.toString());
      notifyListeners();
    } catch (error) {
      error.toString();
    }
  }
  /// Get Hotel And Resort
  Future<void> getHotelAndResort() async {
    try {
      await FirebaseFirestore.instance
          .collection('HotelAndResort')
          .where('hrid', isEqualTo: hotelAndResortModel.hrid)
          .get()
          .then((snapShot) {
        _hotelAndResortList.clear();
        for (var element in snapShot.docChanges) {
          HotelAndResortModel hotelAndResortModel = HotelAndResortModel(
            hrid: element.doc['hrid'],
            hrname: element.doc['hrname'],
            hrimage: element.doc['hrimage'],
            hraddress: element.doc['hraddress'],
            hrdescription: element.doc['hrdescription'],
            hrfacilities: element.doc['hrfacilities'],
            travelregion: element.doc['travelregion'],
            travelspot: element.doc['travelspot'],
            latitude: element.doc['latitude'],
            longitude: element.doc['longitude'],
            timestamp: element.doc['timestamp'],
            submitDate: element.doc['submitDate'],
          );
          _hotelAndResortList.add(hotelAndResortModel);
        }
      });
      print("Length: " + _hotelAndResortList.length.toString());
      notifyListeners();
    } catch (error) {
      print(error.toString());
    }
  }
  /// Get Hotel And Resort With Travel Spot
  Future<void> getHotelAndResortWithTravelSpot(String TravelSpot) async {
    try {
      await FirebaseFirestore.instance
          .collection('HotelAndResort')
          .where('travelspot', isEqualTo: hotelAndResortModel.travelspot)
          .get()
          .then((snapShot) {
        _hotelAndResortWithTravelSpotList.clear();
        for (var element in snapShot.docChanges) {
          HotelAndResortModel hotelAndResortModel = HotelAndResortModel(
            hrid: element.doc['hrid'],
            hrname: element.doc['hrname'],
            hrimage: element.doc['hrimage'],
            hraddress: element.doc['hraddress'],
            hrdescription: element.doc['hrdescription'],
            hrfacilities: element.doc['hrfacilities'],
            travelregion: element.doc['travelregion'],
            travelspot: element.doc['travelspot'],
            latitude: element.doc['latitude'],
            longitude: element.doc['longitude'],
            timestamp: element.doc['timestamp'],
            submitDate: element.doc['submitDate'],
          );
          _hotelAndResortWithTravelSpotList.add(hotelAndResortModel);
        }
      });
      print("Length: " + _hotelAndResortWithTravelSpotList.length.toString());
      notifyListeners();
    } catch (error) {
      print(error.toString());
    }
  }
  /// Get Favourite Travel Spots
  Future<void> getFavouriteSpot() async {
    try {
      await FirebaseFirestore.instance
          .collection('travel_spots')
          .where('id', isEqualTo: travelModel.id)
          .get()
          .then((snapShot) {
        _favouriteSpotList.clear();
        for (var element in snapShot.docChanges) {
          TravelModel travelModelss = TravelModel(
            id: element.doc['id'],
            spotname: element.doc['spotname'],
            image: element.doc['image'],
            description: element.doc['description'],
            travelregion: element.doc['travelregion'],
            travelspot: element.doc['travelspot'],
            latitude: element.doc['latitude'],
            longitude: element.doc['longitude'],
            timestemp: element.doc['timestemp'],
            submitDate: element.doc['submitDate'],
          );
          _favouriteSpotList.add(travelModelss);
        }
      });
      print("Length: " + _favouriteSpotList.length.toString());
      notifyListeners();
    } catch (error) {
      error.toString();
    }
  }
  // Future<void> getTravelSpot() async {
  //   try {
  //     await FirebaseFirestore.instance.collection('travel_spots')
  //         .where('id', isEqualTo: travelModel.id).get().then((snapShot) {
  //       _travelSpotList.clear();
  //       for (var element in snapShot.docChanges) {
  //         TravelModel travelModels = TravelModel(
  //           id: element.doc['id'],
  //           spotname: element.doc['spotname'],
  //           image: element.doc['image'],
  //           description: element.doc['description'],
  //           travelregion: element.doc['travelregion'],
  //           travelspot: element.doc['travelspot'],
  //           timestemp: element.doc['timestemp'],
  //           submitDate: element.doc['submitDate'],
  //         );
  //         _travelSpotList.add(travelModels);
  //       }
  //     });
  //     notifyListeners();
  //     print("Length: " + _travelSpotList.length.toString());
  //   } catch (error) {
  //     'error.toString()';
  //   }
  // }
}
