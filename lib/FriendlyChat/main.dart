import 'package:flutter/material.dart';
import 'package:helloflutter/FriendlyChat/chat_message.dart';
import 'package:helloflutter/FriendlyChat/constants/colors.dart' as Constants;

class FriendlychatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Friendly Chat',
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  ChatScreen({Key key}) : super(key: key);

  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();

  static bool isMessageEmpty = true;
  static Color sendButton = Constants.SEND_BUTTON_DISABLED;

  @override
  void dispose() {
    for (ChatMessage message in _messages)
      message.animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Friendly Chat")),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          )
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                onChanged: _handleChanged,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 8.0,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    hintText: "Type a message"),
              ),
            ),
            Container(
              margin: EdgeInsets.all(4.0),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: isMessageEmpty
                      ? null
                      : () => _handleSubmitted(_textController.text),
                  child: Container(
                    color: Colors.transparent,
                    height: 40,
                    width: 40,
                    child: Icon(
                      Icons.send,
                      color: sendButton,
                      size: 20,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handleChanged(String text) {
    setState(() {
      sendButton = Constants.SEND_BUTTON_ENABLED;
      isMessageEmpty = false;

      if (text == "") {
        sendButton = Constants.SEND_BUTTON_DISABLED;
        isMessageEmpty = true;
      }
    });
  }

  void _handleSubmitted(String text) {
    _textController.clear();

    ChatMessage message = ChatMessage(
      text: text,
      animationController: AnimationController(
        duration: Duration(
          milliseconds: 300,
        ),
        vsync: this,
      ),
    );

    setState(() {
      if (message.text != "") {
        sendButton = Constants.SEND_BUTTON_DISABLED;
        isMessageEmpty = true;
        _messages.insert(0, message);
      }
    });
    message.animationController.forward();
  }
}
