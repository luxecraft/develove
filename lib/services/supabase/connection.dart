import 'constants.dart';

Future<bool> isConnected(int tid) async {
  final res = await supabase
      .from('connections')
      .select('connected')
      .match({'tid': tid}).execute();
  List<dynamic> data = res.data;
  return data[0]['connected'];
}

Future<void> newConnection(int tid) async {
  var currentUser = await supabase.auth.currentUser!.email;
  var userRes = await supabase
      .from('users')
      .select('uid')
      .match({'email': currentUser}).execute();
  final data = {
    'fid': userRes.data[0]['uid'],
    'tid': tid,
  };
  final res = await supabase.from('connections').insert(data).execute();
  print(userRes.data);
  print(res.data);
}

Future<void> rejectConnection(int fid) async {
  var currentUser = await supabase.auth.currentUser!.email;
  var userRes = await supabase
      .from('users')
      .select('uid')
      .match({'email': currentUser}).execute();
  final data = {
    'fid': fid,
    'tid': userRes.data[0]['uid'],
  };
  // creates a pending request
  final res = await supabase.from('connections').delete().match(data).execute();
  print(userRes.data);
  print(res.data);
}

Future<void> acceptConnection(int fid) async {
  var currentUser = await supabase.auth.currentUser!.email;
  var userRes = await supabase
      .from('users')
      .select('uid')
      .match({'email': currentUser}).execute();
  var data = {
    'fid': fid,
    'tid': userRes.data[0]['uid'],
  };

  // updates the connected status to true
  var res = await supabase
      .from('connections')
      .update({'connected': true})
      .match(data)
      .execute();
  data = {
    'tid': fid,
    'fid': userRes.data[0]['uid'],
    'connected': true,
  };
  // creates a two way connection between the two users
  res = await supabase.from('connections').insert(data).execute();
  print(userRes.data);
  print(res.data);
}

Future<int?> searchConnection(String email) async {
  var res = await supabase
      .from('users')
      .select('uid')
      .match({'email': email}).execute();
  print(res.data);
  // returns the user id if found
  return (res.data as List<dynamic>).isNotEmpty ? res.data[0]['uid'] : null;
}

Future<List<dynamic>> getConnections() async {
  var currentUser = await supabase.auth.currentUser!.email;
  var userRes = await supabase
      .from('users')
      .select('uid')
      .match({'email': currentUser}).execute();
  var data = {
    'fid': userRes.data[0]['uid'],
    'connected': true,
  };
  var res = await supabase.from('connections').select().match(data).execute();
  return res.data;
}

Future<List<dynamic>> pendingConnections() async {
  var currentUser = await supabase.auth.currentUser!.email;
  var userRes = await supabase
      .from('users')
      .select('uid')
      .match({'email': currentUser}).execute();
  var data = {
    'tid': userRes.data[0]['uid'],
    'connected': false,
  };
  var res = await supabase.from('connections').select().match(data).execute();
  return res.data;
}
