import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UrlProvider extends ChangeNotifier {
  String baseUrl = 'https://api.shrtco.de/v2/shorten?url=';
  String url = '';
  String buttonTitle = 'SHORTEN IT!';

  var copyButtonStyleFirst = ElevatedButton.styleFrom(
      primary: Color(0xff2BD0D0),
      textStyle: TextStyle(fontWeight: FontWeight.bold));

  var copyButtonStyleLast = ElevatedButton.styleFrom(
      primary: Color(0xFF124E4E),
      textStyle: TextStyle(fontWeight: FontWeight.bold));

  List<String> _urlShortList = [];
  List<String> _urlLongList = [];
  List<int> _copyList = [];

  List<String> get urlShortList => _urlShortList;
  List<String> get urlLongList => _urlLongList;
  List<int> get copyList => _copyList;

  Future getShortUrl(url) async {
    buttonTitle = 'Load';
    String _url = baseUrl + url;
    var response = await Dio().get(_url);
    if (response.data != null) {
      _urlShortList.add(response.data['result']['full_short_link']);
      _urlLongList.add(response.data['result']['original_link']);
    }
    buttonTitle = 'SHORTEN IT!';
    notifyListeners();
  }

  void removeItem(int index) {
    _urlLongList.removeAt(index);
    _urlShortList.removeAt(index);
    notifyListeners();
  }

  void copyURL(int index) {
    _copyList = [];
    _copyList.add(index);
  }
}
