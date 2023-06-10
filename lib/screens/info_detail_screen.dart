import 'package:flutter/material.dart';

import '../models/item_model.dart';
//medeelliin detailiig haruulah delgets
//medeelliig omnoh delgetseesee param aar awna
class InfoDetailScreen extends StatelessWidget {
  final Item data;
  const InfoDetailScreen(this.data,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(data.title!!)),
        body: Text(data.description!!));
  }
}
