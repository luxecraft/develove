import React, { useState } from "react";
import { connectSearchBox } from "react-instantsearch-core";

function SearchBar({ currentRefinement, refine }) {
  return (
    <div className="w-full flex justify-center">
      <input
        placeholder={"Search anything"}
        className="w-8/12 bg-accentGray rounded-lg h-14 shadow-md focus:outline-none px-10 text-xl font-mono font-semibold text-white"
        type="search"
        value={currentRefinement}
        onChange={(event) => refine(event.currentTarget.value)}
      />
    </div>
  );
}

const CustomSearchBox = connectSearchBox(SearchBar);
export default CustomSearchBox;
