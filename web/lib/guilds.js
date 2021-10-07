import { supabase } from "./supabase";

export async function getGuildsOfCurrentUser(uid) {
  const guilds = await supabase.from("guilds").select().contains("mids", [uid]);
  return guilds.data;
}
