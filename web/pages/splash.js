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
          <p className="text-xl font-mono font-light w-8/12 text-left mr-20 text-white">
            Here in Develove, you can meet and hangout with developers from all
            around the world. Excepteur tempor voluptate aute irure nulla
            nostrud laboris incididunt officia. Ex tempor consectetur mollit
            consectetur anim officia commodo reprehenderit dolor et eu
            consectetur ad aliqua. Mollit amet Lorem excepteur proident nostrud
            pariatur adipisicing. Minim amet eu fugiat ut sint proident esse
            nulla. Laborum tempor irure dolor est elit ullamco occaecat laborum
            reprehenderit nostrud voluptate eiusmod culpa. Laboris sunt ad ex
            adipisicing mollit mollit minim laborum enim do dolore do eu sint.
          </p>
          <Image src="/earth.svg" alt="Earth" height={400} width={400} />
        </div>
        <div className="flex items-center justify-center mt-20">
          <Image src="/search.svg" alt="Earth" height={400} width={400} />
          <p className="text-xl font-mono font-light w-8/12 text-right ml-20 text-white">
            Search them up using the interactive map, or shoot them a DM. You
            might get lucky! Excepteur tempor voluptate aute irure nulla nostrud
            laboris incididunt officia. Ex tempor consectetur mollit consectetur
            anim officia commodo reprehenderit dolor et eu consectetur ad
            aliqua. Mollit amet Lorem excepteur proident nostrud pariatur
            adipisicing. Minim amet eu fugiat ut sint proident esse nulla.
            Laborum tempor irure dolor est elit ullamco occaecat laborum
            reprehenderit nostrud voluptate eiusmod culpa. Laboris sunt ad ex
            adipisicing mollit mollit minim laborum enim do dolore do eu sint.
          </p>
        </div>
        <div className="flex items-center justify-center my-20">
          <p className="text-xl font-mono font-light w-8/12 text-left mr-20 text-white">
            Meet people tailored to your interests, build hype, and new friends
            using Develove. Excepteur tempor voluptate aute irure nulla nostrud
            laboris incididunt officia. Ex tempor consectetur mollit consectetur
            anim officia commodo reprehenderit dolor et eu consectetur ad
            aliqua. Mollit amet Lorem excepteur proident nostrud pariatur
            adipisicing. Minim amet eu fugiat ut sint proident esse nulla.
            Laborum tempor irure dolor est elit ullamco occaecat laborum
            reprehenderit nostrud voluptate eiusmod culpa. Laboris sunt ad ex
            adipisicing mollit mollit minim laborum enim do dolore do eu sint.
          </p>
          <Image src="/tastes.svg" alt="Earth" height={400} width={400} />
        </div>
      </div>
    </div>
  );
}
