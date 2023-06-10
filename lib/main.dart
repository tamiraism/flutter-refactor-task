import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:refactor_task/widgets/grid_view_widget.dart';
import 'package:refactor_task/widgets/list_view_widget.dart';

import 'controller/data_controller.dart';
import 'models/item_model.dart';

//android emulator bolon chrome browser deer test hiisen.

Future<void> main() async {
  //hive init bolo database ruugee newtreh heseg
  await Hive.initFlutter();
  await Hive.openBox('my_db');
  runApp(
    GetMaterialApp(
      title: 'Refactor Task App',
      //anh ajillahdaa light modetoi ehlene systemiin mode oo awsan ch bolhoor bsn ch zalhuuraw.
      theme: ThemeData.light(),
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //main delgets
    return MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //odor shoniin toggle d ashiglah view bolon bool utguud
  final List<bool> _selectedMode = <bool>[false, true];
  static const List<Widget> modes = <Widget>[
    Icon(Icons.dark_mode),
    Icon(Icons.light_mode),
  ];

  //grid list toggle d ashiglah view bolon bool utguud
  final List<bool> _selectedViewMode = <bool>[true, false];
  static const List<Widget> viewModes = <Widget>[
    Icon(Icons.list),
    Icon(Icons.grid_on),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DataModel>(
      init: DataModel(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(title: const Text('Refactor Task App')),
          body: StreamBuilder<List<Item>>(
            stream: controller.itemsStream,
            builder: (context, snapshot) {
              print('jaylaw');
              print(snapshot.hasData);
              print(snapshot.data);
              if (snapshot.hasData) {
                //selectedViewMode iin ehnii bool utgaas shaltgaalan aliig ni haruulahaa shiidne
                return _selectedViewMode[0]
                    ? ListViewWidget(snapshot.data!!)
                    : GridViewWidget(snapshot.data!!);
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          floatingActionButton:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Container(
                color: Colors.black,
                child: ToggleButtons(
                  onPressed: (int index) {
                    // light bolon dark view hoorond shiljih toggle get changeTheme ashiglan shiljine
                    setState(() {
                      for (int i = 0; i < _selectedMode.length; i++) {
                        i == index
                            ? _selectedMode[i] = true
                            : _selectedMode[i] = false;
                      }
                    });

                    _selectedMode[0]
                        ? Get.changeTheme(ThemeData.dark())
                        : Get.changeTheme(ThemeData.light());
                  },
                  isSelected: _selectedMode,
                  children: modes,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  borderWidth: 0,
                  borderColor: Colors.black,
                  selectedColor: Colors.white,
                  fillColor: Colors.tealAccent,
                  color: Colors.white,
                ),
              ),
            ),
            FloatingActionButton(
              //app anh ajillahdaa db ees datagaa awsnaa ene towch daragdahad api aas data awj bn
              onPressed: controller.fetchAndStoreItems,
              tooltip: 'Fetch Data',
              child: const Icon(Icons.refresh),
            ),
            Container(
              color: Colors.black,
              child: ToggleButtons(
                onPressed: (int index) {
                  // grid bolon list view hoorond shiljih toggle
                  setState(() {
                    for (int i = 0; i < _selectedViewMode.length; i++) {
                      i == index
                          ? _selectedViewMode[i] = true
                          : _selectedViewMode[i] = false;
                    }
                  });
                },
                isSelected: _selectedViewMode,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                borderWidth: 0,
                borderColor: Colors.black,
                selectedColor: Colors.white,
                fillColor: Colors.tealAccent,
                color: Colors.white,
                children: viewModes,
              ),
            ),
          ]),
        );
      },
    );
  }
}
