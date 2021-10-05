import React, { useState } from "react";

export default function SearchBar({
  placeholder = "Search anything",
  handleSubmit,
}) {
  const [query, setQuery] = useState("");

  const handleChange = (e) => {
    setQuery(e.target.value);
  };

  const handleReturn = (e) => {
    if (e.key == "Enter") {
      handleSubmit(query);
    }
  };
  return (
    <div className="w-full flex justify-center">
      <input
        className="w-10/12 bg-accentGray rounded-lg h-14 shadow-md focus:outline-none px-10 text-xl font-mono font-semibold text-white"
        type="text"
        placeholder={placeholder}
        value={query}
        onChange={handleChange}
        onKeyPress={handleReturn}
      />
    </div>
  );
}
