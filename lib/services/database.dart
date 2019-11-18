abstract class  DataBase {
  
}

class FireBaseDataBase extends DataBase{
  final String uid;
  FireBaseDataBase({this.uid}) : assert(uid != null);
}