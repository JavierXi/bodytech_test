import 'dart:convert';
import 'package:bodytech/second_tab/models/item_model.dart';
import 'package:http/http.dart' as http;

class ItemsApi {
  static Future<List<Item>> getItems() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List items = json.decode(response.body);
      return items.map((json) => Item.fromJson(json)).toList();
    } else {
      throw Exception();
    }
  }
}
