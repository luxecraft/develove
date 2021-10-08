import React, { useState, useEffect } from "react";
import ReactMarkdown from "react-markdown";
import { Prism as SyntaxHighlighter } from "react-syntax-highlighter";
import { atomDark } from "react-syntax-highlighter/dist/cjs/styles/prism";
import { supabase } from "../../lib/supabase";
import { useRouter } from "next/router";

function PostDisplay() {
  const router = useRouter();
  const pid = router.query.pid;
  const [post, setPost] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function fetchPost() {
      if (post === null) {
        setLoading(true);
        const temPost = await supabase
          .from("posts")
          .select()
          .match({ pid: pid });
        setPost(temPost?.data?.length > 0 ? temPost.data[0] : null);
        setLoading(false);
      }
    }

    fetchPost();
  });

  return (
    <div>
      {!loading ? (
        <div className="flex flex-col items-center">
          <div className="w-2/3 m-3 px-10 py-3 flex justify-center text-white">
            <h1 className="font-bold text-5xl">{post?.title}</h1>
          </div>
          <div className="flex flex-row text-white">
            {post?.tags.map((tag, i) => {
              if (i < 4)
                return (
                  <span
                    key={i}
                    className="text-sm font-medium font-mono bg-primary-end bg-opacity-50 border-primary-start border-2 rounded-full px-3 py-1 mr-2"
                  >
                    {tag}
                  </span>
                );
            })}
          </div>
          <div className="rounded-lg w-2/3 m-3 p-10 outline-none bg-accentGray text-white shadow-sm">
            {post?.data ? (
              <ReactMarkdown
                components={{
                  code({ node, inline, className, children, ...props }) {
                    const match = /language-(\w+)/.exec(className || "");
                    return !inline && match ? (
                      <SyntaxHighlighter
                        // eslint-disable-next-line react/no-children-prop
                        children={String(children).replace(/\n$/, "")}
                        style={atomDark}
                        language={match[1]}
                        PreTag="div"
                        {...props}
                      />
                    ) : (
                      <code className={className} {...props}>
                        {children}
                      </code>
                    );
                  },
                }}
              >
                {post?.data}
              </ReactMarkdown>
            ) : (
              <p>No post found</p>
            )}
          </div>
        </div>
      ) : (
        <div></div>
      )}
    </div>
  );
}

export default PostDisplay;
