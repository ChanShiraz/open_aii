import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_aii/api/completion_api_call.dart';
import 'package:open_aii/models/chat.dart';
import 'package:open_aii/screens/chat_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      
      home: ChatScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController textEditingController;
  List<Chat> chatList = [];

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PostApi postApi = PostApi();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: textEditingController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  chatList.add(Chat(
                      text: textEditingController.text,
                      chatType: ChatMessageType.user));
                  print(chatList.length);

                  var apiResponse =
                      await postApi.sendMessage(textEditingController.text);
                  textEditingController.clear();

                  chatList.add(
                      Chat(text: apiResponse, chatType: ChatMessageType.bot));
                  //});
                },
                child: const Text('Post')),
            Expanded(
                child: ListView.builder(
              itemCount: chatList.length,
              itemBuilder: (context, index) => Text(chatList[index].text),
            ))
          ],
        ),
        
      ),
    );
  }
}
