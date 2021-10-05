import React, { useState } from "react";
import { useAuth } from "../lib/auth";

export default function OnBoarding() {
  const [userObject, setUserObject] = useState({
    fullName: "",
    tags: "",
    username: "",
  });

  const handleChange = (e) => {
    setUserObject({ ...userObject, [e.target.name]: e.target.value });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
  };

  return (
    <div className="block text-center">
      <form>
        <div className="my-5">
          <input
            name="fullName"
            value={userObject.fullName}
            onChange={handleChange}
          />
        </div>
        <div className="my-5">
          <input name="tags" value={userObject.tags} onChange={handleChange} />
        </div>
        <div className="my-5">
          <input
            name="username"
            value={userObject.username}
            onChange={handleChange}
          />
        </div>

        <button className=" bg-primary-solid" onSubmit={handleSubmit}>
          Submit
        </button>
      </form>
    </div>
  );
}
