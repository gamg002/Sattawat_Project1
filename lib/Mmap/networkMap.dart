import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helo/Mmap/map_model.dart';
import 'package:helo/addOn/myURL.dart';

class networkMap {
  static Future<List<map_model>> getPost(String searchmap) async {
    final url = '${MyUrl().domain}/chanthip/getWhereCostomer.php?isAdd=true';

    final response = await Dio().get(url);
    if (response.statusCode == 200) {
      final List postes = json.decode(response.data);

      return postes.map((json) => map_model.fromJson(json)).where((postes) {
        final titleLower = postes.name.toLowerCase();
        final authorLower = postes.other.toLowerCase();
        final searchLower = searchmap.toLowerCase();

        return titleLower.contains(searchLower) ||
            authorLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
