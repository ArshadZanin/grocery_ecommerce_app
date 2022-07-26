import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shop_grocery_app/core/constants.dart';
import 'package:shop_grocery_app/core/models/data_model.dart';
import 'package:shop_grocery_app/core/services/http_service.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final HTTPService? httpService;

  HomeViewModel({
    required this.httpService,
  });

  List<DataModel> _data = [];
  List<DataModel> _selectedData = [];

  String _name = "";

  List<DataModel> get data => _data;
  set data(List<DataModel> value) {
    _data = value;
    notifyListeners();
  }

  List<DataModel> get selectedData => _selectedData;
  set selectedData(List<DataModel> value) {
    _selectedData = value;
    notifyListeners();
  }

  String get name => _name;
  set name(String value) {
    _name = value;
    notifyListeners();
  }

  Future initialize() async {
    await getDatas();
  }

  Future<void> getDatas() async {
    Response response = await httpService!.makeGetRequest(url: Constants.LINK);
    if (response.statusCode == 200) {
      List<dynamic> dataList = jsonDecode(response.body);
      data = dataList.map((e) => DataModel.fromJson(e)).toList();
    } else {
      print('error');
    }
    for (var element in data) {
      print(element.title);
    }
    notifyListeners();
  }
}
