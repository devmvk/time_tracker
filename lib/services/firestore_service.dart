import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreService {
   FirestoreService._();
   static FirestoreService instance = FirestoreService._();

   Future<void> setData({String path, Map<String, dynamic> data}) async{
     final DocumentReference documentReference = Firestore.instance.document(path);
     await documentReference.setData(data);
   }

   Stream<List<T>> collectionStream<T>({
     @required String path,
     @required T builder(Map<String, dynamic> data)
   }){
     final CollectionReference collectionReference = Firestore.instance.collection(path);
    final snapshots = collectionReference.snapshots();
    return snapshots.map((snapshot){
      return snapshot.documents.map((item){{
        return builder(item.data);
      }}).toList();
    });
   }

}