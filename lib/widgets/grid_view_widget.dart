import 'package:flutter/material.dart';
import 'package:refactor_task/screens/info_detail_screen.dart';

import '../models/item_model.dart';
import 'package:get/get.dart';
//2 egneetei grid baidlaar medeelliig haruulah widget
class GridViewWidget extends StatelessWidget {
  final List<Item> data;
  const GridViewWidget(this.data,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(data[0].description);
    return  GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 8,
        childAspectRatio: 0.8,
      ),
      itemCount: data?.length ?? 0,
      itemBuilder: (context, index) {
        final item = data![index];
        return InkWell(
          onTap: (){
            //get ashiglan navigate hiiw
            Get.to(InfoDetailScreen(item));
          },
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(item.title ?? '',style: const TextStyle(color: Colors.black,fontSize: 15)),
                Text(item.description ?? '',style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        );
      },
    );
  }
}
