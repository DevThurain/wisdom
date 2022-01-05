import 'package:flutter/cupertino.dart';

class BaseViewModel with ChangeNotifier {
  ViewState _state = ViewState.LOADING;

  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}

enum ViewState{
  LOADING,
  COMPLETE,
  ERROR,
  NO_INTERNET,
}
