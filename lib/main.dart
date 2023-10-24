import 'package:flutter/material.dart';
import 'package:flutter_databast/view/Screen/form.dart';

import 'package:flutter_databast/view/Screen/home.dart';

import 'package:provider/provider.dart';

import 'viewmodel/transaction.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return TransactionProider();
        }),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'แอพบัชญี'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.blue,
          body: TabBarView(children: [HomeShow(), FormPage()]),
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.list),
                  SizedBox(width: 5),
                  Text('รายการ')
                ],
              )),
              Tab(
                child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Icon(Icons.add),
                SizedBox(width: 5),
                Text('เพิ่มข้อมูล')
              ]))
            ],
            labelColor: Colors.white, 
            indicatorColor: Colors.white,
          ),
        ));
  }
}
