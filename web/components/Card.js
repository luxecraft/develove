import React from "react";
import Image from "next/image";
import { newConnection } from "../lib/connection";
import toast from "react-hot-toast";
import { truncatePost } from "../lib/utils";
export default function Card({ hit }) {
  const user = hit;

  if (hit.username)
    return (
      <div className="bg-accentGray mx-10 flex rounded-xl my-5 shadow-lg p-10 text-white font-medium">
        <Image
          className="pr-20"
          src={
            "https://avatars.dicebear.com/api/miniavs/" + user.username + ".svg"
          }
          alt="Avatar"
          height="120"
          width="120"
        />
        <div className="ml-10">
          <h1 className="text-4xl font-mono font-semibold">{user.fullName}</h1>
          <h1 className="text-md mt-1 font-bold opacity-80">
            @{user.username}
          </h1>
          <h1 className="text-md mt-1 font-light opacity-80">{user.email}</h1>
          <div className="mt-4">
            {user.tags.map((tag, i) => {
              if (i < 4)
                return (
                  <span
                    key={i}
                    className="text-sm font-medium font-mono bg-primary-end bg-opacity-50 border-primary-start border-2 rounded-full px-3 py-1 mr-2"
                  >
                    {tag}
                  </span>
                );
            })}
          </div>
          <div className="flex justify-end mt-8">
            <button
              onClick={() => {
                toast.promise(newConnection(user.uid), {
                  loading: "Loading",
                  success: "Connection request sent",
                  error: "Could not connect to server",
                });
              }}
              className=" bg-gradient-to-tr from-primary-start to-primary-end shadow-xl hover:bg-opacity-70 text-white font-bold font-mono py-2 px-10 rounded-lg"
            >
              Connect
            </button>
          </div>
        </div>
      </div>
    );

  return (
    <div className="bg-accentGray mx-10 flex rounded-xl my-5 shadow-lg p-10 text-white font-medium">
      <div className="">
        <h1 className="text-4xl font-mono font-semibold my-5">{hit.title}</h1>
        <h1 className="text-md mt-1 font-bold opacity-80">
          {truncatePost(hit.data)}
          {hit.createdAt}
        </h1>
      </div>
    </div>
  );
}
