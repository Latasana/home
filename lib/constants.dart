import 'package:flutter/material.dart';

dynamic getResWidth(context,value){
  dynamic xsize = (MediaQuery.of(context).size * value);
  return xsize;
}