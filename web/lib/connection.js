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
