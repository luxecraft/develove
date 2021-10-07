import faker from "faker";
import { createClient } from "@supabase/supabase-js";

function shuffle(array) {
  let currentIndex = array.length,
    randomIndex;

  // While there remain elements to shuffle...
  while (currentIndex != 0) {
    // Pick a remaining element...
    randomIndex = Math.floor(Math.random() * currentIndex);
    currentIndex--;

    // And swap it with the current element.
    [array[currentIndex], array[randomIndex]] = [
      array[randomIndex],
      array[currentIndex],
    ];
  }

  return array;
}

faker.seed(2811);

async function main() {
  const supabase = createClient(
    "https://eiitsgowqlbvulpsadlu.supabase.co",
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYzMjk4MjM0NiwiZXhwIjoxOTQ4NTU4MzQ2fQ.f4nXg6UUlL3tr405SiZ7u2TTXmgJ7mJa-NLOVC8Ml4M"
  );
  let tags = [
    "Javascript",
    "React",
    "Django",
    "Python",
    "Next.js",
    "Node.js",
    "Web3",
    "Solidity",
    "Ethereum",
    "Blockchain",
    "Typescript",
    "GraphQL",
    "Machine Learning",
    "Tensorflow",
    "Postman",
    "Angular",
    "Vue",
    "Kubernetes",
    "Docker",
  ];

  tags = shuffle(tags);
  for (let i = 0; i < 100; ++i) {
    const name = faker.name.findName();
    const username = faker.internet.userName();
    const email = `ghp1r.${username}@inbox.testmail.app`;
    const password = faker.internet.password();
    await supabase.auth.signUp({
      email: email,
      password: password,
    });
    await supabase.from("users").insert({
      fullName: name,
      email: email,
      username: username,
      tags: tags.slice(0, Math.floor(Math.random() * tags.length)),
    });
    await new Promise((resolve) => setTimeout(resolve, 2000));
  }
  console.log(i);
}

main();
