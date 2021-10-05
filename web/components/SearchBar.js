import React from "react";

export default function SearchBar() {
  return (
    <div className="w-full flex justify-center">
      <input
        className="w-10/12 bg-accentGray rounded-lg h-14 shadow-md focus:outline-none px-10 text-xl font-mono font-semibold text-white"
        type="text"
        placeholder="Search anything 🔥"
      />
    </div>
  );
}
