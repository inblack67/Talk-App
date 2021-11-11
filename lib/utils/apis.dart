class APIs {
  // static const serverHost = '10.0.2.2'; // for android emulator
  static const serverHost = 'localhost';
  static const serverURL = 'http://$serverHost:4000';
  static const loginAPI = '$serverURL/api/auth/login';
  static const registerAPI = '$serverURL/api/auth/register';
  static const getMeAPI = '$serverURL/api/auth/getme';

  static const getRoomsAPI = '$serverURL/api/rooms';
  static String getMessagesOfRoomAPI(String roomId) =>
      '$serverURL/api/room/$roomId/messages';

  static const websocketAPI = 'ws://$serverHost:4000/socket/websocket';
}
