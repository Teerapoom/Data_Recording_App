import 'package:flutter/material.dart';
import 'package:flutter_databast/viewmodel/transaction.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../model/Transactions.dart';

class FormPage extends StatelessWidget {
  const FormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final fromKey = GlobalKey<FormState>();
    final titleCon = TextEditingController();
    final amountCon = TextEditingController();
    return Scaffold(
      appBar: AppBar(
          title: const Text('แบบฟอมข้อมูลบันทึกข้อมูล'),
          backgroundColor: Colors.deepPurple.shade200),
      body: Padding(
        padding: EdgeInsets.all(10.0.px),
        child: Form(
            key: fromKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'ชื่อรายการ'),
                  autofocus: false, //โฟชักตัวที่จะให้ใส่
                  validator: (String? str) {
                    if (str == null || str.isEmpty) {
                      return "กรอกข้อมูลรายให้ครบถ้วน";
                    }
                    return null;
                  },
                  controller: titleCon,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'จำนวนเงิน'),
                  keyboardType: TextInputType.number,
                  validator: (String? str) {
                    if (str == null || str.isEmpty) {
                      return "กรอกข้อมูลจำนวนเงินให้ครบถ้วน";
                    }
                    if (double.parse(str) <= 0) {
                      return "กรอกข้อมูลจำนวนเงินให้ถูกต้อง";
                    }
                    return null;
                  },
                  controller: amountCon,
                ),
                FilledButton(
                  onPressed: () {
                    // fromKey.currentState เข้าถึงสถานะของ form -> ว่างเป็น  false
                    if (fromKey.currentState?.validate() ?? false) {
                      var title = titleCon.text;
                      var amount = amountCon.text;

                      // เตรียมข้อมูล
                      Transactions statement = Transactions(
                          title: title,
                          amount: double.parse(amount), //แปลงข้อมูลก่อน
                          data: DateTime.now());
                      //Transaction ถ้าอยู่ข้างหน้าคือชนิดข้อมูล //เรียก Provider
                      var provider = Provider.of<TransactionProider>(context,
                          listen: false);
                      provider.addTransaction(statement);
                      Navigator.pop(context);
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  child: const Text(
                    'เพิ่มข้อมูล',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
