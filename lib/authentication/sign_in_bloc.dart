
import 'dart:async';

class SignInBloc{
  StreamController<bool> _isLoadingController = StreamController<bool>();
  Stream get isLoading => _isLoadingController.stream;

  void dispose(){
    _isLoadingController.close();
  }

  void setLoadingState(bool isLoading) => _isLoadingController.add(isLoading);
}