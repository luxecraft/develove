import React, { useEffect, useState } from "react";
import { getGuildsOfCurrentUser } from "../lib/guilds";

export default function GuildList() {
  const [guilds, setGuilds] = useState([]);
  useEffect(() => {
    getGuildsOfCurrentUser().then((res) => {
      console.log(res);
    });
  }, []);
  return <div></div>;
}
