import React, { useEffect } from "react";
import Image from "next/image";
import { useAuth } from "../lib/auth";
import { useRouter } from "next/dist/client/router";
import { searchUsers } from "../lib/connection";
export default function Splash() {
  const { currentUser } = useAuth();
  const router = useRouter();
  useEffect(() => {
    if (currentUser) {
      searchUsers(currentUser.email).then((res) => {
        if (res == -1) {
          router.push("/onboarding");
        } else {
          router.push("/home");
        }
      });
    }
  }, [currentUser, router]);
  return (
    <div className="flex justify-center text-center">
      <div className="px-40 mt-20">
        <Image src="/logo.svg" alt="Logo" height={400} width={400} />
        <h1 className="text-5xl font-mono font-bold text-center text-white">
          Hey there 👋🏽 welcome to Develove 🧑🏾‍💻
        </h1>
        <br />
        <div className="flex items-center justify-center mt-20">
          <p className="text-2xl font-mono font-semibold w-8/12 text-left mr-20 text-white bg-gradient-to-br from-secondary-start to-secondary-end px-20 py-14 rounded-lg drop-shadow-lg shadow-inner">
            Here in Develove, you can meet and hangout with developers from all
            around the world.
          </p>
          <Image src="/earth.svg" alt="Earth" height={400} width={400} />
        </div>
        <div className="flex items-center justify-center mt-20">
          <Image src="/search.svg" alt="Earth" height={400} width={400} />
          <p className="text-2xl font-mono font-semibold w-8/12 text-left ml-20 text-white bg-gradient-to-br from-secondary-start to-secondary-end px-20 py-14 rounded-lg drop-shadow-lg shadow-inner">
            Search them up using the interactive map, or shoot them a DM. You
            might get lucky!
          </p>
        </div>
        <div className="flex items-center justify-center mt-20">
          <p className="text-2xl font-mono font-semibold w-8/12 text-left mr-20 text-white bg-gradient-to-br from-secondary-start to-secondary-end px-20 py-14 rounded-lg drop-shadow-lg shadow-inner">
            Meet people tailored to your interests, build hype, and new friends
            using Develove.
          </p>
          <Image src="/tastes.svg" alt="Earth" height={400} width={400} />
        </div>
      </div>
    </div>
  );
}
