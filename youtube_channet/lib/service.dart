import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'constants.dart';
import 'models/channel.dart';

class Services {
  //
  static const CHANNEL_ID = 'UCVueKen18nK6BYc1JsOx-yw';
  static const _baseUrl = 'youtube.googleapis.com';

  static Future<ChannelInfo> getChannelInfo() async {
    Map<String, String> parameters = {
      'part': 'snippet,contentDetails,statistics',
      'id': CHANNEL_ID,
      'key': Constants.API_KEY,
    };
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/channels',
      parameters,
    );
    Response response = await http.get(uri, headers: headers);
    // print(response.body);
    ChannelInfo channelInfo = channelInfoFromJson(response.body);
    return channelInfo;
  }

  // static Future<VideosList> getVideosList(
  //     {String playListId, String pageToken}) async {
  //   Map<String, String> parameters = {
  //     'part': 'snippet',
  //     'playlistId': playListId,
  //     'maxResults': '8',
  //     'pageToken': pageToken,
  //     'key': Constants.API_KEY,
  //   };
  //   Map<String, String> headers = {
  //     HttpHeaders.contentTypeHeader: 'application/json',
  //   };
  //   Uri uri = Uri.https(
  //     _baseUrl,
  //     '/youtube/v3/playlistItems',
  //     parameters,
  //   );
  //   Response response = await http.get(uri, headers: headers);
  //   // print(response.body);
  //   VideosList videosList = videosListFromJson(response.body);
  //   return videosList;
  // }
}
