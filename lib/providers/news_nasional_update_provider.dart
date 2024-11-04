import 'dart:convert';
import 'package:news1_app/models/news_nasional_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsNasionalUpdateProvider with ChangeNotifier {
  List<NewsNasionalModel> _nasionalList = [];
  bool _isloading = false;

  List<NewsNasionalModel> get nasionalList => _nasionalList;
  bool get isLoading => _isloading;

  Future<void> fetchNewsNasional() async {
    _isloading = true;
    notifyListeners();

    final url =
        Uri.parse('https://api-berita-indonesia.vercel.app/cnn/nasional/');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        _nasionalList = [
          NewsNasionalModel.fromJson(data),
        ];
      }
    } catch (e) {
      rethrow;
    }
    _isloading = false;
    notifyListeners();
  }
}
