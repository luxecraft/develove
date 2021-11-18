// ignore: import_of_legacy_library_into_null_safe
import 'package:typesense/typesense.dart';

Future<Map<String, dynamic>> searchConnections(String search) async {
  final searchParameters = {
    'q': search,
    'query_by': 'email, username, fullName',
  };

  final client = Client(Configuration(
    nodes: {
      Node(
        host: 'develove.ts.luxecraft.org',
        port: 443,
        protocol: 'https',
      ),
    },
    apiKey: 'hqrIn0Xqpru1MyF6GXM88RxfdOnZLVFp',
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
