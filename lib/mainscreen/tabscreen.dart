import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.blue,
      width: 200,
      height: 300,
      child: ContainedTabBarView(
        tabs: [
          Text('First'),
          Text('Second'),
        ],
        views: [Container(color: Colors.red), Container(color: Colors.green)],
        onChange: (index) => print(index),
      ),
    );
  }
}
