import { supabase } from "./supabase";

export async function createPost(post) {
  let currentUser = supabase.auth.user().email;
  let userRes = await supabase
    .from("users")
    .select("uid")
    .match("email", currentUser);
  let data = {
    uid: userRes.data[0].uid,
    title: post.title,
    hearts: 0,
    data: post.data,
    tags: post.tags,
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
