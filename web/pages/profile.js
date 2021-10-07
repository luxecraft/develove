import React, { useEffect, useState } from "react";
import { useAuth } from "../lib/auth";
import { getCurrentUser, signOut } from "../lib/connection";
import Image from "next/image";
import { useRouter } from "next/dist/client/router";

export default function Profile() {
  const [thisUser, setThisUser] = useState(null);
  const { currentUser } = useAuth();
  const router = useRouter();

  useEffect(() => {
    if (currentUser)
      getCurrentUser(currentUser.email).then((user) => {
        setThisUser(user);
      });
    console.log(currentUser);
  }, [currentUser]);

  return (
    <div className="flex justify-center">
      <div className="mt-40 w-5/12 flex p-10 bg-gradient-to-br from-primary-start to-primary-end rounded-lg shadow-lg">
        {thisUser ? (
          <>
            <Image
              className="pr-20"
              src={
                "https://avatars.dicebear.com/api/miniavs/" +
                thisUser.username +
                ".svg"
              }
              alt="Avatar"
              height="120"
              width="120"
            />
            <div className="ml-10 w-full">
              <div className="flex justify-between">
                <h1 className="text-4xl font-mono font-semibold">
                  {thisUser.fullName}
                </h1>
                <button
                  onClick={() => {
                    signOut().then(() => {
                      router.push("/splash");
                    });
                  }}
                  className="bg-gradient-to-tr from-secondary-start to-secondary-end shadow-xl hover:bg-opacity-70 text-white font-bold font-mono py-2 px-10 rounded-lg"
                >
                  Logout
                </button>
              </div>
              <h1 className="text-md mt-1 font-bold opacity-80">
                @{thisUser.username}
              </h1>
              <h1 className="text-md mt-1 font-light opacity-80">
                {thisUser.email}
              </h1>
              <div className="mt-4">
                {thisUser.tags.map((tag, i) => {
                  if (i < 4)
                    return (
                      <span
                        key={i}
                        className="text-sm text-white opacity-70 font-medium font-mono bg-secondary-end bg-opacity-50 border-secondary-start border-2 rounded-full px-3 py-1 mr-2"
                      >
                        {tag}
                      </span>
                    );
                })}
              </div>
            </div>
          </>
        ) : null}
      </div>
    </div>
  );
}
