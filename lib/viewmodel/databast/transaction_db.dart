// จัดฟอมข้อมูล

import 'dart:io';
import 'package:flutter_databast/model/Transactions.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Transaction_db {
  String dbName = '';

  Transaction_db({required this.dbName});

  // <reture อะไรออกไป>
  Future<Database> openDatabase() async {
    //หาตำแหน่งที่จะเก็บข้อมูล
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbName);
    // สร้าง database
    DatabaseFactory dbFactory = await databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  //บันทึกข้อมูล DB => store transactions.db/expense
  Future<int> InsertData(Transactions statement) async {
    //สร้าง store
    var db = await openDatabase(); // this ใช้ได้เพราะอยู่ใน class
    var store = intMapStoreFactory.store('expense'); //สร้างหัวตาราง

    //json -> ใส่ข้อมูล
    var keyID = store.add(db, {
      'title': statement.title,
      'amount': statement.amount,
      'date': statement.data.toIso8601String()
    });
    db.close();
    return keyID;
  }

  // getdata
  // ใหม่ => เก่า false มาก => น้อย *Field
  // เก่า => ใหม่ true น้อย => มาก *Field
  Future<List<Transactions>> loadAllData() async {
    var db = await openDatabase();
    var store = intMapStoreFactory.store('expense'); //สร้างหัวตาราง *เก็บข้อมูลแบบ Map
    var snapshot = await store.find(db,
    finder: Finder(sortOrders: [SortOrder(Field.key, true)])); //ค้นหาใน Databast

    List<Transactions> transactionlist = [];

    for (var record in snapshot) {
      String? title = record['title'] as String?;
      double? amount = record['amount'] as double?;
      // Parse the 'date' field from String to DateTime
      DateTime? date;
      if (record['date'] is String) {
        date = DateTime.tryParse(record['date'] as String);
      }
      if (title != null && amount != null && date != null) {
        transactionlist.add(Transactions(
          title: title,
          amount: amount,
          data: date,
        ));
      }
    }
    return transactionlist;
  }
}


/*
คำอธิบาย
ถ้ายังไม่ถูกสร้าง => สร้าง 
ถูกสร้างไว้แล้ว => เปิด
*/