import React from "react";
import Image from "next/image";
import Link from "next/link";

export default function Navbar() {
  return (
    <div className="p-5 flex">
      <Image src="/logo.svg" alt="Logo" height={50} width={50} />
      <div className="flex justify-end w-screen px-10 items-center">
        <Link href="/">
          <a className="text-white mx-10 font-semibold">Feed</a>
        </Link>
        <Link href="/guilds">
          <a className="text-white mx-10 font-semibold">Guilds</a>
        </Link>
        <Link href="/profile">
          <a className="text-white mx-10 font-semibold">Profile</a>
        </Link>
      </div>
    </div>
  );
}
