import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/model/travel_model.dart';

class TravelProvider extends ChangeNotifier {
  TravelModel _travelModel = TravelModel();
  List<TravelModel> _travelSpotList = [];
  List<TravelModel> _favouriteSpotList = [];

  String? _loadingMgs;

  TravelModel get travelModel => _travelModel;

  get travelSpotList => _travelSpotList;

  get favouriteSpotList => _favouriteSpotList;

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
