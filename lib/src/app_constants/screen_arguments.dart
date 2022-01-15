import 'package:wisdom/src/data_models/vos/fun_list_vo.dart';

class FunDetailScreenArguments {
  final FunItem funItem;
  final int currentSelectedFunPosition;

  FunDetailScreenArguments(this.funItem, this.currentSelectedFunPosition);
}