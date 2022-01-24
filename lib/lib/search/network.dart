import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:helo/addOn/myURL.dart';
import 'package:helo/search/post.dart';

class Network {
  static Future<List<Post>> getPost(String search) async {
    final url = '${MyUrl().domain}/chanthip/whereOrder.php?isAdd=true';

    final response = await Dio().get(url);
    if (response.statusCode == 200) {
      final List postes = json.decode(response.data);

      return postes.map((json) => Post.fromJson(json)).where((postes) {
        final titleLower = postes.date.toLowerCase();
        final authorLower = postes.work.toLowerCase();
        final searchLower = search.toLowerCase();

        return titleLower.contains(searchLower) ||
            authorLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
