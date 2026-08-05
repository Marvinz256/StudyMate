import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

void main() => runApp(StudyMateApp());

class StudyMateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudyMate AI',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ChatScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
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
      _messages.add({'role': 'user', 'text': _controller.text});
      _isLoading = true;
    });
    final prompt = _controller.text;
    _controller.clear();
    final content = [Content.text('You are StudyMate, a helpful AI tutor. Explain simply: $prompt')];
    final response = await _model.generateContent(content);
    setState(() {
      _messages.add({'role': 'ai', 'text': response.text?? 'Sorry, no response'});
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('StudyMate AI')),
      body: Column(children: [
        Expanded(child: ListView.builder(
          itemCount: _messages.length,
          itemBuilder: (context, index) {
            final msg = _messages[index];
            return ListTile(
              title: Align(
                alignment: msg['role'] == 'user'? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: msg['role'] == 'user'? Colors.blue[100] : Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(msg['text']!),
                ),
              ),
            );
          },
        )),
        if(_isLoading) Padding(padding: EdgeInsets.all(8), child: CircularProgressIndicator()),
        Row(children: [
          Expanded(child: TextField(controller: _controller, decoration: InputDecoration(hintText: "Ask StudyMate anything..."))),
          IconButton(icon: Icon(Icons.send), onPressed: _sendMessage),
        ]),
      ]),
    );
  }
}
