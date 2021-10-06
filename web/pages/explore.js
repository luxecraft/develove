import React, { useState } from "react";
import { InstantSearch } from "react-instantsearch-core";
import CustomRefinementList from "../components/RefinementList";
import CustomHitList from "../components/HitList";
import CustomSearchBox from "../components/SearchBar";
import { getUser, searchUsers } from "../lib/connection";
import searchClient from "../lib/typesense";
import { RefinementList } from "react-instantsearch-dom";

export default function Explore() {
  const [user, setUser] = useState({});
  const [error, seterror] = useState(false);

  const searchExplore = async (emailQuery) => {
    let res = await searchUsers(emailQuery);
    if (res == -1) {
      console.log("nope");
      seterror(true);
      setUser({});
    } else {
      let res2 = await getUser(res);
      console.log(res2);
      setUser(res2);
      seterror(false);
    }
  };

  return (
    <div>
      <InstantSearch indexName="users" searchClient={searchClient}>
        <CustomSearchBox />
        {/* <RefinementList attribute={"tags"} /> */}
        <div className="flex items-center justify-center">
          <CustomHitList />
        </div>
      </InstantSearch>
    </div>
  );
}
