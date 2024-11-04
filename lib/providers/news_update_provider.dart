import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news1_app/models/news_update_model.dart';

class NewsUpdateProvider with ChangeNotifier {
  List<NewsUpdateModel> _newsList = [];
  bool _isloading = false;

  List<NewsUpdateModel> get newsList => _newsList;
  bool get isLoading => _isloading;

  Future<void> fetchNewsUpdate() async {
    _isloading = true;
    notifyListeners();

    final url =
        Uri.parse('https://api-berita-indonesia.vercel.app/cnn/terbaru/');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        _newsList = [
          NewsUpdateModel.fromJson(data),
        ];
      }
    } catch (e) {
      rethrow;
    }
    _isloading = false;
    notifyListeners();
  }
}
