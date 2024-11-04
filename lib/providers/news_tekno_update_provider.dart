import 'dart:convert';
import 'package:news1_app/models/news_tekno_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsTeknoUpdateProvider with ChangeNotifier {
  List<NewsTeknoModel> _teknoList = [];
  bool _isloading = false;

  List<NewsTeknoModel> get teknoList => _teknoList;
  bool get isLoading => _isloading;

  Future<void> fetchNewsTekno() async {
    _isloading = true;
    notifyListeners();

    final url =
        Uri.parse('https://api-berita-indonesia.vercel.app/antara/tekno/');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        _teknoList = [
          NewsTeknoModel.fromJson(data),
        ];
      }
    } catch (e) {
      rethrow;
    }
    _isloading = false;
    notifyListeners();
  }
}
