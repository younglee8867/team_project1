import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';

class stationController {
  final firestore = FirebaseFirestore.instance;

  getData() async{
     var result = await firestore.collection('station').doc('101').get();
     print(result);
  }

  @override
  void onInit(){
    //super.onInit();
    getData();
  }
}

