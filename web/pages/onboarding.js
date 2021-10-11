import { useRouter } from "next/dist/client/router";
import React, { useEffect, useState } from "react";
import { useAuth } from "../lib/auth";
import { updateUser } from "../lib/signupComplete";

export default function OnBoarding() {
  const [userObject, setUserObject] = useState({
    fullName: "",
    tags: "",
    username: "",
  });

  const router = useRouter();
  const { currentUser } = useAuth();
  const handleChange = (e) => {
    setUserObject({ ...userObject, [e.target.name]: e.target.value });
  };

  useEffect(() => {
    if (!currentUser) {
      router.push("/");
    }
  }, [router, currentUser]);

  const handleSubmit = async (e) => {
    e.preventDefault();
    let tagsToBeSent = [];
    tagsToBeSent = userObject.tags.split(",");
    await updateUser(userObject.fullName, tagsToBeSent, userObject.username);
    router.push("/home");
  };

  return (
    <div className="block text-center">
      <h1 className="text-3xl font-bold font-mono text-white mb-10 mt-40">
        Almost there! Join the awesomest community now! 🔥
      </h1>
      <form onSubmit={handleSubmit}>
        <div className="my-5">
          <label className="text-white text-2xl font-thin mr-10">
            Full Name
          </label>
          <input
            className="rounded-lg p-2 focus:outline-none"
            name="fullName"
            value={userObject.fullName}
            onChange={handleChange}
            required
            placeholder="Full Name"
          />
        </div>
        <div className="my-5">
          <label className="text-white text-2xl font-thin mr-10">
            Your tags
          </label>
          {/* <select
            className="rounded-lg p-2"
            name="tags"
            // value={userObject.tags}
            onChange={handleChange}
            multiple
          >
            <option className="rounded-lg p-2" value="">
              Select Tags
            </option>
            <option value="javascript">Javascript</option>
            <option value="react">React</option>
            <option value="node">Node</option>
            <option value="express">Express</option>
          </select> */}
          <input
            className="rounded-lg p-2 focus:outline-none"
            name="tags"
            value={userObject.tags}
            onChange={handleChange}
            required
            placeholder="Enter , separated values"
          />
        </div>
        <div className="my-5">
          <label className="text-white text-2xl font-thin mr-10">
            Username
          </label>
          <input
            className="rounded-lg p-2 focus:outline-none"
            name="username"
            value={userObject.username}
            onChange={handleChange}
            required
            placeholder="Username"
          />
        </div>

        <button
          className="my-10 bg-gradient-to-tr from-primary-start to-primary-end shadow-xl hover:bg-opacity-70 text-white font-bold font-mono py-2 px-10 rounded-lg"
          onSubmit={handleSubmit}
        >
          Submit
        </button>
      </form>
    </div>
  );
}
