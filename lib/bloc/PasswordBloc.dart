import 'dart:async';

import 'package:cipherly/database/Database.dart';
import 'package:cipherly/model/PasswordModel.dart';

class PasswordBloc {
  PasswordBloc() {
    getPasswords();
  }
  final _passwordController = StreamController<List<Password>>.broadcast();
  get passwords => _passwordController.stream;

  dispose() {
    _passwordController.close();
  }

  getPasswords() async {
    _passwordController.sink.add(await DBProvider.db.getAllPasswords());
  }

  add(Password password) {
    DBProvider.db.newPassword(password);
    getPasswords();
  }
  update(Password password) {
    DBProvider.db.updatePassword(password);
    getPasswords();
  }
  delete(int id) {
    DBProvider.db.deletePassword(id);
    getPasswords();
  }

  deleteAll() {
    DBProvider.db.deleteAll();
    getPasswords();
  }
}
