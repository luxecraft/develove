import React from "react";
import Image from "next/image";
export default function Card({ user, content, size }) {
  if (user) {
    return (
      <div className="bg-accentGray flex rounded-xl shadow-lg p-10 text-white font-medium">
        <Image
          src={
            "https://avatars.dicebear.com/api/miniavs/" + user.username + ".svg"
          }
          alt="Avatar"
          height="120"
          width="120"
        />
        <div>
          <h1 className="text-4xl font-mono font-semibold">{user.fullName}</h1>
          <h1 className="text-md mt-1 font-bold opacity-80">
            @{user.username}
          </h1>
          <h1 className="text-md mt-1 font-light opacity-80">{user.email}</h1>
          <div className="mt-4">
            {user.tags.map((tag, i) => (
              <span
                key={i}
                className="text-sm font-medium font-mono bg-primary-end bg-opacity-50 border-primary-start border-2 rounded-full px-3 py-1 mr-2"
              >
                {tag}
              </span>
            ))}
          </div>
          <div className="flex justify-end mt-4">
            <button className="bg-primary-solid text-white font-bold py-1 px-6 rounded-full">
              Connect
            </button>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="bg-accentGray flex-grow h-48 rounded-xl shadow-lg p-10 text-white font-medium">
      {content}
    </div>
  );
}
