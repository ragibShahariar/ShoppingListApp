import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'dart:math';

DateFormat formatter = DateFormat.yMd();
const uuid = Uuid();

class ShopingItemModel {
  ShopingItemModel(
    this.itemName, 
    this.itemPrice, 
    this.date, 
    this.itemQuantity,
      )
      : itemID = uuid.v4(), itemColor = _randomColor();

  final String itemName;
  final double itemPrice;
  final int itemQuantity;
  final DateTime date;
  final String itemID;
  final Color itemColor;

  static Color _randomColor(){
    Color randomColor = Color.fromARGB(255, 
    Random().nextInt(256),
    Random().nextInt(256),
    Random().nextInt(256),);
    return randomColor;
  }

  String get formattedDate{
    return formatter.format(date);
  }
}
