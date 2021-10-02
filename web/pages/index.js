import styles from "../styles/Home.module.css";
import { createClient } from "@supabase/supabase-js";
import { useState, useEffect } from "react";

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.NEXT_PUBLIC_SUPABASE_PUBLIC_ANON
);

export default function Home() {
  const [user, setUser] = useState(null);

  useEffect(() => {
    const token = localStorage.getItem("supabase.auth.token");
    console.log(token);
    if (token) {
      const refresh_token =
        JSON.parse(token)["currentSession"]["refresh_token"];
      console.log(refresh_token);
      supabase.auth.signIn({
        refreshToken: refresh_token,
      });
    }
    supabase.auth.onAuthStateChange((event, session) => {
      console.log(session);
      setUser(session.user);
    });
  }, []);

  async function signUpWithGoogle() {
    await supabase.auth.signIn({
      provider: "google",
    });
  }

  async function signUpWithGithub() {
    await supabase.auth.signIn({
      provider: "github",
    });
  }

  return (
    <div className={styles.container}>
      {user !== null ? null : (
        <button onClick={() => signUpWithGoogle()}>Sign Up with Google</button>
      )}
      {user !== null ? null : (
        <button onClick={() => signUpWithGithub()}>Sign Up with Github</button>
      )}
      <p>{user !== null ? user.email : null}</p>
    </div>
  );
}
