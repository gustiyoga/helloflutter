import 'package:flutter/material.dart';

const String _name = "Yop";

class ChatMessage extends StatelessWidget {
  const ChatMessage({this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Color(0x66000000),
            blurRadius: 2.0,
            offset: Offset(0, 2.0),
          ),
        ],
      ),
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              right: 8.0,
            ),
            child: CircleAvatar(
              child: Text(
                _name[0],
              ),
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _name,
                  style: Theme.of(context).textTheme.subhead,
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 5.0,
                  ),
                  child: SelectableText(
                    text,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
