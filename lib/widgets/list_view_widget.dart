import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/item_model.dart';
import '../screens/info_detail_screen.dart';
//list baidlaar medeelliig haruulah widget
class ListViewWidget extends StatelessWidget {
  final List<Item> data;
  const ListViewWidget(this.data,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data?.length ?? 0,
      itemBuilder: (context, index) {
        final item = data![index];
        return InkWell(
          onTap: (){
            //get ashiglan navigate hiiv
            Get.to(InfoDetailScreen(item));
          },
          child: ListTile(
            title:
            Text(item.title ?? '',style: const TextStyle(color: Colors.black,fontSize: 15),),
            subtitle: Text(item.description ?? ''),
          ),
        );
      },
    );
  }
}
