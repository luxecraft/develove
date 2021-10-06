import React from "react";
import Card from "./Card";

export default function ExploreCards({ data, error }) {
  return (
    <div className="w-10/12 gap-10 flex flex-wrap justify-center lg:justify-start items-center mt-20">
      {error ? <Card content={"No results found"} /> : null}
      {data.fullName ? <Card user={data} /> : null}
    </div>
  );
}
