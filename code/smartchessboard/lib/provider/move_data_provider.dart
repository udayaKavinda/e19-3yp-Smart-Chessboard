import 'package:flutter/material.dart';
import 'package:smartchessboard/models/short_move.dart';

class MoveDataProvider extends ChangeNotifier {
  ShortMove _shortMoveData = ShortMove(from: "a1", to: "b1"); //

  ShortMove? get shortMoveData => _shortMoveData;

  void updateMoveData(Map<String, dynamic> data) {
    _shortMoveData = ShortMove.fromJson(data);
    notifyListeners();
  }
}
