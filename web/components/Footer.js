import React from "react";
import Image from "next/image";

export default function Footer() {
  return (
    <div className="flex flex-col justify-center items-center py-10 bg-gradient-to-r from-secondary-start to-secondary-end mt-60">
      <a href="https://vercel.com/?utm_source=luxecraft&utm_campaign=oss">
        <img
          className="mb-10"
          src="https://www.datocms-assets.com/31049/1618983297-powered-by-vercel.svg"
        />
      </a>
      <p className="text-center text-white font-mono text-xl">
        {"</>"} with 💚
        <br />
        By Nivas, Hari and Sabesh
      </p>

      <p className="text-center text-white font-mono text-xl pt-10">
        &copy;{new Date().getFullYear()} Develove
      </p>
    </div>
  );
}
