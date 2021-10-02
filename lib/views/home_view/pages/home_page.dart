import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String? userId;
  const HomePage({Key? key, this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    Text(
                      userId != null ? 'Welcome' : 'No user',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: () {},
                    child: Icon(Icons.add),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
