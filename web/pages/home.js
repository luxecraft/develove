import React, { useState, useEffect } from "react";
import Image from "next/image";
import { supabase } from "../lib/supabase";
import { getTimeOfDay, truncatePost } from "../lib/utils";
import Link from "next/link";
import { useAuth } from "../lib/auth";
import { useRouter } from "next/dist/client/router";

export default function Home() {
  const [posts, setPosts] = useState(null);
  const [loading, setLoading] = useState(true);
  const { currentUser } = useAuth();
  const router = useRouter();

  useEffect(() => {
    async function fetchPost() {
      if (posts === null) {
        setLoading(true);
        const temPost = await supabase.from("posts").select();
        console.log(temPost.data);
        setPosts(temPost.data);
        setLoading(false);
      } else {
        setLoading(false);
      }
    }

    fetchPost();
  }, [posts]);

  useEffect(() => {
    if (!currentUser) {
      router.push("/splash");
    }
  }, [currentUser, router]);

  useEffect(() => {
    console.log(posts);
  }, [posts]);

  return (
    <div>
      <div className="px-40 flex flex-col items-center justify-between">
        <div className="flex flex-row items-center justify-between ld:w-10/12 xl:w-1/2">
          <h1 className="md:text-lg lg:text-3xl xl:text-5xl font-bold font-mono text-white my-10 mx-10">
            {getTimeOfDay(new Date().getHours())} 🗞
          </h1>
          <button
            onClick={() => {
              router.push("/posts/edit");
            }}
            className="h-10 md:text-xs xl:text-md bg-gradient-to-tr from-primary-start to-primary-end shadow-xl hover:bg-opacity-70 text-white font-bold font-mono px-10 rounded-lg"
          >
            New Post
          </button>
        </div>

        <div className="flex flex-row flex-wrap">
          {!loading
            ? posts.map((post, i) => {
                return (
                  <Link key={i} href={`/posts/${post.pid}`} passHref>
                    <div className="bg-accentGray rounded-lg shadow-md mx-10 my-10 text-center cursor-pointer">
                      <Image
                        className="rounded-t-lg"
                        src={post.image}
                        alt={post.title}
                        height={200}
                        width={300}
                      />
                      <h1 className="text-white font-mono font-bold text-2xl my-5">
                        {post.title}
                      </h1>
                      <div className="flex justify-center">
                        <div className="w-2/5 mb-10">
                          <span className="text-sm text-white font-medium font-mono bg-primary-end bg-opacity-50 border-primary-start border-2 rounded-full px-3 py-1 mx-2">
                            {post.tags[0]}
                          </span>
                        </div>
                      </div>
                    </div>
                  </Link>
                );
              })
            : null}
        </div>
      </div>
    </div>
  );
}
