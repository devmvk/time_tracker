import 'package:meta/meta.dart';
import 'package:time_tracker/models/entry.dart';
import 'package:time_tracker/models/job.dart';
import 'package:time_tracker/services/firestore_service.dart';
import 'package:time_tracker/utils/api_urls.dart';

abstract class  DataBase {
  Future<void> createJob(Job job);
  Stream<List<Job>> jobStream();
  Future<void> deleteJob(Job job);

  Future<void> setEntry(Entry entry);
  Future<void> deleteEntry(Entry entry);
  Stream<List<Entry>> entriesStream({Job job});
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
      builder: (data, documentId) => Job.fromMap(data)
    );
    
  }

  Future<void> deleteJob(Job job) async{
    await _firestoreService.deleteData(path: APIURLS.job(uid, job.id));
  }

  @override
  Future<void> setEntry(Entry entry) async => await _firestoreService.setData(
    path: APIURLS.entry(uid, entry.id),
    data: entry.toMap(),
  );

  @override
  Future<void> deleteEntry(Entry entry) async => await _firestoreService.deleteData(path: APIURLS.entry(uid, entry.id));

  @override
  Stream<List<Entry>> entriesStream({Job job}) => _firestoreService.collectionStream<Entry>(
    path: APIURLS.entries(uid),
    queryBuilder: job != null ? (query) => query.where('jobId', isEqualTo: job.id) : null,
    builder: (data, documentID) => Entry.fromMap(data, documentID),
    sort: (lhs, rhs) => rhs.start.compareTo(lhs.start),
  );

}