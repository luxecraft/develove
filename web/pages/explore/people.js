import React, { useState } from "react";
import { InstantSearch } from "react-instantsearch-core";
import CustomRefinementList from "../../components/RefinementList";
import CustomHitList from "../../components/HitList";
import CustomSearchBox from "../../components/SearchBar";
import { searchClientPeople } from "../../lib/typesense";

export default function ExplorePeopl() {
  return (
    <div>
      <InstantSearch indexName="users" searchClient={searchClientPeople}>
        <CustomSearchBox placeholder="Search anyone 🧔🏽‍♂️" />
        <CustomRefinementList attribute={"tags"} />
        <div className="flex items-center justify-center">
          <CustomHitList />
        </div>
      </InstantSearch>
    </div>
  );
}
