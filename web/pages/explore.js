import React from "react";
import SearchBar from "../components/SearchBar";
export default function explore() {
  return (
    <div>
      <SearchBar handleSubmit={(w) => console.log(w)} />
    </div>
  );
}
