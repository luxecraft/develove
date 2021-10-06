import React from "react";
import Image from "next/image";
import Link from "next/link";
import { useAuth } from "../lib/auth";

export default function Navbar() {
  const { currentUser } = useAuth();
  return (
    <div className="p-5 flex">
      <Image src="/logo.svg" alt="Logo" height={50} width={50} />
      <div className="flex justify-end w-screen px-10 items-center">
        <Link href="/home">
          <a className="text-white mx-10 font-semibold">Feed</a>
        </Link>
        <Link href="/explore">
          <a className="text-white mx-10 font-semibold">Explore</a>
        </Link>
        <Link href="/guilds">
          <a className="text-white mx-10 font-semibold">Guilds</a>
        </Link>
        <Link href={currentUser ? "/profile" : "/signup"}>
          <a className="text-white mx-10 font-semibold">
            {currentUser ? "Profile" : "Sign up"}
          </a>
        </Link>
      </div>
    </div>
  );
}
