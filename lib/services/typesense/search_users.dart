import 'package:typesense/typesense.dart';

Future<Map<String, dynamic>> searchConnections(String search) async {
  final searchParameters = {
    'q': search,
    'query_by': 'email, username, fullName',
  };

  final client = Client(Configuration(
    'hqrIn0Xqpru1MyF6GXM88RxfdOnZLVFp',
    nodes: {
      Node(
        Protocol.https,
        'develove.ts.luxecraft.org',
        port: 443,
      ),
    },
    connectionTimeout: Duration(seconds: 2),
  ));

  final res =
      await client.collection('users').documents.search(searchParameters);
  return res;
}

// void main() async {
//   final res = await searchConnections('hari');
//   print(res);
// }
