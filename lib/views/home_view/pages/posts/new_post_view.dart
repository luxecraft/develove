import 'package:flutter/material.dart';

class NewPostView extends StatelessWidget {
  const NewPostView({Key? key}) : super(key: key);

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
            AppBar(title: Text('New Post')),
            Column(
              children: [
                TextField(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
