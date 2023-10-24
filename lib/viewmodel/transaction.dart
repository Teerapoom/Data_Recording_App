import 'package:flutter/foundation.dart';
import 'package:flutter_databast/viewmodel/databast/transaction_db.dart';
import '../model/Transactions.dart'; //รูปแบบข้อมูล

// Proider ให้บริการข้อมูล
// ทำการเเจ้งเตือนเมื่อมีการเปลี่ยนแปลข้อมูล
class TransactionProider with ChangeNotifier {
  // ตัวอย่างข้อมูล
  List<Transactions> transactions = [];

  // get
  List<Transactions> gerTransaction() {
    return transactions;
  }

  // startdata
  void initData() async {
    var db = Transaction_db(dbName: "transactions.db");
    //ดึงข้อมูลมาแสดงผล
    transactions = await db.loadAllData();
    notifyListeners();
  }

  //post
  void addTransaction(Transactions statement) async {
    var db = Transaction_db(dbName: "transactions.db");
    //บันทึกข้อมูล
    await db.InsertData(statement);
    //ดึงข้อมูลมาแสดงผล
    transactions = await db.loadAllData();
    //แจ้งเตือน Consumer
    notifyListeners();
  }
}
