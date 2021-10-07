import React from "react";
import Image from "next/image";

export default function GuildCard({ guild }) {
  return (
    <div className="bg-accentGray rounded-lg shadow-md cursor-pointer ease-in-out transform hover:scale-110 transition duration-500">
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
          {guild.tags.map((tag, i) => {
            return (
              <span
                className="text-sm text-white font-medium font-mono bg-primary-end bg-opacity-50 border-primary-start border-2 rounded-full px-3 py-1 mx-2"
                key={i}
              >
                {tag}
                {i !== guild.tags.length - 1 ? "," : ""}
              </span>
            );
          })}
        </div>
      </div>
    </div>
  );
}
