import 'package:bodytech/second_tab/models/item_model.dart';
import 'package:bodytech/second_tab/screens/details.dart';
import 'package:bodytech/widgets/items_api.dart';
import 'package:flutter/material.dart';

class SecondTab extends StatefulWidget {
  const SecondTab({Key? key}) : super(key: key);

  @override
  _SecondTabState createState() => _SecondTabState();
}

class _SecondTabState extends State<SecondTab> {
  late List<Item> items = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    final items = await ItemsApi.getItems();
    setState(() {
      this.items = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('SECOND TAB'),
        flexibleSpace: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Color(0xfff86d66),
                Color(0xffe0702a),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) =>
                  const Divider(color: Colors.grey),
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return buildItem(item);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(Item item) => ListTile(
        title: Text(item.title.toUpperCase()),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Details(
                userId: item.userId,
                id: item.id,
                title: item.title,
                body: item.body,
              ),
            ),
          );
        },
      );
}
