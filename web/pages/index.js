import { useRouter } from "next/dist/client/router";
import { useEffect } from "react";
import { useAuth } from "../lib/auth";
import { searchUsers } from "../lib/connection";
import { supabase } from "../lib/supabase";

export default function Index() {
  const { currentUser } = useAuth();
  const router = useRouter();
  useEffect(() => {
    console.log(currentUser);
    if (currentUser) {
      searchUsers(currentUser.email).then((res) => {
        if (res == -1) {
          router.push("/onboarding");
        } else {
          router.push("/home");
        }
      });
    } else {
      router.push("/splash");
    }
  }, [currentUser, router]);
  return <div></div>;
}
