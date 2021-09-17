// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:takeoff_fintech_app/socket_listeners/web_socket.dart';

class SocketApiUi extends StatefulWidget {
  const SocketApiUi({Key? key}) : super(key: key);

  @override
  _SocketApiUiState createState() => _SocketApiUiState();
}

class _SocketApiUiState extends State<SocketApiUi> {
  TextEditingController sendTextEditingController = new TextEditingController();
  WebSocketIo _webSocketIo = new WebSocketIo();

  List socketData = [];
  int index = 0;
  ScrollController scrollController = new ScrollController();
  IO.Socket socket = IO.io('https://convey.in:3402',
      IO.OptionBuilder().setTransports(['websocket']).build());
  @override
  void initState() {
    socket.onConnect((_) {
      print('connected to server');
    });

    socket.onConnecting((data) => print(data));
    socket.onError((data) => print("Error:" + data));
    try {
      socket.on('500400', (data) {
        _webSocketIo.setData(data);
        socketData.insert(index, data);
        index++;
        print(data);
      });
    } catch (e) {
      print(e);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _webSocketIo.getdata() as Stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: socketData.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(socketData[index].toString()),
                    );
                  },
                ),
              )
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}
