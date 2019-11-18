import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:time_tracker/models/job.dart';
import 'package:time_tracker/services/firestore_service.dart';
import 'package:time_tracker/utils/api_urls.dart';

abstract class  DataBase {
  Future<void> createJob(Job job);
  Stream<List<Job>> jobStream();
}

class FireBaseDataBase extends DataBase{
  final String uid;
  FireBaseDataBase({@required this.uid}) : assert(uid != null);
  final FirestoreService _firestoreService = FirestoreService.instance;

  @override
  Future<void> createJob(Job job) async{
    await _firestoreService.setData(
      path: APIURLS.job(uid, job.id),
      data: job.toMap()
    );
  }

  @override
  Stream<List<Job>> jobStream() {
    return _firestoreService.collectionStream(
      path: APIURLS.jobs(uid),
      builder: (data) => Job.fromMap(data)
    );
    
  }

}