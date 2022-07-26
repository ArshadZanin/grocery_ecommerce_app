import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shop_grocery_app/core/constants.dart';
import 'package:shop_grocery_app/core/models/data_model.dart';
import 'package:shop_grocery_app/core/services/http_service.dart';
import 'package:stacked/stacked.dart';

class CartViewModel extends BaseViewModel {
  List<DataModel> _data = [];
  List<int> _selectedData = [];

  double _amount = 0;

  List<DataModel> get data => _data;
  set data(List<DataModel> value) {
    _data = value;
    notifyListeners();
  }

  List<int> get selectedData => _selectedData;
  set selectedData(List<int> value) {
    _selectedData = value;
    notifyListeners();
  }

  double get amount => _amount;
  set amount(double value) {
    _amount = value;
    notifyListeners();
  }

  void calculateAmount() {
    amount = 0;
    for (var i = 0; i < data.length; i++) {
      amount = amount + (data[i].price!.toDouble() * selectedData[i]);
    }
    notifyListeners();
  }

  Future initialize({required List<DataModel> cartData}) async {
    data = cartData;
    selectedData = List.generate(data.length, (index) => 1);
    calculateAmount();
    notifyListeners();
  }
}
