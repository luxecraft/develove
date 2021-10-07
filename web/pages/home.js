import React, { useState, useEffect } from "react";
import Image from "next/image";
import { supabase } from "../lib/supabase";
import { truncatePost } from "../lib/utils";

export default function Home() {
  const [posts, setPosts] = useState(null);
  const [loading, setLoading] = useState(true);

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
    console.log(posts);
  }, [posts]);

  return (
    <div>
      <div className="px-40 flex flex-col items-center justify-between">
        <h1 className="text-5xl font-bold font-mono text-white my-10">
          Good Morning 🌥&nbsp;🗞
        </h1>
        <div className="flex flex-row">
          {!loading
            ? posts.map((post, i) => {
                return (
                  <div
                    key={i}
                    className="bg-accentGray rounded-lg shadow-md mx-10 text-center"
                  >
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
                    <p className="text-white max-w-xs font-mono font-bold text-sm my-5">
                      {truncatePost(post.data)}
                    </p>
                    <div className="flex justify-center">
                      <div className="w-2/5 mb-10">
                        <span className="text-sm text-white font-medium font-mono bg-primary-end bg-opacity-50 border-primary-start border-2 rounded-full px-3 py-1 mx-2">
                          {post.tags[0]}
                        </span>
                      </div>
                    </div>
                  </div>
                );
              })
            : null}
        </div>
      </div>
    </div>
  );
}
