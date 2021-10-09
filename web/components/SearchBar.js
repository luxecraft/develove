import { useRouter } from "next/dist/client/router";
import React, { useState } from "react";
import { connectSearchBox } from "react-instantsearch-core";

function SearchBar({ currentRefinement, refine, placeholder = "Search" }) {
  const router = useRouter();

  return (
    <div className="w-full flex justify-center">
      <div className="absolute w-8/12 h-14 flex justify-end items-center ">
        <div className="bg-secondary-solid z-20 h-14 w-1/6 rounded-r-lg flex items-center divide-x divide-white">
          <button
            onClick={() => router.push("/explore/people")}
            className="w-1/2 h-full hover:bg-primary-solid"
          >
            <div className="text-sm">👩🏼</div>
            <div className="text-sm font-mono font-medium text-white">
              Users
            </div>
          </button>
          <button
            onClick={() => router.push("/explore/blog")}
            className="w-1/2 h-full hover:bg-primary-solid hover:rounded-r-lg"
          >
            <div className="text-sm">📰</div>
            <div className="text-sm font-mono font-medium text-white">Blog</div>
          </button>
        </div>
      </div>
      <input
        placeholder={placeholder}
        className="w-8/12 z-10 bg-accentGray rounded-lg h-14 shadow-md focus:outline-none px-10 text-xl font-mono font-semibold text-white"
        type="search"
        value={currentRefinement}
        onChange={(event) => refine(event.currentTarget.value)}
      />
    </div>
  );
}

const CustomSearchBox = connectSearchBox(SearchBar);
export default CustomSearchBox;
