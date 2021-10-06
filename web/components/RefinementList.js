import React from "react";
import { Highlight, connectRefinementList } from "react-instantsearch-dom";

const RefinementList = ({
  items,
  isFromSearch,
  refine,
  searchForItems,
  createURL,
}) => (
  <ul className="flex justify-center mt-10">
    <span className="text-white font-bold">Filter By:</span>
    {items.map((item) => (
      <span key={item.label}>
        <a
          className="text-xs text-white font-medium font-mono bg-primary-end bg-opacity-50 border-primary-start border-2 rounded-full px-3 py-2 mx-2 hover:bg-opacity-80"
          href={createURL(item.value)}
          style={{ backgroundColor: item.isRefined ? "#59AF77" : "" }}
          onClick={(event) => {
            event.preventDefault();
            refine(item.value);
          }}
        >
          {isFromSearch ? (
            <Highlight attribute="label" hit={item} />
          ) : (
            item.label
          )}{" "}
          ({item.count})
        </a>
      </span>
    ))}
  </ul>
);

const CustomRefinementList = connectRefinementList(RefinementList);
export default CustomRefinementList;
