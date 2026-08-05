import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

void main() => runApp(const StudyMateApp());

class StudyMateApp extends StatelessWidget {
  const StudyMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudyMate AI',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ChatScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = <Map<String, String>>[];
  late final GenerativeModel _model;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-1.5-flash', 
      apiKey: 'PUT_YOUR_NEW_API_KEY_HERE',
    );
  }

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;
    setState(() {
      _messages.add(<String, String>{'role': 'user', 'text': _controller.text});
      _isLoading = true;
    });
    final String prompt = _controller.text;
    _controller.clear();
    final List<Content> content = <Content>[Content.text('You are StudyMate, a helpful AI tutor. Explain simply: $prompt')];
    final GenerateContentResponse response = await _model.generateContent(content);
    setState(() {
      _messages.add(<String, String>{'role': 'ai', 'text': response.text?? 'Sorry, no response'});
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('StudyMate AI')),
      body: Column(children: <Widget>[
        Expanded(child: ListView.builder(
          itemCount: _messages.length,
          itemBuilder: (BuildContext context, int index) {
            final Map<String, String> msg = _messages[index];
            return ListTile(
              title: Align(
                alignment: msg['role'] == 'user'? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: msg['role'] == 'user'? Colors.blue[100] : Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(msg['text']!),
                ),
              ),
            );
          },
        ),),
        if(_isLoading) const Padding(padding: EdgeInsets.all(8), child: CircularProgressIndicator()),
        Row(children: <Widget>[
          Expanded(child: TextField(controller: _controller, decoration: const InputDecoration(hintText: "Ask StudyMate anything..."))),
          IconButton(icon: const Icon(Icons.send), onPressed: _sendMessage),
        ],),
      ],),
    );
  }
}
