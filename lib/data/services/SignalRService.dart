import 'dart:developer';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:logging/src/logger.dart';
import 'package:signalr_netcore/signalr_client.dart' as signalr;
import '../../app/controller/controller.dart';
import '../../app/features/bottom_navigation_bar/bottom_bar_controller.dart';
import '../../app/features/chat/chat_controller.dart';
import '../enums/screen.dart';
import '../models/model.dart';
import 'services.dart';

class SignalRService {
  static const _chatURL = "https://cliverapi.azurewebsites.net/hubs/chat";
  static final SignalRService instance = SignalRService._initInstance();
  late signalr.HubConnection _hubConnection;
  final _chatController = Get.find<ChatController>();
  int _numberOfConnection = 0;

  //getter
  signalr.HubConnection get hubConnection => _hubConnection;

  SignalRService._initInstance();

  Future<void> startConnection() async {
    try {
      _numberOfConnection++;
      if (_numberOfConnection >= 20) {
        return;
      }
      _hubConnection = signalr.HubConnectionBuilder()
          .withUrl(
            _chatURL,
            options: signalr.HttpConnectionOptions(
              accessTokenFactory: getAccessToken,
              logger: Logger("SignalR - transport"),
            ),
          )
          .configureLogging(Logger("SignalR - hub"))
          .build();

      await _hubConnection.start();
      _chatController.isDisconnected.value = false;
      log("SignalR connection success: ${_hubConnection.state}");

      _hubConnection.onclose(({error}) {
        log("SignalRService error: $error");
        log("Connection closed");
        log("Restarting");
        _chatController.isDisconnected.value = true;
        startConnection();
      });

      _hubConnection.on('ReceiveMessage', (message) {
        Message? receivedMessage;
        try {
          receivedMessage =
              Message.fromJson(message![0] as Map<String, dynamic>);
          log("Receive message: ${receivedMessage.toJson()}");
          switch (_chatController.currentScreen.value) {
            case Screen.chatScreen:
              _chatController.roomId.value ??= receivedMessage.roomId;
              if (_chatController.post.value != null) {
                _chatController.post.value = null;
              }
              for (int i = _chatController.messages.length - 1; i >= 0; i--) {
                if (_chatController.messages[i].content ==
                        receivedMessage.content &&
                    _chatController.messages[i].id == null) {
                  _chatController.messages[i].isLoading.value = false;
                  _chatController.messages[i].isError.value = false;
                  _chatController.messages[i].id = receivedMessage.id;
                }
              }
              if(_chatController.senderId != receivedMessage.senderId) {
                _chatController.messages.add(receivedMessage);
              }
              for (int i = 0; i < _chatController.rooms.length; i++) {
                if (_chatController.rooms[i].id == receivedMessage.roomId) {
                  _chatController.rooms[i].lastMessage = receivedMessage;
                  _chatController
                          .lastMessages[_chatController.rooms[i].id as int] =
                      receivedMessage;
                  break;
                }
              }
              SchedulerBinding.instance.addPostFrameCallback(
                (_) => _chatController.scrollToEnd(),
              );
              break;
            case Screen.roomScreen:
              for (int i = 0; i < _chatController.rooms.length; i++) {
                if (_chatController.rooms[i].id == receivedMessage.roomId) {
                  _chatController.rooms[i].lastMessage = receivedMessage;
                  _chatController
                          .lastMessages[_chatController.rooms[i].id as int] =
                      receivedMessage;
                  _chatController.rooms[i].isReaded = false;
                  break;
                }
              }
              break;
            case Screen.bottomBarScreen:
              final bottomBarController = Get.find<BottomBarController>();
              bottomBarController.isHaveMessage.value = true;
              NotificationService.instance.showNotification(
                title: "New message",
                body: receivedMessage.content,
              );
              break;
            default:
          }
        } catch (e) {
          log("SignalRService receive message error: $e");
          for (int i = _chatController.messages.length - 1; i >= 0; i--) {
            if (_chatController.messages[i].content ==
                receivedMessage?.content) {
              _chatController.messages[i].isLoading.value = false;
              _chatController.messages[i].isError.value = true;
            }
          }
        }
      });
    } catch (e) {
      log("signalr connection error: $e");
      //if error then we try to connect again
      startConnection();
    }
  }

  Future<void> sendMessage(CreateMessage message) async {
    try {
      if (!_chatController.isDisconnected.value) {
        await _hubConnection.invoke(
          "SendMessageStr",
          args: [message.toJson()],
        );
      }
    } catch (e) {
      log("SignalRService send message error: $e");
    }
  }

  void disconnect() {
    _hubConnection.stop();
  }

  Future<String> getAccessToken() async {
    String token = Get.find<UserController>().userToken;
    if (token != "") {
      return token.substring(7);
    } else {
      return token;
    }
  }
}
