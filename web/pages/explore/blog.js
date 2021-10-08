import React, { useState } from "react";
import { InstantSearch } from "react-instantsearch-core";
import CustomRefinementList from "../../components/RefinementList";
import CustomHitList from "../../components/HitList";
import CustomSearchBox from "../../components/SearchBar";
import { searchClientPosts } from "../../lib/typesense";

export default function ExploreBlog() {
  return (
    <div>
      <InstantSearch indexName="posts" searchClient={searchClientPosts}>
        <CustomSearchBox placeholder="Search anything 📖" />
        <CustomRefinementList attribute={"tags"} />
        <div className="flex items-center justify-center">
          <CustomHitList />
        </div>
      </InstantSearch>
    </div>
  );
}
