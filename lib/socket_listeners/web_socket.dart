import 'dart:async';

class WebSocketIo {
  StreamController streamController = new StreamController<dynamic>();

  void setData(dynamic data) {
    streamController.sink.add(data);
  }

  dynamic getdata() {
    return streamController.stream;
  }
}
