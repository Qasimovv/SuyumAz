import 'package:flutter/material.dart';

class BaseModel with ChangeNotifier {
  BaseModel();

  Status status = Status.Idle;
  String error;

  setStatus(Status _status) {
    this.status = _status;
    notifyListeners();
  }

  setError(String _error, [Status _status]) {
    if (_error != null) {
      error = _error;
      status = Status.Error;
    } else {
      this.error = null;
      this.status = _status ?? Status.Idle;
    }
    notifyListeners();
  }
}

enum Status {
  Idle,
  Loading,
  Done,
  Error,
}
