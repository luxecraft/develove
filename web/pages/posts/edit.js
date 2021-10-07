import { useState } from "react";
import { useForm } from "react-hook-form";
import { toast } from "react-hot-toast";
import ReactMarkdown from "react-markdown";
import { Prism as SyntaxHighlighter } from "react-syntax-highlighter";
import { atomDark } from "react-syntax-highlighter/dist/cjs/styles/prism";

function PostDisplay() {
  const { register, handleSubmit, reset, watch, formState } = useForm({
    mode: "onChange",
  });

  const [preview, setPreview] = useState(false);

  const { isDirty, isValid, errors } = formState;

  const updatePost = async ({ content, title }) => {
    console.log(content, title);

    reset({ content, title });

    toast.success("Created Post successfully");
  };

  return (
    <div>
      <form onSubmit={handleSubmit(updatePost)} className="">
        {preview && (
          <div className="flex flex-col items-center">
            <div className="w-2/3 m-3 px-10 py-3 rounded-lg outline-none bg-accentGray text-white shadow-sm">
              <h3>{watch("title")}</h3>
            </div>
            <div className="rounded-lg w-2/3 m-3 p-10 outline-none bg-accentGray text-white shadow-sm">
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
                {watch("content")}
              </ReactMarkdown>
            </div>
            <div className="w-2/3 flex flex-row">
              <button
                type="submit"
                className="bg-primary-solid m-3 p-3 w-1/2 rounded-lg shadow-sm"
                disabled={!isValid || !isDirty}
              >
                Save Changes
              </button>
              <button
                type="button"
                className=" bg-primary-solid m-3 p-3 w-1/2 rounded-lg shadow-sm"
                onClick={() => setPreview(!preview)}
              >
                {preview ? "Edit" : "Preview"}
              </button>
            </div>
          </div>
        )}
        <div className={preview ? "hidden" : "flex flex-col items-center"}>
          <input
            type="text"
            className="w-2/3 m-3 px-10 py-3 rounded-lg outline-none bg-accentGray text-white shadow-sm"
            name="title"
            {...register("title", {
              required: { value: true, message: "Title is required" },
            })}
          />
          <textarea
            className="rounded-lg w-2/3 m-3 p-10 outline-none bg-accentGray text-white shadow-sm"
            rows="10"
            name="content"
            {...register("content", {
              maxLength: { value: 2000, message: "Content is too long" },
              minLength: { value: 10, message: "Content is too small" },
              required: { value: true, message: "Content is required" },
            })}
          ></textarea>
          {errors.content && (
            <p className=" text-white">{errors.content.message}</p>
          )}
          <div className="w-2/3 flex flex-row">
            <button
              type="submit"
              className="bg-primary-solid m-3 p-3 w-1/2 rounded-lg shadow-sm"
              disabled={!isValid || !isDirty}
            >
              Save Changes
            </button>
            <button
              type="button"
              className=" bg-primary-solid m-3 p-3 w-1/2 rounded-lg shadow-sm"
              onClick={() => setPreview(!preview)}
            >
              {preview ? "Edit" : "Preview"}
            </button>
          </div>
        </div>
      </form>
    </div>
  );
}

export default PostDisplay;
