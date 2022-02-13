class APIs {
  // static const serverHost = 'talk.gigalixirapp.com';
  // static const serverHost = '10.0.2.2:4000'; // for android emulator
  static const serverHost = 'localhost:4000';
  static const serverURL = 'http://$serverHost';
  static const loginAPI = '$serverURL/api/auth/login';
  static const registerAPI = '$serverURL/api/auth/register';
  static const getMeAPI = '$serverURL/api/auth/getme';

  // static const getRoomsAPI = '$serverURL/api/rooms';
  static const getRoomsAPI = 'http://localhost:4000/api/rooms';
  static String getMessagesOfRoomAPI(String roomId) =>
      '$serverURL/api/room/$roomId/messages';

  static const websocketAPI = 'ws://$serverHost/socket/websocket';
}
