import 'package:flutter/material.dart';
import 'package:takeoff_fintech_app/modules/home/nav/ui_rest_api.dart';
import 'package:takeoff_fintech_app/modules/home/nav/ui_socket_api.dart';
import 'package:takeoff_fintech_app/socket_listeners/web_socket.dart';

class HomePage extends StatefulWidget {
  final String? title;
  HomePage({this.title});

  @override
  _HomePageState createState() => _HomePageState(title!);
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  late double width;
  late double height;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  final String title;
  _HomePageState(this.title);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(title),
            bottom: TabBar(
              controller: _tabController,
              tabs: [
                Tab(
                  child: Text(
                    'Socket API',
                  ),
                ),
                Tab(
                  child: Text(
                    'Rest API',
                  ),
                ),
              ],
            )),
        body: TabBarView(controller: _tabController, children: [
          Container(child: SocketApiUi()),
          Container(child: ShowImagesUi())
        ]));
  }
}
