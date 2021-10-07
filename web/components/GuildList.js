import React, { useEffect, useState } from "react";
import { getGuildsOfCurrentUser } from "../lib/guilds";
import GuildCard from "./GuildCard";

export default function GuildList() {
  const [guilds, setGuilds] = useState([]);
  useEffect(() => {
    getGuildsOfCurrentUser().then((res) => {
      setGuilds(res);
    });
  }, []);
  return (
    <div className="grid grid-cols-3 gap-10">
      {guilds.map((guild, i) => {
        return <GuildCard key={i} guild={guild} />;
      })}
    </div>
  );
}
