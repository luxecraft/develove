import 'package:flutter/material.dart';

class GuildExpandedView extends StatefulWidget {
  final String name;
  final String id;

  const GuildExpandedView({
    Key? key,
    required this.name,
    required this.id,
  }) : super(key: key);

  @override
  _GuildExpandedViewState createState() => _GuildExpandedViewState();
}

class _GuildExpandedViewState extends State<GuildExpandedView> {
  List<String> messages = ["hai", "hiiiii", "What's up"];
  final TextEditingController _messageEditingController =
      TextEditingController();

  void sendMessage(String message) {
    setState(() {
      messages.add(message);
    });
    _messageEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xFF313131), Color(0xFF282828)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            AppBar(
              title: Text(widget.name),
            ),
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    //placeholder
                    children: messages.map((e) => Text(e)).toList(),
                  ),
                ),
              ),
            ),
            Container(
              color: Color(0xFF474747),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: TextField(
                            onSubmitted: sendMessage,
                            controller: _messageEditingController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 8.0,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide(color: Colors.grey)),
                              focusColor: Colors.transparent,
                              hintText: "Message",
                              isDense: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide(color: Colors.grey)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send_outlined),
                      onPressed: () =>
                          sendMessage(_messageEditingController.text),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
