import 'dart:async';
import 'dart:io';
// ignore: implementation_imports
import 'package:sembast/src/store_ref_impl.dart' as x;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class DBService {
  DatabaseFactory _dbFactory = databaseFactoryIo;
  static final DBService _instance = DBService._();

  DBService._();

  factory DBService() => _instance;
  Database _db;
  Future openDb() async {
    if (_db == null) {
      const String _dbPath = "/data.db";
      final _dbPathLocal =
          (await getApplicationDocumentsDirectory()).path + _dbPath;
      _db = await _dbFactory.openDatabase(_dbPathLocal,
          mode: DatabaseMode.neverFails);
    }
  }

  Future<DBResponse> addItem(
      {@required String itemKey,
      @required String collection,
      @required Map<String, dynamic> itemValue}) async {
    DBResponse _response;
    try {
      await openDb();
      final _store = stringMapStoreFactory.store(collection);
      await _store.record(itemKey).put(_db, itemValue);
      _response = DBResponse(status: Status.SUCCESS);
    } catch (e) {
      _response = DBResponse(status: Status.ERROR, error: e.toString());
    }
    return _response;
  }

  Future<DBResponse> getAllItems({@required String collection}) async {
    DBResponse _response;
    try {
      await openDb();
      final _store = stringMapStoreFactory.store(collection);
      List<RecordSnapshot<String, Map<String, dynamic>>> _jsonData =
          await _store.find(_db);
      _response = DBResponse(
          status: Status.SUCCESS,
          data: _jsonData.map((record) => record.value).toList());
    } catch (e) {
      _response = DBResponse(status: Status.ERROR, error: e.toString());
    }

    return _response;
  }

  Future<DBResponse> getItem({
    @required String itemKey,
    @required String collection,
  }) async {
    DBResponse _response;
    try {
      await openDb();
      final _store = stringMapStoreFactory.store(collection);
      Map<String, dynamic> _jsonData = await _store.record(itemKey).get(_db);
      _response = DBResponse(status: Status.SUCCESS, data: _jsonData);
    } catch (e) {
      _response = DBResponse(status: Status.ERROR, error: e.toString());
    }
    print("response ${_response.data}");

    return _response;
  }

  delete() async {
    await openDb();
    File file = File(_db.path);
    file.deleteSync();
  }

  Future<DBResponse> deleteItem({
    @required String itemKey,
    @required String collection,
  }) async {
    DBResponse _response;
    try {
      await openDb();
      final _store = stringMapStoreFactory.store(collection);
      await _store.record(itemKey).delete(_db);
      _response = DBResponse(status: Status.SUCCESS);
    } catch (e) {
      _response = DBResponse(status: Status.ERROR, error: e.toString());
    }
    return _response;
  }

  Future<DBResponse> updateItem({
    @required String itemKey,
    @required Map<String, dynamic> newValue,
    @required String collection,
  }) async {
    DBResponse _response;
    try {
      await openDb();
      final _store = stringMapStoreFactory.store(collection);
      await _store.record(itemKey).update(_db, newValue);
      _response = DBResponse(status: Status.SUCCESS);
    } catch (e) {
      _response = DBResponse(status: Status.ERROR, error: e.toString());
    }
    return _response;
  }

  Future<DBResponse> putString(
      {@required String key, @required String value}) async {
    DBResponse _response;
    try {
      await openDb();
      final _store =
          x.StoreFactoryBase<String, String>().store("shared_preferences");
      await _store.record(key).put(_db, value);
      _response = DBResponse(status: Status.SUCCESS);
    } catch (e) {
      _response = DBResponse(status: Status.ERROR, error: e.toString());
    }
    return _response;
  }

  Future<DBResponse> getString({
    @required String key,
  }) async {
    DBResponse _response;
    try {
      await openDb();
      final _store =
          x.StoreFactoryBase<String, String>().store("shared_preferences");
      String value = await _store.record(key).get(_db);
      _response = DBResponse(status: Status.SUCCESS, data: value);
    } catch (e) {
      _response = DBResponse(status: Status.ERROR, error: e.toString());
    }
    return _response;
  }

  Future<DBResponse> moveItem(
      {@required String fromCollection,
      @required String toCollection,
      @required String itemKey}) async {
    DBResponse _response;
    try {
      await openDb();
      final fromStore = stringMapStoreFactory.store(fromCollection);
      final toStore = stringMapStoreFactory.store(toCollection);
      await _db.transaction((transaction) async {
        Map<String, dynamic> itemToMove =
            await fromStore.record(itemKey).get(transaction);
        if (itemToMove != null) {
          await toStore.record(itemKey).put(transaction, itemToMove);
          await fromStore.record(itemKey).delete(transaction);
        }
      });
      _response = DBResponse(status: Status.SUCCESS);
    } catch (e) {
      _response = DBResponse(status: Status.ERROR, error: e.toString());
    }
    return _response;
  }

  create(dbItems) async {
    final allItems = await getAllItems(collection: "catalogue");
    print(allItems.error);
    if (allItems.data == null || allItems.data.length < 15) {
      for (final key in dbItems.keys) {
        await addItem(
            itemKey: key,
            collection: "catalogue",
            itemValue: {"id": key, "selectedIndex": dbItems[key]["index"]});
      }
    }
  }
}

class DBResponse {
  final Status status;
  final String error;
  final data;

  DBResponse({this.status, this.error, this.data});
}

enum Status { SUCCESS, ERROR }
