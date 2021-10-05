import React from "react";
import Card from "./Card";

export default function Feed() {
  return (
    <div className="w-10/12 gap-10 flex flex-wrap justify-center lg:justify-start items-center mt-20">
      <Card
        content="Ipsum Lorem anim dolor voluptate amet aute duis adipisicing. Exercitation sit minim est Lorem aute sit ut consectetur irure cupidatat Lorem quis ad magna. Minim consectetur magna duis sit voluptate eiusmod do commodo adipisicing ad anim. Qui labore sunt laborum cillum nisi."
        size="small"
      />
      <Card
        content="Dolor mollit consectetur sunt ea cillum ex est exercitation consequat in voluptate."
        size="small"
      />
      <Card content="Laboris reprehenderit est nisi fugiat et." size="small" />
      <Card
        content="Ipsum Lorem anim dolor voluptate amet aute duis adipisicing. Exercitation sit minim est Lorem aute sit ut consectetur irure cupidatat Lorem quis ad magna. Minim consectetur magna duis sit voluptate eiusmod do commodo adipisicing ad anim. Qui labore sunt laborum cillum nisi."
        size="small"
      />
    </div>
  );
}
