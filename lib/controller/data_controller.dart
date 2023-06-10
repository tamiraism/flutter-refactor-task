import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hive/hive.dart';
import 'package:sqflite/sqflite.dart';

import '../models/item_model.dart';
import 'package:http/http.dart' as http;

class DataModel extends GetxController {
  static const dbName='my_db';
  static const tableName='table_real';
  final _itemsController = StreamController<List<Item>>.broadcast();
  Stream<List<Item>> get itemsStream => _itemsController.stream;

  DataModel() {
    _initDatabase();
  }
  //database iig uusgeh table uusgeh func
  Future<void> _initDatabase() async {
    final box = Hive.box(dbName);
    if (!box.containsKey(tableName)) {
      await box.put(tableName, []);
    }
    insertTabledata();
    fetchItemsFromHive();
  }
  //table hooson uyd data nemj ogno
  //neg nemsen bol dahij nemehgui
  void insertTabledata() async {
    final box = Hive.box(dbName);

    final List<dynamic> data = box.get(tableName, defaultValue: []);
    if(data.isEmpty){
      for (int i = 0; i < 30; i++) {
        final newRow = {'id':i,'title': 'baited $i','body': 'body $i'};
        print(newRow);
        data.add(newRow);
      }

      await box.put(tableName, data);
    }
  }
  //buh datag ustgah func
  void deleteTabledata() async {
    final box = Hive.box(dbName);
    await box.delete(tableName);

  }
  //db ees datanuudaa tatah heseg
  Future<void> fetchItemsFromHive() async {
    final box = Hive.box(dbName);
    const table = tableName;

    final List<dynamic> data = await box.get(table, defaultValue: []);
    final List<Item> itemList = data.map((item) => Item.fromJson(item)).toList();

    _itemsController.add(itemList);
  }

  //api service ees data tatah heseg
  Future<void> fetchAndStoreItems() async {
    final response =
    await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      final itemList = data.map((item) => Item.fromJson(item)).toList();
      _itemsController.add(itemList);
    } else {
      _itemsController.addError('Failed to fetch data from API');
    }
  }

  @override
  Future<void> dispose() async {
    _itemsController.close();
    super.dispose();
  }
}