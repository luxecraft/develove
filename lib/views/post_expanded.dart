import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/atom-one-dark-reasonable.dart';

class PostExpandedView extends StatelessWidget {
  final String title;
  const PostExpandedView({Key? key, required this.title}) : super(key: key);

  final code = """# Python program to demonstrate working
# of map.
  
# Return double of n
def addition(n):
    return n + n
  
# We double all numbers using map()
numbers = (1, 2, 3, 4)
result = map(addition, numbers)
print(list(result))""";

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
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                    vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Map Function',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'map() function returns a map object(which is an iterator) of the results after applying the given function to each item of a given iterable (list, tuple etc.)',
                    ),
                    SizedBox(height: 10),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: HighlightView(
                          code,
                          padding: EdgeInsets.all(8.0),
                          tabSize: 4,
                          language: 'python',
                          theme: atomOneDarkReasonableTheme,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
