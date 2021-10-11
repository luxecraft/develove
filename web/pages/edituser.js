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
        tags: thisUser.tags.join(","),
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
    console.log(userObject);
    tagsToBeSent = userObject.tags.split(",");
    try {
      let res = await supabase
        .from("users")
        .update({
          fullName: userObject.fullName,
          tags: tagsToBeSent,
          username: userObject.username,
        })
        .match({ email: currentUser.email });
      console.log(res);

      if (res.error) {
        throw res.error;
      }
      toast.success("User Updated");
      router.push("/profile");
    } catch (error) {
      console.log(error);
      if (error.code == 23505) {
        toast.error("Username already taken");
      } else {
        toast.error("Something went wrong, check your details");
      }
    }
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
            <form
              className="text-left flex flex-col items-center mt-10 mx-20"
              onSubmit={handleSubmit}
            >
              <div className="my-5 flex flex-row justify-between w-full">
                <label className="text-black text-2xl font-thin mr-10">
                  Full Name (real or Fake)
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
              <div className="my-5 flex flex-row justify-between w-full">
                <label className="text-black text-2xl font-thin mr-10">
                  Your tags (separated by commas)
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
              <div className="my-5 flex flex-row justify-between w-full">
                <label className="text-black text-2xl font-thin mr-10">
                  Username (does <b>COOL</b> things to your dp)
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
                type="submit"
                className=" w-5/12 my-10 mx-5 bg-gradient-to-tr from-secondary-start to-secondary-end shadow-xl hover:bg-opacity-70 text-white font-bold font-mono py-2 px-10 rounded-lg"
              >
                Update
              </button>
              <button
                type="button"
                className=" w-5/12 mx-5 bg-gradient-to-tr from-danger-start to-danger-end shadow-xl hover:bg-opacity-70 text-white font-bold font-mono py-2 px-10 rounded-lg"
                onClick={() => router.push("/profile")}
              >
                Cancel
              </button>
            </form>
          </>
        ) : null}
      </div>
    </div>
  );
}
