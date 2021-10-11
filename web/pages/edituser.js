import React, { useEffect, useState } from "react";
import { useAuth } from "../lib/auth";
import { getCurrentUser, searchUsers, signOut } from "../lib/connection";
import Image from "next/image";
import { useRouter } from "next/dist/client/router";
import { supabase } from "../lib/supabase";
import toast from "react-hot-toast";

export default function EditUser() {
  const [thisUser, setThisUser] = useState(null);
  const { currentUser } = useAuth();
  const router = useRouter();

  useEffect(() => {
    if (currentUser) {
      searchUsers(currentUser.email).then((res) => {
        if (res == -1) {
          router.push("/onboarding");
        } else {
          getCurrentUser(currentUser.email).then((user) => {
            setThisUser(user);
          });
        }
      });
    } else {
      router.push("/signup");
    }
    console.log(currentUser);
  }, [currentUser, router]);

  const [userObject, setUserObject] = useState({
    fullName: "",
    tags: "",
    username: "",
  });

  useEffect(() => {
    if (thisUser) {
      setUserObject({
        fullName: thisUser.fullName,
        tags: thisUser.tags,
        username: thisUser.username,
      });
    }
  }, [thisUser]);

  const handleChange = (e) => {
    setUserObject({ ...userObject, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    let tagsToBeSent = [];
    tagsToBeSent = userObject.tags.split(",");

    await supabase
      .from("users")
      .update({
        fullName: userObject.fullName,
        tags: tagsToBeSent,
        username: userObject.username,
      })
      .match({ email: currentUser.email });
    toast.success("User Updated");
    router.push("/profile");
  };

  return (
    <div className="flex justify-center">
      <div className="mt-40 w-5/12 flex flex-col justify-center p-10 bg-gradient-to-br from-primary-start to-primary-end rounded-lg shadow-lg">
        {thisUser ? (
          <>
            <Image
              className="pr-20"
              src={
                "https://avatars.dicebear.com/api/miniavs/" +
                userObject.username +
                ".svg"
              }
              alt="Avatar"
              height="120"
              width="120"
            />
            <form className="text-center mt-10" onSubmit={handleSubmit}>
              <div className="my-5">
                <label className="text-black text-2xl font-thin mr-10">
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
                <label className="text-black text-2xl font-thin mr-10">
                  Your tags
                </label>
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
                <label className="text-black text-2xl font-thin mr-10">
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
                type="button"
                className="my-10 mx-5 bg-gradient-to-tr from-danger-start to-danger-end shadow-xl hover:bg-opacity-70 text-white font-bold font-mono py-2 px-10 rounded-lg"
                onClick={() => router.push("/profile")}
              >
                Cancel
              </button>

              <button
                type="submit"
                className="my-10 mx-5 bg-gradient-to-tr from-secondary-start to-secondary-end shadow-xl hover:bg-opacity-70 text-white font-bold font-mono py-2 px-10 rounded-lg"
              >
                Update
              </button>
            </form>
          </>
        ) : null}
      </div>
    </div>
  );
}
