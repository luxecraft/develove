import { supabase } from "./supabase";

export async function newConnection(tid) {
  let currentUser = supabase.auth.user().email;
  let userRes = await supabase
    .from("users")
    .select("uid")
    .match({ email: currentUser });
  const data = {
    fid: userRes.data[0]["uid"],
    tid: tid,
  };
  let res = await supabase.from("connections").insert(data);
  console.log(userRes.data);
  console.log(res.data);
}

export async function acceptConnection(tid) {
  let currentUser = supabase.auth.user().email;
  let userRes = await supabase
    .from("users")
    .select("uid")
    .match({ email: currentUser });
  const data = {
    fid: userRes.data[0]["uid"],
    tid: tid,
  };
  let res = await supabase
    .from("connections")
    .update({ connected: true })
    .match(data);
  data = {
    tid: userRes.data[0]["uid"],
    fid: tid,
    connected: true,
  };
  res = await supabase.from("connections").insert(data);
  print(userRes.data);
  print(res.data);
}

export async function getConnections() {
  let currentUser = supabase.auth.user().email;
  let userRes = await supabase
    .from("users")
    .select("uid")
    .match({ email: currentUser });
  let res = await supabase
    .from("connections")
    .select()
    .match({ fid: userRes.data[0]["uid"] });
  return res.data;
}

export async function pendingConnections() {}

export async function searchConnections() {
  let res = await supabase.from("users").select("uid").match({ email: email });
  if (res.data.length == 0) {
    return -1;
  } else {
    return res.data[0]["uid"];
  }
}
