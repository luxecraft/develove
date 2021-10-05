import { useRouter } from "next/dist/client/router";
import React, { useEffect } from "react";
import { useAuth } from "../lib/auth";

export default function Signup() {
  const { currentUser, signUpWithGithub, signUpWithGoogle } = useAuth();
  const router = useRouter();
  useEffect(() => {
    if (currentUser) router.push("/");
  }, [currentUser, router]);
  return (
    <div className="flex justify-center ">
      <div className=" h-96 w-5/12 mt-20 bg-accentGray rounded-lg shadow-lg text-center">
        <h1 className="font-mono font-bold text-2xl mt-5 text-white">
          Join us at Develove
        </h1>
        <div className="">
          <div>
            <button
              onClick={() => signUpWithGoogle()}
              className="h-12 w-5/12 bg-gradient-to-r from-primary-start to-primary-end rounded-md my-5 p-2"
            >
              Sign in with Google
            </button>
          </div>
          <div>
            <button
              onClick={() => signUpWithGithub()}
              className="h-12 w-5/12 bg-gradient-to-r from-primary-start to-primary-end rounded-md my-5 p-2"
            >
              Sign in with Github
            </button>
          </div>
          <div>
            <button className="h-12 w-5/12 bg-gradient-to-r from-primary-start to-primary-end rounded-md my-5 p-2">
              Sign in with Apple
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
