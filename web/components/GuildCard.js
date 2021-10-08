import React from "react";
import Image from "next/image";
import { useRouter } from "next/dist/client/router";

export default function GuildCard({ guild }) {
  const router = useRouter();

  return (
    <div
      onClick={() => router.push(`guild/${guild.gid}`)}
      className="bg-accentGray rounded-lg shadow-md cursor-pointer ease-in-out transform hover:scale-110 transition duration-500"
    >
      <Image
        className="rounded-t-lg"
        src={guild.image}
        alt={guild.name}
        height={200}
        width={300}
      />
      <h1 className="text-white font-mono font-bold text-2xl my-5">
        {guild.name}
      </h1>
      <div className="flex justify-center">
        <div className="w-2/5 mb-10">
          <span className="text-sm text-white font-medium font-mono bg-primary-end bg-opacity-50 border-primary-start border-2 rounded-full px-3 py-1 mx-2">
            {guild.tags[0]}
          </span>
        </div>
      </div>
    </div>
  );
}
