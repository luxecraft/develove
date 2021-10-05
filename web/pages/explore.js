import React, { useState } from "react";
import ExploreCards from "../components/Explore";
import SearchBar from "../components/SearchBar";
import { getUser, searchUsers } from "../lib/connection";

export default function Explore() {
  const [user, setUser] = useState({});
  const [error, seterror] = useState(false);

  const searchExplore = async (emailQuery) => {
    let res = await searchUsers(emailQuery);
    if (res == -1) {
      console.log("nope");
      seterror(true);
    } else {
      let res2 = await getUser(res);
      console.log(res2);
      setUser(res2);
    }
  };

  return (
    <div>
      <SearchBar handleSubmit={(query) => searchExplore(query)} />
      <div className="flex items-center justify-center">
        <ExploreCards data={user} error={error} />
      </div>
    </div>
  );
}
