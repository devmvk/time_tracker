import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:time_tracker/models/job.dart';
import 'package:time_tracker/utils/api_urls.dart';

abstract class  DataBase {
  Future<void> createJob(Job job);
}

class FireBaseDataBase extends DataBase{
  final String uid;
  FireBaseDataBase({@required this.uid}) : assert(uid != null);

  @override
  Future<void> createJob(Job job) async{
    final String path = APIURLS.job(uid, job.id);
    final DocumentReference documentReference = Firestore.instance.document(path);
    await documentReference.setData(job.toMap());
  }

}