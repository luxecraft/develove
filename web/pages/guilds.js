import React, { useEffect, useState } from "react";

const checkLocalStorage = () => {
  const ls = localStorage.getItem("guildOnBoard");
  if (ls === null || ls === "true") {
    return true;
  } else if (ls === "false") {
    return false;
  }
};

export default function Guilds() {
  const [guildOnBoarding, setGuildOnBoarding] = useState(true); //Change state to checkLocalStorage()

  const handleGuildOnBoarding = () => {
    setGuildOnBoarding(false);
    localStorage.setItem("guildOnBoard", false);
  };

  useEffect(() => {
    console.log(localStorage.getItem("guildOnBoard"));
  }, []);

  if (guildOnBoarding)
    return (
      <div className="flex justify-center text-center">
        <div>
          <h1 className="text-6xl font-bold font-mono text-white mb-10 mt-40 transition ease-in-out animate-pulse">
            Welcome to Guilds
          </h1>
          <h1 className="text-6xl font-bold font-mono text-white my-10 transition ease-in-out animate-pulse">
            🦸🏽‍♂️&nbsp;🧝🏼‍♂️&nbsp;🦹🏾‍♀️&nbsp;🧑🏿‍🚀&nbsp;👩🏽‍🎓&nbsp;🥷
          </h1>

          <p className="text-white font-light text-2xl mt-40">
            Form your own guilds, and add people tailored to your taste! Network
            and engage with others, get hired or get lucky!
          </p>

          <button
            onClick={() => handleGuildOnBoarding()}
            className="mt-20 w-1/4 h-20 bg-gradient-to-br from-primary-start to-primary-end rounded-lg shadow-lg"
          >
            <div className="flex items-center justify-center">
              <p className="text-3xl font-mono font-bold mx-2">Enter</p>
              <p className="text-6xl font-mono font-bold mx-2">🎟</p>
            </div>
          </button>
        </div>
      </div>
    );

  return (
    <div className="flex justify-center text-center">
      {/* Actual Guild Content */}
    </div>
  );
}
