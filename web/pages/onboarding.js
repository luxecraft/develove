import React, { useState } from "react";
import { useAuth } from "../lib/auth";
import { updateUser } from "../lib/signupComplete";

export default function OnBoarding() {
  const [userObject, setUserObject] = useState({
    fullName: "",
    tags: "",
    username: "",
  });

  const handleChange = (e) => {
    setUserObject({ ...userObject, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    let tagsToBeSent = [];
    tagsToBeSent = userObject.tags.split(",");
    console.log(tagsToBeSent);
    console.log(userObject);
    await updateUser(userObject.fullName, tagsToBeSent, userObject.username);
  };

  return (
    <div className="block text-center">
      <form onSubmit={handleSubmit}>
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
