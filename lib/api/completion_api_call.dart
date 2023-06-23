import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:open_aii/screens/chat_screen.dart';

String apiKey = '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';
String customPrompt = 'I will give you information and visual description of peony flowers, you will generate unique names for them in dont write any description just write the names,Names shouldnt be exists already, name should be flowers releated[TARGETLANGUAGE]here is information and visual description[PROMPT] and if information and visual description is not related Peony Flower, apologize';

abstract class ApiProvider {
  String baseUrl = 'https://api.openai.com/v1/completions';
  Map<String, String> header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey'
  };
}

class PostApi extends ApiProvider {
  PostApi._internal();

  static final _instance = PostApi._internal();
  factory PostApi() {
    return _instance;
  }

 sendMessage(String prompt) async {
  //var url = Uri.https("api.openai.com", "/v1/completions");
  final response = await http.post(
    Uri.parse(baseUrl),
    headers: header,
    body: json.encode({
      "model": "text-davinci-003",
      "prompt": 'I will give you information and visual description of peony flowers, you will generate unique names for them in dont write any description just write the names,Names shouldnt be exists already, name should be flowers releated to flowers ,[TARGETLANGUAGE]here is information and visual description[$prompt]',
      'temperature': 0,
      'max_tokens': 2000,
      'top_p': 1,
      'frequency_penalty': 0.0,
      'presence_penalty': 0.0,
    }),
  );
   if (response.statusCode == 200) {
      var data = await jsonDecode(response.body.toString());
      var msg = data['choices'][0]['text'];
      return msg;
      print('from api $msg');
    } else {
      return response.statusCode.toString();
    }
  // sendMessage(String prompt) async {
  //   var response = await http.post(Uri.parse(baseUrl),
  //       headers: header,
  //       body: jsonEncode({
  //         'model': 'text-devinci-003',
  //         'prompt': prompt,
  //         'temperature': '0',
  //         'max_tokens': '100',
  //         'top_p': '1',
  //         'frequency_penalty': '0.0',
  //         'presence_penalty': '0.0',
  //         'stops': ['Human:', 'AI:']
  //       }));
  //   if (response.statusCode == 200) {
  //     var data = jsonDecode(response.body);
  //     print(data);
  //   } else {
  //     print(response.statusCode);
  //   }
   }
}
