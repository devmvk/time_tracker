import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreService {
   FirestoreService._();
   static FirestoreService instance = FirestoreService._();

   Future<void> setData({@required String path, @required Map<String, dynamic> data}) async{
     final DocumentReference documentReference = Firestore.instance.document(path);
     await documentReference.setData(data);
   }

   Stream<List<T>> collectionStream<T>({
    @required String path,
    @required T builder(Map<String, dynamic> data, String documentID),
    Query queryBuilder(Query query),
    int sort(T lhs, T rhs),
  }) {
    Query query = Firestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final Stream<QuerySnapshot> snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.documents
          .map((snapshot) => builder(snapshot.data, snapshot.documentID))
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

   Future<void> deleteData({@required String path}) async{
      final DocumentReference documentReference = Firestore.instance.document(path);
      await documentReference.delete();
   }

}