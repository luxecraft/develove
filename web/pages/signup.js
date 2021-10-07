import { useRouter } from "next/dist/client/router";
import React, { useEffect } from "react";
import { useAuth } from "../lib/auth";
import Image from "next/image";
import { searchUsers } from "../lib/connection";

export default function Signup() {
  const { currentUser, signUpWithGithub, signUpWithGoogle } = useAuth();
  const router = useRouter();
  useEffect(() => {
    if (currentUser) {
      router.push("/");
    }
  }, [currentUser, router]);
  return (
    <div className="flex justify-center ">
      <div className=" w-5/12 mt-40 bg-accentGray rounded-lg shadow-lg text-center">
        <h1 className="font-mono font-bold text-4xl my-10 text-primary-solid">
          Join us at Develove
        </h1>
        <div className="">
          <div>
            <button
              onClick={() => signUpWithGoogle()}
              className="h-12 w-6/12 bg-white rounded-md my-5 p-2"
            >
              <div className="flex px-12 items-center">
                <Image src="/google.png" alt="google" height="25" width="25" />
                <p className="font-mono text-md font-medium ml-5">
                  Sign in with Google
                </p>
              </div>
            </button>
          </div>
          <div>
            <button
              onClick={() => signUpWithGithub()}
              className="h-12 w-6/12 bg-white rounded-md my-5 p-2"
            >
              <div className="flex px-12 items-center">
                <Image src="/github.png" alt="github" height="25" width="25" />
                <p className="font-mono text-md font-medium ml-5">
                  Sign in with Github
                </p>
              </div>
            </button>
          </div>
          <div>
            <button className="h-12 w-6/12 bg-white rounded-md my-5 mb-16 p-2">
              <div className="flex px-12 items-center">
                <Image src="/apple.png" alt="apple" height="25" width="25" />
                <p className="font-mono text-md font-medium ml-5">
                  Sign in with Apple
                </p>
              </div>
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
