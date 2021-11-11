class APIs {
  static const serverURL = 'http://localhost:4000';
  // static const serverURL = 'http://10.0.2.2:4000';
  static const loginAPI = '$serverURL/api/auth/login';
  static const registerAPI = '$serverURL/api/auth/register';
  static const getMeAPI = '$serverURL/api/auth/getme';

  static const getRoomsAPI = '$serverURL/api/rooms';
  static String getMessagesOfRoomAPI(String roomId) =>
      '$serverURL/api/room/$roomId/messages';

  static const websocketAPI = 'ws://localhost:4000/socket/websocket';
}
