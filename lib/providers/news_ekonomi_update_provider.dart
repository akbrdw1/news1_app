import 'dart:convert';
import 'package:news1_app/models/news_ekonomi_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsEkonomiUpdateProvider with ChangeNotifier {
  List<NewsEkonomiModel> _ekonomiList = [];
  bool _isloading = false;

  List<NewsEkonomiModel> get ekonomiList => _ekonomiList;
  bool get isLoading => _isloading;

  Future<void> fetchNewsEkonomi() async {
    _isloading = true;
    notifyListeners();

    final url =
        Uri.parse('https://api-berita-indonesia.vercel.app/cnn/ekonomi/');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        _ekonomiList = [
          NewsEkonomiModel.fromJson(data),
        ];
      }
    } catch (e) {
      rethrow;
    }
    _isloading = false;
    notifyListeners();
  }
}
