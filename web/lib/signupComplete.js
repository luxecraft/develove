import { supabase } from "./supabase";

export async function updateUser(fullName, tags, username = null) {
  let data = {
    username: username != null ? username : supabase.auth.user().email,
    email: supabase.auth.user().email,
    fullName,
    tags,
  };
  const res = await supabase.from("users").insert(data);
  console.log(res.data);
  console.log(res.error);
}
