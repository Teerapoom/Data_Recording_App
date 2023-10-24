import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../model/Transactions.dart';
import '../../viewmodel/transaction.dart';



class HomeShow extends StatefulWidget {
  const HomeShow({super.key});

  @override
  State<HomeShow> createState() => _HomeShowState();
}

class _HomeShowState extends State<HomeShow> {

   // startdata
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<TransactionProider>(context, listen: false).initData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('รายการบันทึกข้อมูล'),
          actions: [
            IconButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                icon: const Icon(Icons.exit_to_app))
          ],
        ),
        //Consumer รับข้อมูล // provider คือสิ่งที่ต้องทำงาน รับข้อมาจากหน้า viewmodel
        body: Consumer(
          builder: (context, TransactionProider provider, child) {
            var count = provider.transactions.length;
            if (count <= 0) {
              return const Center(
                child: Text('ไม่พบข้อมูล'),
              );
            } else {
              return ListView.builder(
                  itemCount: provider.transactions.length,
                  itemBuilder: ((context, index) {
                    Transactions data = provider.transactions[
                        index]; //ดึงข้อมูลมาที่ละตัว_ไม่ต้องเขียนเยอะ index คือแต่ละช่อง
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 10),
                      elevation: 1.5, // เงา
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 25,
                          child: FittedBox(
                            child: Text('${data.amount}'),
                          ),
                        ),
                        title: Text(data.title),
                        subtitle: Text(DateFormat('dd/MM/yy').format(data.data)),
                      ),
                    );
                  }));
            }
          }, // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}