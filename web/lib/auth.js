import React, { createContext, useContext, useEffect, useState } from "react";
import { supabase } from "./supabase";
const AuthContext = createContext();

export function useAuth() {
  return useContext(AuthContext);
}

export function AuthProvider({ children }) {
  const [currentUser, setCurrentUser] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    setLoading(true);
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
      setCurrentUser(session?.user);
    });
    setLoading(false);
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

  const value = {
    currentUser,
    signUpWithGithub,
    signUpWithGoogle,
  };

  return (
    <AuthContext.Provider value={value}>
      {!loading && children}
    </AuthContext.Provider>
  );
}
