import { supabase } from "./supabase";

export async function createPosts(posts) {
  let currentUser = supabase.auth.user().email;
  let userRes = await supabase
    .from("users")
    .select("uid")
    .match("email", currentUser);
  let data = {
    uid: userRes.data[0].uid,
    title: posts.title,
    hearts: 0,
    data: posts.data,
    tags: posts.tags,
  };
  await supabase.from("posts").insert(data);
}

export async function getPosts() {
  let currentUser = supabase.auth.user().email;
  let userRes = await supabase
    .from("users")
    .select("uid")
    .match("email", currentUser);
  let posts = await supabase
    .from("posts")
    .select()
    .match("uid", userRes.data[0].uid);
  return posts.data;
}
