import React from "react";
import { connectHits } from "react-instantsearch-core";
import Card from "./Card";

function HitList({ hits }) {
  return (
    <div className="grid grid-cols-2 mt-10">
      {hits.map((hit, i) => (
        <Card key={i} hit={hit} />
      ))}
    </div>
  );
}

const CustomHitList = connectHits(HitList);
export default CustomHitList;
